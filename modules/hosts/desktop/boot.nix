{
  boot.loader.systemd-boot.enable = false;

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    configurationLimit = 10;
    useOSProber = true;
    extraEntries = ''
      menuentry "Omarchy Linux" {
        insmod part_gpt
        insmod fat
        insmod chain
        search --no-floppy --fs-uuid --set=root E3FD-1014
        chainloader /EFI/BOOT/BOOTX64.EFI
      }
    '';
  };
}
