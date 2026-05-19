{
  description = "Justin's dendritic NixOS configuration with Niri + Noctalia";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Working wrapper-modules fork
    wrapper-modules.url = "github:birdeehub/nix-wrapper-modules";
    wrapper-modules.inputs.nixpkgs.follows = "nixpkgs";

    noctalia-shell.url = "github:noctalia-dev/noctalia-shell";
    noctalia-shell.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit self inputs; } {

      systems = [ "x86_64-linux" ];

      perSystem = { system, pkgs, inputs', self', ... }: {
        _module.args = {
          unstable = import inputs.nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };

          # Make self available to NixOS modules
          self = self';
        };

        packages = {
          niri-wrapped = inputs.wrapper-modules.wrappers.niri.wrap {
            inherit pkgs;
            config = ./home/justin/niri/config.kdl;
          };

          noctalia-wrapped = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
            inherit pkgs;
            config = ./home/justin/noctalia/config.json;
          };
        };
      };

      flake = {
        nixosConfigurations = {
          nixos-laptop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            modules = [
              ./hosts/laptop
              ./modules/shared/grub-theme.nix
              inputs.home-manager.nixosModules.home-manager

              # Inline module with correct self binding
              ({ config, pkgs, ... }:
                let
                  inherit (config._module.args) self;
                in {
                  nixpkgs.config.allowUnfree = true;

                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;

                  home-manager.users.justin = import ./home/justin/default.nix;

                  programs.niri = {
                    enable = true;
                    package = self.packages.${pkgs.system}.niri-wrapped;
                  };
                })
            ];
          };

          desktop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            modules = [
              ./hosts/desktop
              ./modules/shared/grub-theme.nix
              inputs.home-manager.nixosModules.home-manager

              # Inline module with correct self binding
              ({ config, pkgs, ... }:
                let
                  inherit (config._module.args) self;
                in {
                  nixpkgs.config.allowUnfree = true;

                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;

                  home-manager.users.justin = import ./home/justin/default.nix;

                  programs.niri = {
                    enable = true;
                    package = self.packages.${pkgs.system}.niri-wrapped;
                  };
                })
            ];
          };
        };
      };
    };
}
