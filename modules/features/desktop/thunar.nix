# modules/features/desktop/thunar.nix
{ config, pkgs, lib, inputs, username, ... }:

let
  cfg = config.features.desktop;
in
{
  config = lib.mkIf cfg.enable {
    # System-level services
    services.gvfs.enable = true;
    services.udisks2.enable = true;
    services.tumbler.enable = true;

    # User-level packages and configs
    home-manager.users.${username} = {
      home.packages = with pkgs; [
        xfce.thunar
        xfce.thunar-volman
      ];

      xdg.configFile."Thunar/accels.scm".source =
        "${inputs.self}/dotfiles/thunar/accels.scm";

      xdg.configFile."Thunar/uca.xml".source =
        "${inputs.self}/dotfiles/thunar/uca.xml";
    };
  };
}