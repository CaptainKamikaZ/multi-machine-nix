{
  description = "Justin's NixOS configuration";

  inputs = {
    # Your base system stays on stable 25.11
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Home Manager matching your system
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Pull Niri *only* from unstable
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit self home-manager;
      };

      modules = [
        ./configuration.nix

        # Home Manager module
        home-manager.nixosModules.home-manager
        
        {
          home-manager.users.justin = {
            imports = [
              ./home.nix
            ];
          };
        }

        # ⭐ Overlay: import Niri from unstable
        {
          nixpkgs.overlays = [
            # Your existing noctalia overlay
            (final: prev: {
              noctalia =
                (builtins.getFlake "github:noctalia-dev/noctalia-shell")
                .packages.${prev.stdenv.hostPlatform.system}.default;
            })

            # ⭐ Niri overlay from unstable
            (final: prev: {
              niri = nixpkgs-unstable.legacyPackages.${system}.niri;
            })
          ];
        }
      ];
    };
  };
}
