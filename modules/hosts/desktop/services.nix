{ config, pkgs, ... }:

{

  ##############################
  # Desktop Environments
  ##############################
  services.xserver.enable = true;

  # Plasma 6 stays available as an alternate session
  services.desktopManager.plasma6.enable = true;

  # Boot to graphical target
  systemd.defaultUnit = "graphical.target";

  ##############################
  # Hardware & Drivers
  ##############################
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.enableAllFirmware = true;

  ##############################
  # System Services
  ##############################
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSSEC = "true";
      Domains = [ "~." ];
    };
  };
  services.flatpak.enable = true;

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;
  services.blueman.enable = true;
  services.printing.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
}
