{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  systemd.defaultUnit = "graphical.target";
  services.displayManager.sessionPackages = [
    pkgs.niri
  ];

  services.tailscale.enable = true;
  services.flatpak.enable = true;

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;
  services.avahi.enable = true;
  services.blueman.enable = true;
  services.printing.enable = true;
}