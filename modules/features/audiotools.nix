{ config, pkgs, lib, ... }:

{
  config = lib.mkIf config.features.audiotools.enable {

    home-manager.users.justin = {
      services.easyeffects.enable = true;

      systemd.user.services.easyeffects = {

        Service = {
          # Automatically clean up the broken socket files if they exist before launching
          ExecStartPre = [
            "-/bin/sh -c 'rm -f /tmp/easyeffects.lock /tmp/EasyEffectsServer \${XDG_RUNTIME_DIR}/easyeffects.lock \${XDG_RUNTIME_DIR}/EasyEffectsServer'"
          ];
          ExecStart = lib.mkForce "${pkgs.easyeffects}/bin/easyeffects --hide-window --service-mode";
        };
      };

      home.packages = with pkgs; [
        easyeffects
        helvum
      ];
    };
  };
}
