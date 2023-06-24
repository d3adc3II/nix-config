{ config, pkgs, helix,lib, home-manager, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    #./user-group.nix
  ];

  services.xserver.videoDrivers = ["nvidia"];  
  
  # Nvidia GPU
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta; 
    modesetting.enable = true;
  };
  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  
  # Fcitx5
  i18n.inputMethod = {
    enabled = "fcitx5";
  #  enabled = "ibus";
  #  ibus.engines = with pkgs.ibus-engines; [ libpinyin ];
    fcitx5.addons = with pkgs; [
        fcitx5-unikey
        fcitx5-gtk
        fcitx5-configtool
    ];
};

  # X11 Configurations
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
  };
  # set cursor size and dpi for 4k monitor
 # xresources.properties = {
 #   "Xcursor.size" = 16;
 #   "Xft.dpi" = 172;
 # };


  # Enable One Drive
  services.onedrive.enable = true;

  system.stateVersion = "22.11"; # Did you read the comment?


  }

  

