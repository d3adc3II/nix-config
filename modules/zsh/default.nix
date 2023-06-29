 { config, lib, pkgs, ... }:
{
  #environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    dotDir = ".config/zsh";
    oh-my-zsh = {
      enable = true;
      theme = "superjarin";
      plugins = [
        "direnv"
        #"zsh-autosuggestions"
        "zoxide"
        "thefuck"
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
    tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'";

  #home.file.".config/oh-my-zsh/themes/af-no-magic.zsh-theme".source = ./af-no-magic.zsh-theme;
  };
  history = {
    size = 10000;
    path = "${config.xdg.dataHome}/zsh/history";
  };
};
}