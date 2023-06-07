{ config, pkgs, ... }:
{
  home.stateVersion = "22.11";
  imports = [
    ./packages
    ./zsh
    #./xdg
   # ./hyprland

  ];
  # Packages that should be installed to the user profile.


}