{ lib, ... }:

{
  imports = [
    ./obs.nix
    ./audiotools.nix
    ./gaming.nix
    ./greetd.nix
    ./sddm.nix
    ./virtualization.nix
  ];

  options.features = {
    obs.enable = lib.mkEnableOption "OBS Studio and plugins";
    audiotools.enable = lib.mkEnableOption "Audio tools";
    gaming.enable = lib.mkEnableOption "Gaming applications";
    greetd.enable = lib.mkEnableOption "Greetd display manager";
    sddm.enable = lib.mkEnableOption "SDDM display manager";
    virtualization.enable = lib.mkEnableOption "Virtualization tools";
  };
}
