{ pkgs, ... }:

{
  # Install Thunar + plugins
  home.packages = with pkgs; [
    xfce.thunar
    xfce.thunar-volman
  ];

  # Declarative Thunar config files
  xdg.configFile."Thunar/accels.scm".source =
    ../../dotfiles/thunar/accels.scm;

  xdg.configFile."Thunar/uca.xml".source =
    ../../dotfiles/thunar/uca.xml;
}
