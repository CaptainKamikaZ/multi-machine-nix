{ config, pkgs, ... }:

{
  services.tailscale.enable = true;
  services.flatpak.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;
  services.blueman.enable = true;
  services.printing.enable = true;

  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Laptop-specific
  powerManagement.enable = true;
  services.power-profiles-daemon.enable = true;
}
