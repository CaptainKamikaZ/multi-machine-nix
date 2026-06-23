{ config, pkgs, lib, ... }:

let
  cfg = config.features.study;
in
{
  config = lib.mkIf cfg.enable {

    home-manager.users.justin.home.packages = lib.mkMerge [
      [
        (pkgs.writeShellScriptBin "anki" ''
          export ANKI_WAYLAND=1
          export QT_QPA_PLATFORM=xcb
          export QTWEBENGINE_CHROMIUM_FLAGS="--disable-gpu --disable-software-rasterizer"
          exec ${pkgs.anki-bin}/bin/anki "$@"
        '')      
      ]
      [ pkgs.mpv ]
      [ pkgs.adwaita-qt ]
    ];


    # Override .desktop entry so launchers use Wayland
    home-manager.users.justin.xdg.desktopEntries.anki = {
      name = "Anki";
      exec = "env ANKI_WAYLAND=1 anki %f";
      terminal = false;
      type = "Application";
      categories = [ "Education" ];
    };
  };
}
