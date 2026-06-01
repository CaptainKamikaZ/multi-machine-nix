{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.noctalia-shell.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
  };

  xdg.configFile."noctalia/settings.json".source =
    ./noctalia.json;
}
