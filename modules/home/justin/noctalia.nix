{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;

    # Nix automatically serializes this attribute set into ~/.config/noctalia/config.toml
    settings = {
      # Theme settings
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };

      # Bar layout configuration
      bar = {
        position = "top";
        height = 32;
        margin = {
          top = 8;
          bottom = 0;
          left = 8;
          right = 8;
        };
        widgets = {
          left = [ "workspaces" "window-title" ];
          center = [ "clock" ];
          right = [ "tray" "network" "volume" "battery" ];
        };
      };

      # Desktop shell feature toggles
      shell = {
        polkit_agent = true; # Enabled Noctalia built-in Polkit agent
      };

      # Launcher settings
      launcher = {
        show_icon = true;
        terminal = "foot";
      };

      # Wallpaper management
      wallpaper = {
        enabled = true;
        # Add wallpaper paths or options here if applicable
      };
    };
  };
}