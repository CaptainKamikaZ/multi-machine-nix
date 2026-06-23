{ config, pkgs, lib, ... }:

let
  cfg = config.features.study;
in
{
  options.features.study = {
    enable = lib.mkEnableOption "Study tools (Anki Wayland, etc.)";
  };

  config = lib.mkIf cfg.enable {

    # Install Anki (and future study tools)
    home-manager.users.justin.home.packages = [
      pkgs.anki-bin
    ];

    # Wrap Anki so terminal launches always use Wayland
    home-manager.users.justin.home.packages = [
      (pkgs.writeShellScriptBin "anki" ''
        export ANKI_WAYLAND=1
        exec ${pkgs.anki-bin}/bin/anki "$@"
      '')
    ];

    # Override .desktop entry so launchers (Noctalia, Niri, etc.) use Wayland
    home-manager.users.justin.xdg.desktopEntries.anki = {
      name = "Anki";
      exec = "env ANKI_WAYLAND=1 anki %f";
      terminal = false;
      type = "Application";
      categories = [ "Education" ];
    };
  };
}
