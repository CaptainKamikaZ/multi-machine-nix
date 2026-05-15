{ config, pkgs, lib, ... }:

#let unstablePkgs = pkgs; in
{

  imports = [
    ./modules/kde-env.nix
  ];

  ############################################################
  # Basic Home Manager settings
  ############################################################
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.sessionVariables = {
    GTK_THEME = "Breeze-Dark";
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

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
    brave
    discord
    easyeffects
    filezilla
    gimp
    helvum
    kdePackages.kate
    kdePackages.kdenlive
    nextcloud-client
    obsidian
    onlyoffice-desktopeditors
    prismlauncher
    protonup-qt
    thunderbird
    vlc
    vscode
    wezterm
    xfce.thunar
    xfce.thunar-volman
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
  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
  };

  # Niri (user session)
  xdg.configFile."niri/config.kdl" = {
    source = ./home-manager/config.kdl;
    force = true;
  };

  # Thunar
  xdg.configFile = {
    "Thunar/accels.scm".source = ./home-manager/thunar/accels.scm;
    "Thunar/uca.xml" = {
      source = ./home-manager/thunar/uca.xml;
      force = true;
    };
  };
  xdg.configFile."gtk-3.0/bookmarks" = {
    text = ''
      file:///home/justin/Downloads
      file:///home/justin/Nextcloud/Documents
      file:///home/justin/Nextcloud/Photos
      file:///home/justin/Videos
      file:///home/justin/Nextcloud/Livestream%20Assets
      file:///mnt/share/data/foundry
      file:///mnt/STORAGE
      file:///mnt/STORAGE2
      file:///mnt/STORAGE3
    '';
    force = true;
  };

  # WezTerm
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./home-manager/wezterm.lua;
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
    "${pkgs.noctalia}/share/noctalia-shell";

  xdg.mimeApps.defaultApplications = {
    "application/x-terminal-emulator" = "wezterm.desktop";
    "TerminalEmulator" = "wezterm.desktop";
  };

  xdg.userDirs = {
    enable = true;
    desktop = null;
  };

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
