{ config, pkgs, helix, ... }:
{

  # Packages that should be installed to the user profile. Test.
  home.packages = with pkgs; [ 
    kitty
    alacritty
    zsh
    brave
    firefox
    vscode
    obsidian
    telegram-desktop
    discord

    
  ];

  programs.zsh = {
    enable = true;
    plugins = [
      { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
      { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
    ];
  # Alias for zsh  
    shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch";
    gac = "git add . && git commit -m";
    gp = "git push origin";

  };
  history = {
    size = 10000;
    path = "${config.xdg.dataHome}/zsh/history";
  };
};




}