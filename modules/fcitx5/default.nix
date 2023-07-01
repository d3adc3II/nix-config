{ pkgs, config, lib, ... }: {

  home.file.".config/fcitx5/profile".source = ./profile;
  home.file.".config/fcitx5/profile-bak".source = ./profile; # used for backup

  # every time fcitx5 switch input method, it will modify ~/.config/fcitx5/profile file, 
  # which will override my config managed by home-manager
  # so we need to remove it before everytime we rebuild the config
  home.activation.removeExistingFcitx5Profile = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    rm -f "${config.xdg.configHome}/fcitx5/profile"
  '';

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      # for flypy chinese input method
      #fcitx5-rime
      # needed enable rime using configtool after installed
      fcitx5-configtool
      fcitx5-unikey
      # fcitx5-mozc    # japanese input method
      fcitx5-gtk # gtk im module
    ];
  };

  systemd.user.sessionVariables = {
    # copy from  https://github.com/nix-community/home-manager/blob/master/modules/i18n/input-method/fcitx5.nix
    GLFW_IM_MODULE = "fcitx";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    INPUT_METHOD = "fcitx";
    IMSETTINGS_MODULE = "fcitx";
  };
}