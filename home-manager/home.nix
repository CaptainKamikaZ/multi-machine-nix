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
    conky
    dejavu_fonts
    fastfetch
    htop
    lm_sensors
    slurp
  ];

  ############################################################
  # Conky configuration
  ############################################################

  # This assumes you place conky.conf next to this home.nix file
  xdg.configFile."conky/conky.conf".source = ./conky.conf;

  # Autostart Conky in KDE Plasma
  xdg.autostart.enable = true;
  
  home.file.".config/autostart/conky.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Exec=conky --daemonize
    Hidden=false
    NoDisplay=false
    X-GNOME-Autostart-enabled=true
    Name=Conky
    Comment=Start Conky system monitor
  '';
  home.file.".local/share/fonts/Neon.ttf".source = ./Neon.ttf;  
  home.file.".local/share/fonts/ConkySymbols.ttf".source = ./ConkySymbols.ttf;


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

