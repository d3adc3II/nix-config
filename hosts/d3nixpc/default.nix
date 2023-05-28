{ config, pkgs, helix, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./core-desktop.nix
    ./user-group.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Networking
  networking = {
    hostName = "d3nixpc"; # Define your hostname.
    wireless.enable = false;
    networkmanager.enable = true;
  };
  # Nvidia GPU
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
  hardware.nvidia.modesetting.enable = true;
  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;


  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };


  system.stateVersion = "22.11"; # Did you read the comment?


  }
