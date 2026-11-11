{ config, lib, pkgs, inputs, username, ... }:

let
  cfg = config.features.noctalia-greeter;
in
{
  config = lib.mkIf cfg.enable {
    services.displayManager.noctalia-greeter = {
      enable = true;
      package = inputs.noctalia-greeter.packages.${pkgs.system}.default;

      passwordless-sync-users = [ "${username}" ];

      settings = {
        sync = {
          enable = true;
          user = "${username}";
          wallpaper = true;
        };
      };
    };
    services.displayManager.sessionPackages = [
      inputs.umbriel.packages.${pkgs.system}.default
    ];

    services.greetd.settings.default_session.command =
      "${pkgs.coreutils}/bin/env "
      + "XDG_DATA_DIRS=${config.services.displayManager.sessionData.desktops}/share "
      + "${config.services.displayManager.noctalia-greeter.package}/bin/noctalia-greeter-session";

  };
}
