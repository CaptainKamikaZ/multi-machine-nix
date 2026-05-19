{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware.nix
    ./boot.nix
    ./networking.nix
    ./gpu.nix
    ./services.nix

    ../../modules/shared/nix.nix
    ../../modules/shared/fonts.nix
    ../../modules/shared/packages.nix
    ../../modules/shared/audio.nix
    ../../modules/shared/printing.nix
    ../../modules/shared/users.nix
    ../../modules/shared/virtualization.nix
    ../../modules/shared/thunar.nix
    ../../modules/shared/niri.nix
    ../../modules/shared/obs.nix
    ../../modules/shared/grub-theme.nix

  ];

  environment.systemPackages = with pkgs; [
    noctalia
    kdePackages.kirigami
  ];


  system.stateVersion = "25.11";
}
