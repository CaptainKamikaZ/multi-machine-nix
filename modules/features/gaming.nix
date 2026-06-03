{ config, pkgs, lib, ... }:

{
  config = lib.mkIf config.features.gaming.enable {
    home-manager.users.justin.home.packages = with pkgs; [
      prismlauncher
    ];
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}