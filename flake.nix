{
  description = "Justin's dendritic NixOS configuration with Niri";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    wrapper-modules.url = "github:birdeehub/nix-wrapper-modules";
    wrapper-modules.inputs.nixpkgs.follows = "nixpkgs";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    import-tree.url = "github:vic/import-tree";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit self inputs; } {

      systems = [ "x86_64-linux" ];

      flake = {

        #
        # NixOS Configurations (hosts)
        #
        nixosConfigurations = {

          hp-laptop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            specialArgs = {
              inherit inputs self;
            };

            modules = [
              ./modules/hosts/laptop

              inputs.home-manager.nixosModules.home-manager

              {
                nixpkgs.config.allowUnfree = true;

                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "backup";
                home-manager.overwriteBackup = true;

                home-manager.extraSpecialArgs = {
                  inherit inputs self;
                };

                home-manager.users.justin = { config, pkgs, inputs, self, ... }: {
                  _module.args.device = "hp-laptop";
                  imports = [ ./modules/home/justin/default.nix ];
                };
              }
            ];
          };

          desktop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            specialArgs = {
              inherit inputs self;
            };

            modules = [
              ./modules/hosts/desktop

              inputs.home-manager.nixosModules.home-manager

              {
                nixpkgs.config.allowUnfree = true;

                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = {
                  inherit inputs self;
                };

                home-manager.users.justin = { config, pkgs, inputs, self, ... }: {
                  _module.args.device = "desktop";
                  imports = [ ./modules/home/justin/default.nix ];
                };
              }
            ];
          };

          thinkpad = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            specialArgs = {
              inherit inputs self;
            };

            modules = [
              ./modules/hosts/thinkpad

              inputs.home-manager.nixosModules.home-manager

              {
                nixpkgs.config.allowUnfree = true;

                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = {
                  inherit inputs self;
                };

                home-manager.users.justin = { config, pkgs, inputs, self, ... }: {
                  _module.args.device = "thinkpad";
                  imports = [ ./modules/home/justin/default.nix ];
                };
              }
            ];
          };
        };
      };
    };
}
