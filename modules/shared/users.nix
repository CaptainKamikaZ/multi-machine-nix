{ config, pkgs, lib, ... }:

{
  users.users.justin = {
    isNormalUser = true;
    home = "/home/justin";
    description = "Justin Gabrielson";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
    ];
    shell = pkgs.bashInteractive;
  };
}
