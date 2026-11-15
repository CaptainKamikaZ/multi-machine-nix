{ config, pkgs, inputs, username, ... }:

{

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11";

  imports = [
    ./bash.nix
    ./btop.nix
    ./fastfetch.nix
    ./fish.nix
    ./git.nix
    ./packages.nix
    ./services.nix
    ./tmux.nix
    ./xdg.nix
    ./zathura.nix
  ];

}
