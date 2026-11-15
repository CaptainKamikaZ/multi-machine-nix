{ config, pkgs, ... }:
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "breeze";
  };

  home.packages = with pkgs; [
    kdePackages.qt6ct
    kdePackages.breeze
    kdePackages.breeze-icons
  ];

  xdg.configFile."qt6ct/qt6ct.conf".text = ''
    [Appearance]
    color_scheme_path=${config.home.homeDirectory}/.config/qt6ct/colors/noctalia.conf
    custom_palette=true
    icon_theme=breeze-dark
    style=Breeze
  '';
}