{config, pkgs, ...}:

{
  imports = [
    ../../home/packages/shell.nix
    
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.d3 = {
    isNormalUser = true;
    description = "d3";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

}