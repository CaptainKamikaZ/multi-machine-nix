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