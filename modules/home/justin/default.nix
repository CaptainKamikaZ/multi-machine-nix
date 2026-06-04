{ config, pkgs, inputs, ... }:

{

  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "25.11";

  imports = [
    ./bash.nix
    ./btop.nix
    ./cava.nix
    ./firefox.nix
    ./fish.nix
    ./git.nix
    ./gtk.nix
    ./kitty.nix
    ./niri.nix
    #./nixvim.nix
    ./noctalia.nix
    ./packages.nix
    ./qt.nix
    ./services.nix
    ./thunar.nix
    ./tmux.nix
    #./wezterm.nix
    ./xdg.nix
    ./zathura.nix
  ];

}
