{ config, pkgs, lib, ... }:

{
    config = lib.mkIf config.features.virtualization.enable {
        environment.systemPackages = with pkgs; [
            distrobox
            podman
        ];
        virtualisation.podman.enable = true;
        virtualisation.podman.dockerCompat = true;
    };    
}