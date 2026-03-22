{ config, pkgs, lib, ... }:

let
  kde = pkgs.kdePackages;
in
{
  options.niri.kdeCompat.enable = lib.mkEnableOption "KDE compatibility for Niri";

  config = lib.mkIf config.niri.kdeCompat.enable {

    home.sessionVariables = {
      XDG_CURRENT_DESKTOP = "KDE";
      XDG_SESSION_DESKTOP = "KDE";
      QT_QPA_PLATFORMTHEME = "kde";
    };

    home.sessionVariables.XDG_DATA_DIRS = lib.mkForce (
      "${config.home.profileDirectory}/share:" +
      "/run/current-system/sw/share:" +
      "${kde.kio}/share:" +
      "${kde.kservice}/share:" +
      "${kde.kxmlgui}/share:" +
      "${kde.kded}/share"
    );

    home.sessionPath = [
      "/run/current-system/sw/share"
    ];

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
}
