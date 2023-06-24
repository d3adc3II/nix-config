{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.zsh

in {
    options.modules.zsh = { enable = mkEnableOption "zsh"; };

    config = mkIf cfg.enable {
    	home.packages = [
	    pkgs.zsh
	];

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
};
}