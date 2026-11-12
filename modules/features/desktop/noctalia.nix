# modules/features/desktop/noctalia.nix
{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;
    settings = {
      theme = {
        mode = "dark";
      };

      wallpaper = {
        enabled = true;
        default.path = "~/Nextcloud/Photos/Backgrounds/wallpapers/";
      };

      shell.umbriel_overview_type_to_launch_enabled = true;
    };
  };
}