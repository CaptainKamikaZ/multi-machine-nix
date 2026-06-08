{ config, lib, pkgs, ... }:

let
  cfg = config.features.greetd;
in
{
  options.features.greetd = {
    enable = lib.mkEnableOption "Enable greetd with ReGreet";
  };

  config = lib.mkIf cfg.enable {
    # Auto-disable SDDM when greetd is enabled
    services.displayManager.sddm.enable = lib.mkForce false;

    services.greetd = {
      enable = true;

      settings = {
        default_session = {
          command = "${pkgs.regreet}/bin/regreet";
          user = null;
        };
      };

      vt = 1;
    };

    programs.regreet = {
      enable = true;

      theme.name = "Adwaita";
      font = {
        name = "Cantarell";
        size = 16;
      };
      cursorTheme.name = "Adwaita";
    };

    environment.systemPackages = [
      pkgs.regreet
    ];
  };
}
