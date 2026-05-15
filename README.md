# Justin's NixOS Configuration

This repository contains my fully modular, multi‑machine NixOS configuration.
It supports both my desktop and laptop, with shared modules and a unified Home
Manager profile.

## 🧩 Structure

justin-nix/
├── flake.nix
├── hosts/
│   ├── desktop/
│   └── laptop/
├── modules/
│   └── shared/
└── home/
└── justin/


### `hosts/`
Machine‑specific configuration:

- `hardware.nix` — disks, filesystems, initrd modules
- `boot.nix` — bootloader settings
- `networking.nix` — hostname, DHCP/static IP
- `gpu.nix` — NVIDIA or integrated graphics
- `services.nix` — host‑specific services
- `default.nix` — imports everything for that machine

### `modules/shared/`
Reusable system modules shared across all machines:

- Nix settings
- Fonts
- Packages
- Audio (PipeWire)
- Printing
- Virtualization (Podman)
- Thunar/GVFS
- Niri
- Noctalia
- OBS Studio
- Overlays
- GRUB theme

### `home/justin/`
My Home Manager configuration:

- Modular HM files (`gtk.nix`, `qt.nix`, `wezterm.nix`, etc.)
- Dotfiles stored under `dotfiles/`
- Shared across all machines

## 🖥️ Desktop
- NVIDIA GPU
- Static IP networking
- Multiple mounted storage drives

## 💻 Laptop
- Integrated graphics
- DHCP networking
- Power‑optimized defaults

## 🎨 GRUB Theme
My custom Hyperfluent GRUB theme is built as a derivation and applied to all machines.

## 🚀 Usage

Build for desktop:
sudo nixos-rebuild switch --flake .#desktop

Build for laptop:
sudo nixos-rebuild switch --flake .#laptop

## 📄 License
MIT
