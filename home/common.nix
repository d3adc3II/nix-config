{ config, pkgs, helix, ... }:
{

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [ 
    htop
    btop
    nvtop
    nnn
    neofetch
    aria2

  # Networking tools
    mtr 
    iperf3
    nmap
    socat
        
  ];





}