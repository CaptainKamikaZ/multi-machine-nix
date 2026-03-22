{ config, lib, ... }:

{
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "KDE";
    XDG_SESSION_DESKTOP = "KDE";
    QT_QPA_PLATFORMTHEME = "kde";
  };

  # KDE needs its data dirs visible
  home.sessionPath = [
    "/run/current-system/sw/share"
  ];

  home.sessionVariables.XDG_DATA_DIRS =
    lib.mkForce "${config.home.profileDirectory}/share:/run/current-system/sw/share";
}
