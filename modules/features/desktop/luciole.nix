# modules/features/desktop/luciole.nix
{ config, pkgs, lib, inputs, username, ... }:

{
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  home-manager.users.${username} = {
    imports = [
      inputs.luciole.homeModules.default
    ];

    home.packages = [
      inputs.luciole.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    programs.luciole = {
      enable = true;
      settings = {
        
      };
    };
  };
}
