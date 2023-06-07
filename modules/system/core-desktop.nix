{ config, pkgs, inputs, ... }:
{
  # enable flakes globally
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Boot settings: clean /tmp/, latest kernel and enable bootloader
    boot = {
      loader = {
      systemd-boot.enable = true;  # done
      efi.canTouchEfiVariables = true; # done
      efi.efiSysMountPoint = "/boot/efi";
      };
    };






    # Remove unecessary preinstalled packages
    #environment.defaultPackages = [ ];
  environment.systemPackages = with pkgs; [
    neovim 
    wget
    git
    cachix
  # install helix from flake input `helix`
    helix.packages."${pkgs.system}".helix
  #  gitAndTools.gitFull
  ];
  # Shell configuations
  environment.shells = with pkgs; [
    zsh
  ];
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
# Wayland stuff: enable XDG integration, allow sway to use brillo
    xdg = {
        portal = {
            enable = true;
            extraPortals = with pkgs; [
                xdg-desktop-portal-wlr
                xdg-desktop-portal-gtk
            ];
            gtkUsePortal = true;
        };
    };
  programs.dconf.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };



  # Set local timezone and keyboard layout
  time.timeZone = "Asia/Singapore";

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

  # Networking
  networking = {
    hostName = "d3nixpc"; # Define your hostname.
    wireless.enable = false;
    networkmanager.enable = true;
  };
  # Disable bluetooth, enable pulseaudio, enable opengl (for Wayland)
  hardware = {
    bluetooth.enable = false;
    opengl = {
      enable = true;
      driSupport = true;
    };
    };
   # Set environment variables
  #environment.variables = {
  #  NIXOS_CONFIG = "$HOME/nix-config/configuration.nix";
  #  NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
  #};
}