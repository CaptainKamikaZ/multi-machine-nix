{ config, pkgs, lib, ... }:

let
  cfg = config.features.study;
in
{
  config = lib.mkIf cfg.enable {

    # Only install the wrapper, not anki-bin itself
    home-manager.users.justin.home.packages = [
      (pkgs.writeShellScriptBin "anki" ''
        export ANKI_WAYLAND=1
        exec ${pkgs.anki-bin}/bin/anki "$@"
      '')
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
