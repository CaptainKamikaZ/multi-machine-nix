{ config, pkgs, lib, username, ... }:

{
  config = lib.mkIf config.features.audiotools.enable {

    home-manager.users.${username} = {

      home.packages = with pkgs; [
        easyeffects
        helvum
      ];
    };
  };
}
