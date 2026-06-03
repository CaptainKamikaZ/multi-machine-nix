{ config, pkgs, lib, ... }:

{
  config = lib.mkIf config.features.audiotools.enable {
    home-manager.users.justin.home.packages = with pkgs; [
      easyeffects
      helvum
    ];
  };
}
