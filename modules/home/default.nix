{ config, pkgs, inputs, username, ... }:

{

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11";

  imports = [
    ./bash.nix
    ./btop.nix
    ./cava.nix
    ./fastfetch.nix
    ./firefox.nix
    ./fish.nix
    ./git.nix
    ./kitty.nix
    #./nixvim.nix
    ./packages.nix
    ./services.nix
    ./tmux.nix
    ./vscode.nix
    ./xdg.nix
    ./zathura.nix
  ];

}
