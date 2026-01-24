{ config, pkgs, lib, ... }:

{
  ############################################################
  # Basic Home Manager settings
  ############################################################
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  ############################################################
  # Packages installed for your user
  ############################################################
  home.packages = with pkgs; [
    dejavu_fonts
    fastfetch
    htop
    lm_sensors
    slurp
  ];


  ############################################################
  # XDG base directory support (recommended)
  ############################################################
  xdg.enable = true;

  ############################################################
  # Shell configuration (optional)
  ############################################################
  programs.bash.enable = true;
  programs.firefox.enable = true;

  ############################################################
  # Git configuration (optional)
  ############################################################
  programs.git.settings = {
    enable = true;
    user.name = "Justin Gabrielson";
    user.email = "justingabrielson@hotmail.com";
  };

}

