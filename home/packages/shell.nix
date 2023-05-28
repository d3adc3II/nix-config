{ config, pkgs, helix, ... }:
{

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [ 
    kitty
    alacritty
    brave
    firefox
    vscode
    obsidian
    telegram-desktop
    discord 
    
  ];





}