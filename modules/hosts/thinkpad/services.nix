{ config, pkgs, ... }:

{
  services.tailscale.enable = true;
  services.flatpak.enable = true;
  services.blueman.enable = true;
  services.printing.enable = true;

  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Laptop-specific
  powerManagement.enable = true;
  services.power-profiles-daemon.enable = true;
}
