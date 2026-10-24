{
  boot.loader.systemd-boot.enable = true;

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  boot.loader.grub = {
    enable = false;
    efiSupport = true;
    device = "nodev";
    configurationLimit = 10;
    useOSProber = true;
  };
}
