{ config, pkgs, ... }:

{

  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "25.11";

  imports = [
    ./packages.nix
    ./gtk.nix
    ./qt.nix
    ./thunar.nix
    ./wezterm.nix
    ./firefox.nix
    ./git.nix
    ../../modules/kde-env.nix
    ./xdg.nix
    ./services.nix
  ];

  # ---------------------------------------------------------------------------
  # Force-overwrite legacy files so Home Manager can fully manage your desktop
  # ---------------------------------------------------------------------------

  xdg.configFile."user-dirs.dirs".force = true;
  xdg.configFile."gtk-4.0/gtk.css".force = true;
  xdg.configFile."gtk-4.0/settings.ini".force = true;
  xdg.configFile."gtk-3.0/settings.ini".force = true;

}
