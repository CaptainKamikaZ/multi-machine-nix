{ config, pkgs, lib, inputs, self, ... }:

{
  _module.args.device = "desktop";

  imports = [
    ./hardware.nix
    ./boot.nix
    ./networking.nix
    ./gpu.nix
    ./services.nix
    ./mounts.nix

    # Shared defaults (flake‑relative)
    "${inputs.self}/modules/shared/nix.nix"
    "${inputs.self}/modules/shared/fonts.nix"
    "${inputs.self}/modules/shared/packages.nix"
    "${inputs.self}/modules/shared/audio.nix"
    "${inputs.self}/modules/shared/printing.nix"
    "${inputs.self}/modules/shared/users.nix"
    "${inputs.self}/modules/shared/virtualization.nix"
    "${inputs.self}/modules/shared/thunar.nix"
    "${inputs.self}/modules/shared/grub-theme.nix"

    # Features
    "${inputs.self}/modules/features/default.nix"
  ];

  # Enable features for this host
  features.audiotools.enable = true;
  features.gaming.enable = true;
  features.obs.enable = true;
  features.virtualization.enable = true;

  # Host specific packages
  environment.systemPackages = with pkgs; [
    streamcontroller
  ];

  system.stateVersion = "25.11";
}
