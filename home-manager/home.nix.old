{ config, pkgs, lib, ... }:

let
  # Import the same Nixpkgs your system uses
  unstablePkgs = import <nixos-unstable> { };
in

{
  nixpkgs.config.allowUnfree = true;

  ############################################################
  # Basic Home Manager settings
  ############################################################
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  ############################################################
  # User Packages
  ############################################################
  home.packages = with pkgs; [
    # CLI tools
    fastfetch
    htop
    lm_sensors
    slurp

    # GUI apps (user-level)
    audacity
    discord
    easyeffects
    filezilla
    gimp
    helvum
    kdePackages.kate
    obsidian
    onlyoffice-desktopeditors
    thunderbird
    vscode
    wezterm
  ];

  ############################################################
  # Dotfiles & Config Files
  ############################################################

  # GTK
  qt = {
    enable = true;
    style = {
      name = "adwaita-dark";
    };
  };

  # Niri (user session)
  xdg.configFile."niri/config.kdl" = {
    source = ./config.kdl;
    force = true;
  };

  # WezTerm
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };

  ############################################################
  # User Services (systemd --user)
  ############################################################
  systemd.user.services.polkit-agent = {
    Unit = {
      Description = "Polkit Authentication Agent";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };


  ############################################################
  # XDG Base Directory Support
  ############################################################
  xdg.enable = true;
  xdg.configFile."quickshell/noctalia-shell".source =
    "${unstablePkgs.noctalia-shell}/share/noctalia-shell";

  ############################################################
  # Shell
  ############################################################
  programs.bash.enable = true;

  ############################################################
  # Firefox
  ############################################################
  programs.firefox.enable = true;

  ############################################################
  # Git
  ############################################################
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Justin Gabrielson";
        email = "justingabrielson@hotmail.com";
      };
    };
  };
}
