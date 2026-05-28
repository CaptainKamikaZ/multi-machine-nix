{ config, pkgs, lib, ... }:

let
  cfg = config.features.kde-env;
  kde = pkgs.kdePackages;
in
{
  options.features.kde-env = {
    enable = lib.mkEnableOption "Enable KDE compatibility environment for Niri";

    # No extra options needed yet, but we can add them later
  };

  config = lib.mkIf cfg.enable {

    #
    # Home‑Manager section
    #
    home-manager.users.justin = { config, pkgs, ... }: {

      #
      # Core KDE session variables
      #
      home.sessionVariables = {
        XDG_CURRENT_DESKTOP = "KDE";
        XDG_SESSION_DESKTOP = "KDE";
        QT_QPA_PLATFORMTHEME = "kde";

        #
        # QML search paths — REQUIRED for Noctalia
        #
        QML2_IMPORT_PATH = lib.mkForce (
          "${kde.kirigami}/lib/qt6/qml:" +
          "${kde.breeze}/lib/qt6/qml:" +
          "${pkgs.qt6.qtdeclarative}/lib/qt6/qml"
        );

        #
        # Qt plugin path — required for QtWayland + QML controls
        #
        QT_PLUGIN_PATH = lib.mkForce (
          "${pkgs.qt6.qtwayland}/lib/qt6/plugins"
        );
      };

      #
      # KDE data directories — required for KIO, KService, KXMLGui, etc.
      #
      home.sessionVariables.XDG_DATA_DIRS = lib.mkForce (
        "${config.home.profileDirectory}/share:" +
        "/run/current-system/sw/share:" +
        "${kde.kio}/share:" +
        "${kde.kservice}/share:" +
        "${kde.kxmlgui}/share:" +
        "${kde.kded}/share"
      );

      #
      # Ensure KDE data dirs are in PATH
      #
      home.sessionPath = [
        "/run/current-system/sw/share"
      ];

      #
      # KDE-friendly default applications
      #
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "inode/directory" = [ "org.kde.dolphin.desktop" ];
          "video/mp4" = [ "vlc.desktop" ];
          "video/x-matroska" = [ "vlc.desktop" ];
          "image/png" = [ "org.kde.gwenview.desktop" ];
          "image/jpeg" = [ "org.kde.gwenview.desktop" ];
        };
      };
    };
  };
}
