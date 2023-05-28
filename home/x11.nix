{ config, pkgs, ... }:

{
  imports = [
    ./packages/shell.nix
    ./packages/common.nix
    
  ];

  home = {
    username = "d3";
    homeDirectory = "/home/d3";
    stateVersion = "22.11";

  };


  # link the configuration file in current directory to the specified location in Home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "d3adc3II";
    userEmail = "ph0ngdinh@proton.com";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
  };

programs.bash.shellAliases = {
  gac = "git add . && git commit -m";
  gp = "git push origin";
  nrb = " sudo nixos-rebuild switch"; 
  ll = "ls -l";
  ls = "ls --color=tty";
};

  # enable starship, a beautiful shell prompt
  #programs.starship = {
  #  enable = true;
  #  settings = {
  #    add_newline = false;
  #    aws.disabled = true;
  #    gcloud.disabled = true;
  #    line_break.disabled = true;
  #  };
  #};

  # alacritty terminal emulator
  #programs.alacritty = {
  #  enable = true;
      #env.TERM = "xterm-256color";
  #    font = {
  #      size = 12;
  #      draw_bold_text_with_bright_colors = true;
  #    };
  #    scrolling.multiplier = 5;
  #    selection.save_to_clipboard = true;
  #};

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
