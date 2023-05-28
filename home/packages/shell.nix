{ config, pkgs, ... }:
{

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [ 
    htop
    btop
    kitty
    brave
    firefox
    vscode
  ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    wget
    git
    cachix
    # install helix from flake input `helix`
    helix.packages."${pkgs.system}".helix
    gitAndTools.gitFull
  ];





}