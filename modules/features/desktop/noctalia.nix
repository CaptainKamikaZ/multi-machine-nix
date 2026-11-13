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
        templates = {
          enable_builtin_templates = true;
          builtin_ids = [ "btop" "gtk3" "gtk4" "qt" "kcolorscheme" "kitty" "umbriel" "fastfetch" "gimp" "libreoffice" "obs" "obsidian" "papirus-icons" ];
        };
      };

      wallpaper = {
        enabled = true;
        default.path = "~/Nextcloud/Photos/Backgrounds/wallpapers/";
      };

      shell = {
        umbriel_overview_type_to_launch_enabled = true;
        #app_icon_colorize = true;
      };
    };
  };
}   