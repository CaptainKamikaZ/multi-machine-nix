{ config, pkgs, lib, inputs, ... }:

{
  programs.noctalia-shell = {
    enable = true;
  };

  xdg.configFile."noctalia/settings.json".source =
    ./noctalia.json;
}
