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
    zsh-powerlevel10k
    zplug
    oh-my-zsh
  ];
  #programs.zsh.zplug.enable =  true;
  #:wprograms.zsh.zsh-powerlevel10k.enable =  true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      theme = "superjarin";
      plugins = [
        "direnv"
      ];
    };
    #plugins = [
    #  { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
    #  { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
    #];
  # Alias for zsh  
    shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch";
    gac = "git add . && git commit -m";
    gp = "git push origin";
  #home.file.".config/oh-my-zsh/themes/af-no-magic.zsh-theme".source = ./af-no-magic.zsh-theme;
  };
  history = {
    size = 10000;
    path = "${config.xdg.dataHome}/zsh/history";
  };
};

  # Shell configuations
  environment.shells = with pkgs; [
    zsh
  ];


}