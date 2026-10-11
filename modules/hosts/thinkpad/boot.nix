{
  boot.loader.systemd-boot.enable = false;

  boot.loader.grub = {
    enable = true;
    efiSupport = false;
    device = "/dev/sda";
    configurationLimit = 10;
    useOSProber = true;
  };
}
