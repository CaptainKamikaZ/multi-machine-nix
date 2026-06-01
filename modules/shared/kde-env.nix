{ pkgs, lib, ... }:

{
#  systemd.user.services.niri = {
#    serviceConfig.Environment = [
#      "QML2_IMPORT_PATH=${pkgs.kdePackages.kirigami}/lib/qt6/qml:${pkgs.kdePackages.kirigami-addons}/lib/qt6/qml:${pkgs.qt6.qtdeclarative}/lib/qt6/qml"
#      "QT_PLUGIN_PATH=${pkgs.qt6.qtbase}/lib/qt6/plugins:$QT_PLUGIN_PATH"
#      "XDG_DATA_DIRS=${pkgs.kdePackages.kirigami}/share:${pkgs.kdePackages.kirigami-addons}/share:${pkgs.qt6.qtbase}/share:$XDG_DATA_DIRS"
#      "XDG_CONFIG_HOME=%h/.config"
#      "XKB_DEFAULT_RULES=evdev"
#      "XKB_DEFAULT_MODEL=pc105"
#      "XKB_DEFAULT_LAYOUT=us"
#      "XKB_DEFAULT_VARIANT="
#      "XKB_DEFAULT_OPTIONS="
#    ];
#  };
}
