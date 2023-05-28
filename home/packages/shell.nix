{ config, pkgs, helix, ... }:
{

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [ 
    htop
    btop
    kitty
    brave
    firefox
    vscode
    git
    
  ];





}