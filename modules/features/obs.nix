{ config, pkgs, lib, ... }:

{
  config = lib.mkIf config.features.obs.enable {
    programs.obs-studio = {
      enable = true;
      package = pkgs.obs-studio.override { cudaSupport = true; };
      plugins = with pkgs.obs-studio-plugins; [
        obs-move-transition
        obs-transition-table
        obs-pipewire-audio-capture
      ];
    };
    environment.systemPackages = with pkgs; [
      obs-cmd
    ];
  };
}
