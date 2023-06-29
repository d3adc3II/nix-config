{ config, pkgs, ... }:

{
  imports = [
    ../modules/desktop
    
    
  ];
  home = {
    username = "d3";
    homeDirectory = "/home/d3";
    stateVersion = "22.11";

  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}