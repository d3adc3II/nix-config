{ pkgs, ... }:
{
  imports = [
    ./alacritty
    ./
    #./creative.nix
    #./media.nix
  ];

  home.packages = with pkgs; [
    # GUI apps

    # instant messaging
    telegram-desktop
    discord
    # misc
    flameshot
  ];

  # GitHub CLI tool
  programs.gh = {
    enable = true;
  };
}