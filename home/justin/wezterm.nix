{ pkgs, ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ../../home-manager/wezterm.lua;
  };
}
