{
  description = "Justin's dendritic NixOS configuration with Niri (Vimjoyer style)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    wrapper-modules.url = "github:birdeehub/nix-wrapper-modules";
    wrapper-modules.inputs.nixpkgs.follows = "nixpkgs";

    noctalia-shell.url = "github:noctalia-dev/noctalia-shell";
    noctalia-shell.inputs.nixpkgs.follows = "nixpkgs";

    import-tree.url = "github:vic/import-tree";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit self inputs; } {

      systems = [ "x86_64-linux" ];

      perSystem = { system, pkgs, lib, self', ... }: {

        #
        # Wrapped packages (still correct)
        #
        packages = {
          myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
            config = {
              inherit pkgs;

              settings = {
                layout.gaps = 5;
                binds = {
                  "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
                  "Mod+Q".close-window = _: {};
                };
              };
            };
          };
#removed noctalia wrapper
        };
      };

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
