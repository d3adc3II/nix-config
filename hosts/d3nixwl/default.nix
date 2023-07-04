{ config, ... }@args:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/core-desktop-wl.nix
    ../../modules/nixos/hyprland.nix
    ../../modules/nixos/user-group.nix
    ../../modules/zsh
    ../../modules/git


  ];
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi"; # use the same mount point here 
    };
    systemd-boot.enable = true;
  };

  networking = {
    hostName = "d3nixpc"; # Define your hostname.
    wireless.enable = false;
    networkmanager.enable = true;
  };
  # Nvidia GPU
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
  package = config.boot.kernelPackages.nvidiaPackages.beta;
  modesetting.enable = true;
  };
  hardware.opengl = {
    enable = true;
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };


  system.stateVersion = "23.05"; # Did you read the comment?


  }
