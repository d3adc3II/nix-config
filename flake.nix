{
  description = "D3's NixOS Flake";

  # inputs` are the dependencies of the flake.
  # `outputs` function will return all the build results of the flake. 
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];

    substituters = [
      # replace official cache with a mirror located in China
      "https://nix-community.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
  };
  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
  # Many ways to reference flake inputs. The most widely used is github:owner/name/reference,
  # which represents the GitHub repository URL + branch/commit-id/tag.
  # Official NixOS package source, using nixos-unstable branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";

    # Home Manager Input
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # modern window compositor
    hyprland.url = "github:hyprwm/Hyprland/v0.25.0";
    # community wayland nixpkgs
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
  };

    # generate iso/qcow2/docker/... image from nixos configuration
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  # The `outputs` function will return all the build results of the flake. 
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names. 
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  # Main nixos config
  outputs = inputs@{ self, nixpkgs, home-manager, nixos-generators ... }:
    let 
      x64_system = "x86_64-linux";
      x64_specialArgs = {
        # use unstable branch for some packages to get the latest updates
        pkgs-unstable = import inputs.nixpkgs-unstable {
          system = x64_system; # refer the `system` parameter form outer scope recursively
          # To use chrome, we need to allow the installation of non-free software
          config.allowUnfree = true;
        };
      } // inputs;
      d3pc_module = [
        ./hosts/d3nixpc

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = x64_specialArgs;
          home-manager.users.d3 = import ./home/x11.nix;
        }
      ];
      d3lt_module = [
        ./hosts/d3nixlt

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = x64_specialArgs;
          home-manager.users.d3 = import ./home/linux/server.nix;
        }
      ];
    in {
      nixosConfigurations = let system = x64_system; specialArgs = x64_specialArgs; in {
        d3nixpc = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = d3pc_module;
        };

        d3nixlt = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = d3lt_module;
        };
      };

      formatter = {
        x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      };

      packages.x86_64-linux = 
        # take images for idols
        #   https://github.com/nix-community/nixos-generators
        let system = x64_system; specialArgs = x64_specialArgs; in  {
        d3nixpc = nixos-generators.nixosGenerate {
          inherit system specialArgs;
          modules = d3pc_modules;
          format = "iso";
        };
        # Hoshino Aquamarine is a virtual machine running on Proxmox VE.
        d3nixlt = nixos-generators.nixosGenerate {
          inherit system specialArgs;
          modules = d3lt_modules;
          format = "iso";
        };
      };
    };
}
