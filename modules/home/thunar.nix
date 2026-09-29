{ config, pkgs, lib, inputs, self, ... }:

{
  # Install Thunar + plugins
  home.packages = with pkgs; [
    xfce.thunar
    xfce.thunar-volman
  ];

  # Declarative Thunar config files
  xdg.configFile."Thunar/accels.scm".source =
    "${inputs.self}/dotfiles/thunar/accels.scm";

  xdg.configFile."Thunar/uca.xml".source =
    "${inputs.self}/dotfiles/thunar/uca.xml";
}
