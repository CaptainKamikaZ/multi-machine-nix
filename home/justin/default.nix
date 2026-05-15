{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./gtk.nix
    ./qt.nix
    ./thunar.nix
    ./wezterm.nix
    ./firefox.nix
    ./git.nix
    ./xdg.nix
    ./services.nix
  ];

  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "25.11";
}
