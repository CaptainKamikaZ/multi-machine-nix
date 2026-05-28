{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Initrd hardware modules
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];

  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Filesystems
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c569c960-297a-44ec-822d-03dab15e08f5";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C43C-9D27";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  # No swap configured
  swapDevices = [ ];

  # DHCP defaults (safe to leave here)
  networking.useDHCP = lib.mkDefault true;

  # CPU microcode
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Platform
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
