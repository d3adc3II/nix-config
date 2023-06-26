{ config, pkgs, lib, ... }:
{
  imports = [
    #./hardware-configuration.nix
    #./user-group.nix
    ../../modules/default.nix
  ];
  config.modules = {
    #gui
    #firefox.enable = true;
    #foot.enable = true;
    hyprland.enable = true;
    #wofi.enable = true;
    #cli
    #nvim.enable = true;
    zsh.enable = true;
    git.enable = true;
    #system
    xdg.enable = true;
    packages.enable = true;
  };
}

  #services.xserver.videoDrivers = ["nvidia"];  
  
  # Nvidia GPU
 # hardware.nvidia = {
  #  package = config.boot.kernelPackages.nvidiaPackages.beta; 
   # modesetting.enable = true;
  #};
  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway

  # Enable the KDE Plasma Desktop Environment.
#  services.xserver.displayManager.sddm.enable = true;
 # services.xserver.desktopManager.plasma5.enable = true;
  
  # Fcitx5
 # i18n.inputMethod = {
 #   enabled = "fcitx5";
  #  enabled = "ibus";
  #  ibus.engines = with pkgs.ibus-engines; [ libpinyin ];
 #   fcitx5.addons = with pkgs; [
 #       fcitx5-unikey
 #       fcitx5-gtk
 #       fcitx5-configtool
 #   ];
#};

  # X11 Configurations
#  services.xserver = {
 #   enable = true;
  #  layout = "us";
   # xkbVariant = "";
  #};
  # set cursor size and dpi for 4k monitor
 # xresources.properties = {
 #   "Xcursor.size" = 16;
 #   "Xft.dpi" = 172;
 # };


  # Enable One Drive
  #services.onedrive.enable = true;

#  system.stateVersion = "22.11"; # Did you read the comment?


#  }

  

