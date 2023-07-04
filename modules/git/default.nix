{ config
, lib
, pkgs
, ...
}: {
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  #home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
  #  rm -f ~/.gitconfig
 # '';

  programs.git = {
    enable = true;
    userName = "d3adc3II";
    #userEmail = "phong.dinh@outlook.com";
   
    };
}
