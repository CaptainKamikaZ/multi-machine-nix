{ config, pkgs, lib, username, ... }:

{
  config = lib.mkIf config.features.gaming.enable {
    home-manager.users.${username}.home.packages = with pkgs; [
      prismlauncher
    ];
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}