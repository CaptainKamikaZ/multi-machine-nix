{ pkgs, lib, ... }:

{
  systemd.user.services.niri = {
    serviceConfig = {
      Environment = [
        "QML2_IMPORT_PATH=${pkgs.kdePackages.kirigami}/lib/qt6/qml:${pkgs.kdePackages.kirigami-addons}/lib/qt6/qml:${pkgs.qt6.qtdeclarative}/lib/qt6/qml"
        "QT_PLUGIN_PATH=${pkgs.qt6.qtbase}/lib/qt6/plugins"
        "XDG_DATA_DIRS=${pkgs.kdePackages.kirigami}/share:${pkgs.kdePackages.kirigami-addons}/share:${pkgs.qt6.qtbase}/share:$XDG_DATA_DIRS"
      ];
    };
  };
}
