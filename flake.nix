{
  description = "Justin's dendritic NixOS configuration with Niri + Noctalia (Vimjoyer style)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    wrapper-modules.url = "github:birdeehub/nix-wrapper-modules";
    wrapper-modules.inputs.nixpkgs.follows = "nixpkgs";

    noctalia-shell.url = "github:noctalia-dev/noctalia-shell";
    noctalia-shell.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit self inputs; } {

      systems = [ "x86_64-linux" ];

      perSystem = { system, pkgs, lib, self', ... }: {

        packages = {
          myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
            config = {
              inherit pkgs;
              v2-settings = true;

              settings = {
                layout.gaps = 5;
                binds = {
                  "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
                  "Mod+Q".close-window = _: {};
                };
              };
            };
          };

          myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
            config = {
              inherit pkgs;
              v2-settings = true;

              configFile = ./home/justin/noctalia/config.json;
            };
          };
        };
      };

      flake = {
        nixosModules = {

          niri = { pkgs, lib, ... }: {
            programs.niri = {
              enable = true;
              package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
            };
          };

          noctalia = { pkgs, ... }: {
            environment.systemPackages = [
              self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
            ];
          };
        };

        nixosConfigurations = {

          nixos-laptop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            modules = [
              ./hosts/laptop
              ./modules/shared/grub-theme.nix

              inputs.home-manager.nixosModules.home-manager

              self.nixosModules.niri
              self.nixosModules.noctalia

              {
                nixpkgs.config.allowUnfree = true;

                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.users.justin = import ./home/justin/default.nix;
              }
            ];
          };

          desktop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            modules = [
              ./hosts/desktop
              ./modules/shared/grub-theme.nix

              inputs.home-manager.nixosModules.home-manager

              self.nixosModules.niri
              self.nixosModules.noctalia

              {
                nixpkgs.config.allowUnfree = true;

                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.users.justin = import ./home/justin/default.nix;
              }
            ];
          };
        };
      };
    };
}
