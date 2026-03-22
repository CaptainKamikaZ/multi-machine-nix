{
  description = "Justin's NixOS configuration";

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
    lib = nixpkgs.lib;
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit self;
      };

      modules = [

        ./configuration.nix

        {
          nixpkgs.config.allowUnfree = true;

          nixpkgs.overlays = [
            (final: prev: {
              noctalia =
                noctalia-shell.packages.${prev.stdenv.hostPlatform.system}.default;
            })

            (final: prev: {
              niri = nixpkgs-unstable.legacyPackages.${system}.niri;
            })
          ];
        }

        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.backupFileExtension = "backup";

          home-manager.users.justin = {
            imports = [ ./home.nix ];
            nixpkgs.config.allowUnfree = true;
            home.stateVersion = "25.11";
          };
        }
      ];
    };
  };
}
