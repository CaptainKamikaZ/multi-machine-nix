{
  description = "Justin's multi-machine NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    noctalia-shell.url = "github:noctalia-dev/noctalia-shell";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, noctalia-shell, ... }:
  let
    system = "x86_64-linux";

    overlays = [
      (final: prev: {
        noctalia =
          noctalia-shell.packages.${prev.stdenv.hostPlatform.system}.default;
      })

      (final: prev: {
        niri = nixpkgs-unstable.legacyPackages.${system}.niri;
      })
    ];
  in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { 
          inherit self overlays;
        };
        modules = [
          ./hosts/desktop
          ./modules/shared/grub-theme.nix

          home-manager.nixosModules.home-manager

          {
            nixpkgs = {
              config.allowUnfree = true;
              overlays = overlays;
            };

            home-manager.useGlobalPkgs = false;
            home-manager.useUserPackages = true;

            home-manager.users.justin = import ./home/justin/default.nix;
          }
        ];
      };

      nixos-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { 
          inherit self overlays;
        };
        modules = [
          ./hosts/laptop
          ./modules/shared/grub-theme.nix

          home-manager.nixosModules.home-manager

          {
            nixpkgs = {
              config.allowUnfree = true;
              overlays = overlays;
            };

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.justin = import ./home/justin/default.nix;
          }
        ];
      };
    };
  };
}
