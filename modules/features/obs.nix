{ config, pkgs, lib, ... }:

{
  config = lib.mkIf config.features.obs.enable {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      package = pkgs.obs-studio.override { cudaSupport = true; };
      plugins = with pkgs.obs-studio-plugins; [
        obs-move-transition
        obs-transition-table
        obs-pipewire-audio-capture
      ];
    };
    environment.systemPackages = with pkgs; [
      obs-cmd
      v4l-utils
    ];
    security.polkit.enable = true;

    boot.kernelModules = [ "v4l2loopback" ];
    boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Virtual Camera" exclusive_caps=1
    '';
  };
}
