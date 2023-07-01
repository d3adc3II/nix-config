{ pkgs, ... }:

{
  home.packages = with pkgs; [
    #neofetch
    #nnn # terminal file manager
    zsh
    brave
    telegram-desktop
    discord
    fcitx5-unikey
    alacritty
    neovim
    neofetch
    # archives
    #zip
    #xz
    #unzip
    #p7zip

    # utils
    #ripgrep # recursively searches directories for a regex pattern
    #jq # A lightweight and flexible command-line JSON processor
    #yq-go # yaml processer https://github.com/mikefarah/yq
    #exa # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    
    # networking tools
    #mtr # A network diagnostic tool
    #iperf3
    #dnsutils  # `dig` + `nslookup`
    #ldns # replacement of `dig`, it provide the command `drill`
    #aria2 # A lightweight multi-protocol & multi-source command-line download utility
    #socat # replacement of openbsd-netcat
    #nmap # A utility for network discovery and security auditing
    #ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    #cowsay
    #file
    #which
    #tree
    #gnused
    #gnutar
    #gawk
    #zstd
    #caddy
    #gnupg

    # nix related
    # 
    # it provides the command `nom` works just like `nix
    # with more details log output
    #nix-output-monitor

    # productivity
    #hugo # static site generator
    #glow # markdown previewer in terminal
  ];

}