{ config, pkgs, lib, ... }:

let
  rawConfig = builtins.readFile ./noctalia.json;
in
{
  config = {
    xdg.enable = true;

    xdg.configFile."noctalia/config.json".text = rawConfig;

    # Optional: add a launcher keybind
    wayland.windowManager.niri.settings.binds."Mod+Space".spawn =
      "${pkgs.noctalia-shell}/bin/noctalia-shell";
  };
}
