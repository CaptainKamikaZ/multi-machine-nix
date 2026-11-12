# modules/features/desktop/default.nix
{ config, lib, pkgs, inputs, username, ... }:

let
  cfg = config.features.desktop;
in
{
  imports = [ inputs.umbriel.nixosModules.default ];

  config = lib.mkIf cfg.enable {
    # System-level compositor enablement
    programs.umbriel.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = [
        inputs.umbriel.packages.${pkgs.system}.default
        pkgs.xdg-desktop-portal-gtk
      ];
      config = {
        common = {
          # Fallback order for portal requests (tries Umbriel first, then GTK)
          default = [ "umbriel" "gtk" ];
        };
      };
    };

    # System-level greeter setup
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

    home-manager.users.${username} = {
      imports = [
        ./noctalia.nix
        ./umbriel.nix
      ];
    };
  };
}