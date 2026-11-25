{ config, pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;
  systemd.defaultUnit = "graphical.target";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Laptop-specific
  powerManagement.enable = true;
  services.power-profiles-daemon.enable = true;

  # Other services
  services.tailscale.enable = true;
  services.flatpak.enable = true;
  services.blueman.enable = true;
  services.printing.enable = true;
}
