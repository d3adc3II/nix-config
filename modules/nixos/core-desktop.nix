{ lib, pkgs, ... }:

{
    security.pam.loginLimits = [{
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "4096";
  }];
  
  # for nix server, we do not need to keep too much generations
  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 10;
  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 1w";
  };

  # Manual optimise storage: nix-store --optimise
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;

  # enable flakes globally
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings.trusted-users = ["d3"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = lib.mkDefault true;
  
  # Set your time zone
  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "en_SG.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_SG.UTF-8";
    LC_IDENTIFICATION = "en_SG.UTF-8";
    LC_MEASUREMENT = "en_SG.UTF-8";
    LC_MONETARY = "en_SG.UTF-8";
    LC_NAME = "en_SG.UTF-8";
    LC_NUMERIC = "en_SG.UTF-8";
    LC_PAPER = "en_SG.UTF-8";
    LC_TELEPHONE = "en_SG.UTF-8";
    LC_TIME = "en_SG.UTF-8";
  };

  # Enable CUPS to print documents.
    #services.printing.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = lib.mkDefault false;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };

  # Enable sound with pipewire.
  services.pipewire = {
    enable = true;
    alsa.enable = false;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  sound.enable = false;
  # Disable pulseaudio, it conflicts with pipewire too.
  hardware.pulseaudio.enable = false;
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  #services.gnome.gnome-keyring.enable = true;
  #security.pam.services.greetd.enableGnomeKeyring = true;
  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  environment.systemPackages = with pkgs; [
   # neovim 
    wget
    curl
    git
    cachix
    ((vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: {
      src = (builtins.fetchTarball {
        url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
        # you need to update this sha256 every time you update vscode insiders
        # the latest sha256 is printed in the error message of `sudo nixos-rebuild switch`
        sha256 = "sha256:1dbh4i60k6dm2d07dbqakygnbf09z0s0ra0cq2b2jwqnwmzz1lrn";
      });
      version = "latest";
    }))
  ];
  # dconf is a low-level configuration system.
  programs.dconf.enable = true;
  # Allow unfree packages
  #nixpkgs.config.allowUnfree = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # Sets environment variable NIXOS_XDG_OPEN_USE_PORTAL to 1
    # This will make xdg-open use the portal to open programs,
    # which resolves bugs involving programs opening inside FHS envs or with unexpected env vars set from wrappers.
    # xdg-open is used by almost all programs to open a unknown file/uri
    # alacritty as an example, it use xdg-open as default, but you can also custom this behavior
    # and vscode has open like `External Uri Openers`
    xdgOpenUsePortal = false;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr # for wlroots based compositors(hyprland/sway)
      xdg-desktop-portal-gtk # for gtk
      # xdg-desktop-portal-kde  # for kde
    ];
  };
  # add user's shell into /etc/shells
  environment.shells = with pkgs; [
    bash
    zsh
  ];
  # set user's default shell system-wide
  users.defaultUserShell = pkgs.zsh;  
}