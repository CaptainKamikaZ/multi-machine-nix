#!/bin/bash
sudo nixos-rebuild switch --impure --flake ~/git/justin-nix#nixos

sudo nixos-rebuild switch --flake ~/git/justin-nix#nixos