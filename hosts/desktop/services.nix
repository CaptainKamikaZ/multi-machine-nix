{
  services.tailscale.enable = true;
  services.flatpak.enable = true;

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  services.blueman.enable = true;

  services.printing.enable = true;
}
