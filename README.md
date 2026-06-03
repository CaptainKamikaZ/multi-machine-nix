# CaptainKamikaZ's NixOS Configuration

A modern, scalable NixOS configuration designed for multiple machines using a clean
`shared/` + `features/` + `hosts/` architecture. Built with flakes, flake‑parts,
Home‑Manager, and a modular design that keeps each system reproducible and easy to maintain.

This repo powers all of my NixOS machines, including desktops and laptops, with
optional features like Niri, Noctalia, gaming, virtualization, and more.

---

## ✨ Goals

- Consistent baseline configuration across all machines
- Optional feature modules that can be toggled per host
- Clean separation between system‑level and user‑level configuration
- Declarative desktop environments (Niri + Noctalia)
- Easy onboarding for new machines
- Reproducible builds using flakes

---

## 📁 Repository Structure
.
├── flake.nix
├── flake.lock
├── hosts/              # Per-machine configuration
│   ├── laptop/
│   └── desktop/
├── modules/
│   ├── shared/         # Always-on system modules
│   └── features/       # Optional feature modules
└── home/               # Home-Manager modules


### `hosts/`
Machine-specific configuration. Each host enables the features it needs:

```nix
{
  features = {
    niri.enable = true;
    noctalia.enable = true;
    gaming.enable = false;
  };
}

modules/shared/

Modules that apply to every machine:

    base system defaults

    networking

    fonts & theming

    core packages

    user account

    audio (PipeWire)

    system services

modules/features/

Optional modules that can be toggled per host:

    Niri compositor

    Noctalia shell

    Gaming stack (Steam, MangoHUD, gamescope)

    Virtualization (libvirt, qemu)

    Printing

    NVIDIA drivers

home/

Home‑Manager configuration for user‑level settings:

    shell

    terminal

    editor

    desktop config

    dotfiles

### 🖥 Adding a New Machine
1. Create a new directory under hosts/:

hosts/my-machine/default.nix

2. Enable the features you want:

{
  features = {
    niri.enable = true;
    noctalia.enable = true;
    gaming.enable = false;
  };
}

3. Rebuild

sudo nixos-rebuild switch --flake .#my-machine
