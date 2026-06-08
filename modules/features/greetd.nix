{ config, lib, pkgs, ... }:

let
  cfg = config.features.greetd;
in
{
  config = lib.mkIf cfg.enable {

    services.greetd = {
      enable = true;

      settings = {
        default_session = {
          command = "${pkgs.regreet}/bin/regreet";
          user = "justin";
        };
      };
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

    environment.systemPackages = with pkgs; [
      regreet
      adwaita-icon-theme
      gnome-themes-extra
      cantarell-fonts
    ];
  };
}
