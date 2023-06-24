{ inputs, config, pkgs, ... }:
{
  home.stateVersion = "22.11";
  imports = [
    # gui
    ./firefox
    ./zsh
    ./hyprland
    # cli 
    ./zsh
    ./git
    # system 
    ./xdg
    ./packages

  ];
  # Packages that should be installed to the user profile.


}