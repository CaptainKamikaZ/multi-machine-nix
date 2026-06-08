{ config, pkgs, lib, inputs, self, ... }:

{
  _module.args.device = "hp-laptop";

  imports = [
    ./hardware.nix
    ./boot.nix
    ./networking.nix
    ./gpu.nix
    ./services.nix

    # Shared defaults (flake‑relative)
    "${inputs.self}/modules/shared/system.nix"
    "${inputs.self}/modules/shared/nix.nix"
    "${inputs.self}/modules/shared/fonts.nix"
    "${inputs.self}/modules/shared/packages.nix"
    "${inputs.self}/modules/shared/audio.nix"
    "${inputs.self}/modules/shared/printing.nix"
    "${inputs.self}/modules/shared/users.nix"
    "${inputs.self}/modules/shared/thunar.nix"
    "${inputs.self}/modules/shared/grub-theme.nix"

    # Features
    "${inputs.self}/modules/features/default.nix"
  ];

  features.sddm.enable = true;

  system.stateVersion = "25.11";
}
