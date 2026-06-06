{ config, pkgs, ... }:

{
  ##############################
  # Display Manager: greetd
  ##############################
  services.displayManager.sddm.enable = false;

  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${pkgs.niri}/bin/niri-session";
        user = "justin";
      };
    };
  };

  ##############################
  # Desktop Environments
  ##############################
  services.xserver.enable = true;

  # Plasma 6 stays available as an alternate session
  services.desktopManager.plasma6.enable = true;

  # Register Niri session
  services.displayManager.sessionPackages = [
    pkgs.niri
  ];

  # Boot to graphical target
  systemd.defaultUnit = "graphical.target";

  ##############################
  # System Services
  ##############################
  services.tailscale.enable = true;
  services.flatpak.enable = true;

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;
  services.blueman.enable = true;
  services.printing.enable = true;
}
