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

    # Shared overlays for both system and Home Manager
    overlays = [
      # Noctalia overlay
      (final: prev: {
        noctalia =
          noctalia-shell.packages.${prev.stdenv.hostPlatform.system}.default;
      })

      # Niri from unstable
      (final: prev: {
        niri = nixpkgs-unstable.legacyPackages.${system}.niri;
      })
    ];
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit self overlays;
      };

      modules = [
        ./configuration.nix

        # System-level nixpkgs config
        {
          nixpkgs = {
            config.allowUnfree = true;
            overlays = overlays;
          };
        }

        # Home Manager
        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = false;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";

          home-manager.users.justin = {
            imports = [ ./home.nix ];

            # Home Manager gets the same overlays + unfree
            nixpkgs = {
              config.allowUnfree = true;
              overlays = overlays;
            };

            home.stateVersion = "25.11";
          };
        }
      ];
    };
  };
}
