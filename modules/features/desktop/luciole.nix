# modules/features/desktop/luciole.nix
{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.luciole.homeModules.default
  ];

  home.packages = [
    inputs.luciole.packages.${pkgs.system}.default
  ];

  programs.luciole = {
    enable = true;
    settings = {

    };
  };
}