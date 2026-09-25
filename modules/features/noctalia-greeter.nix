{ config, lib, pkgs, ... }:

let
  cfg = config.features.noctalia-greeter;
in
{
  config = lib.mkIf cfg.enable {
    services.displayManager.noctalia-greeter = {
      enable = true;
      settings = {
        cursor = {
          theme = "Bibata-Modern-Ice";
          size = 24;
          path = "${pkgs.bibata-cursors}/share/icons";
        };

        # Enable syncing and point it to your user account
        sync = {
          enable = true;
          user = "justin"; # The user directory from which to read Noctalia configs
        };
      };
    };

    # System package dependencies for the greeter assets
    environment.systemPackages = [
      pkgs.bibata-cursors
    ];
  };
}