{ config, pkgs, helix, ... }:
{
  imports = [
    ./modules/zsh.nix
    
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [ 
    htop
    btop
    nvtop
    nnn
    neofetch
    aria2
    kitty
    alacritty
    zsh
    brave
    firefox
    vscode
    obsidian
    telegram-desktop
    discord
    zsh-powerlevel10k
    zplug
    oh-my-zsh
    #fcitx5-with-addons
    fcitx5-unikey
    thefuck
    zsh-autosuggestions
    zoxide
  # Networking tools
    mtr 
    iperf3
    nmap
    socat
        
  ];

}