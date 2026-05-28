{ config, pkgs, lib, inputs, ... }:

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
    "${inputs.self}/modules/features/kde-env.nix"
    "${inputs.self}/modules/features/obs.nix"
    # Add these when ready:
    # "${inputs.self}/modules/features/niri"
    # "${inputs.self}/modules/features/noctalia"
  ];

  # Enable features for this host
  features.kde-env.enable = true;
  features.obs.enable = true;

  # Enable these when ready:
  # features.niri.enable = true;
  # features.noctalia.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.kirigami
  ];

  system.stateVersion = "25.11";
}
