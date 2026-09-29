{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.features.noctalia-greeter;
in
{
  config = lib.mkIf cfg.enable {
    services.displayManager.noctalia-greeter = {
      enable = true;
      package = inputs.noctalia-greeter.packages.${pkgs.system}.default;

      passwordless-sync-users = [ "justin" ];

      settings = {
        monitors = [
          {
            name = "DP-3";
            primary = true;
          }
        ];

        sync = {
          enable = true;
          user = "justin";
          wallpaper = true;
        };
      };
    };
  };
}