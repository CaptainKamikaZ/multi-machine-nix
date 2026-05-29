{ config, pkgs, ... }:

{

  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "25.11";

  imports = [
    ./bash.nix
    ./firefox.nix
    ./fish.nix
    ./git.nix
    ./gtk.nix
    ./kitty.nix
    ./packages.nix
    ./qt.nix
    ./services.nix
    ./thunar.nix
    ./tmux.nix
    ./wezterm.nix
    ./xdg.nix

    ../../features/niri/niri.nix
  ];

  # ---------------------------------------------------------------------------
  # Force-overwrite legacy files so Home Manager can fully manage your desktop
  # ---------------------------------------------------------------------------

  xdg.configFile."user-dirs.dirs".force = true;
  xdg.configFile."gtk-4.0/gtk.css".force = true;
  xdg.configFile."gtk-4.0/settings.ini".force = true;
  xdg.configFile."gtk-3.0/settings.ini".force = true;

}
