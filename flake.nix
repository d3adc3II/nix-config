{
  description = "D3's NixOS Flake";

  # inputs` are the dependencies of the flake.
  # `outputs` function will return all the build results of the flake. 
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {

    # Official NixOS package source, using nixos-unstable branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";

    # Home Manager Input
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # `outputs` are all the build result of the flake. 
  # A flake can have many use cases and different types of outputs.
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names. 
  # However, `self` is an exception, This special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  #outputs = { self, nixpkgs, ... }@inputs: {
  # By default, NixOS will try to refer the nixosConfiguration with its hostname.
  # so the system named `nixos-test` will use this configuration.
  # However, the configuration name can also be specified using `sudo nixos-rebuild switch --flake /path/to/flakes/directory#<name>`.
  # The `nixpkgs.lib.nixosSystem` function is used to build this configuration, the following attribute set is its parameter.
  # Run `sudo nixos-rebuild switch --flake .#nixos-test` in the flake's directory to deploy this configuration on any NixOS system
  # Test Config machine
  # nixos-test = nixpkgs.lib.nixosSystem {
  #   system = "x86_64-linux";
  #   specialArgs = inputs;
  #   modules = [
  #     ./configuration.nix
  #   ];
  # };
 
  # Main nixos config
  outputs = { nixpkgs, home-manager, nur, ... }@inputs:   
    let 
      system = "x86_64-linux"; #current system
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      lib = nixpkgs.lib;
      
      # This lets us reuse the code to "create" a system
      # Credits go to sioodmy on this one!
      # https://github.com/sioodmy/dotfiles/blob/main/flake.nix
      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            { networking.hostName = hostname; }
            ./modules/system/configuration.nix
            # General configuration (users,networking, sound, etc)
            (./. + "/hosts/${hostname}/hardware-configuration.nix")
            home-manger.nixosModules.home-manger
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit inputs; };
                # Home manager config ( configure program like firefox,zsh, eww, etc)
                users.notus = (./. + "/hosts/${hostname}/user.nix");
              };
            }            
          ];
          specialArgs = { inherit inputs; };
        }; 
        in {
            nixosConfigurations = {
                # Now, defining a new system is can be done in one line
                #                                Architecture   Hostname
                d3nixpc = mkSystem inputs.nixpkgs "x86_64-linux" "d3nixpc";
                d3nixpcwl = mkSystem inputs.nixpkgs "x86_64-linux" "d3nixpcwl";
            };
        };
  }


