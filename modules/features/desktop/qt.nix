{ config, pkgs, ... }:
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  xdg.configFile."qt6ct/qt6ct.conf".text = ''
    [Appearance]
    color_scheme_path=${config.home.homeDirectory}/.config/qt6ct/colors/noctalia.conf
    custom_palette=true
    icon_theme=Papirus-Dark
    style=Breeze
  '';
}