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
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    import-tree.url = "github:vic/import-tree";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit self inputs; } {

      systems = [ "x86_64-linux" ];

      flake = {

        nixosConfigurations =
          let
            mkHost = hostName: path: nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              specialArgs = { inherit inputs self; };
              modules = [
                path
                inputs.home-manager.nixosModules.home-manager

                {
                  nixpkgs.config.allowUnfree = true;

                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    backupFileExtension = "backup";
                    overwriteBackup = true;
                    extraSpecialArgs = { inherit inputs self; };
                    
                    users.justin = { ... }: {
                      _module.args.device = hostName;
                      
                      imports = [
                        ./modules/home/justin/default.nix
                      ];
                    };
                  };
                }
              ];
            };
          in
          {
            hp-laptop = mkHost "hp-laptop" ./modules/hosts/laptop;
            desktop   = mkHost "desktop"   ./modules/hosts/desktop;
            thinkpad  = mkHost "thinkpad"  ./modules/hosts/thinkpad;
          };
      };
    };
}