{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };

      # Desktop shell feature toggles
#      shell = {
#        polkit_agent = true; # Enabled Noctalia built-in Polkit agent
#      };

      # Wallpaper management
      wallpaper = {
        enabled = true;
        # Add wallpaper paths or options here if applicable
      };
    };
  };
}