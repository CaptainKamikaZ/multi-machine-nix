{ lib, ... }:

{
  imports = [
    ./obs.nix
    ./audiotools.nix
    ./gaming.nix
    ./networktools.nix
    ./sddm.nix
    ./study.nix
    ./virtualization.nix
  ];

  options.features = {
    obs.enable = lib.mkEnableOption "OBS Studio and plugins";
    audiotools.enable = lib.mkEnableOption "Audio tools";
    gaming.enable = lib.mkEnableOption "Gaming applications";
    networktools.enable = lib.mkEnableOption "Enable a comprehensive suite of network diagnostic and analysis tools";
    sddm.enable = lib.mkEnableOption "SDDM display manager";
    study.enable = lib.mkEnableOption "Study tools";
    virtualization.enable = lib.mkEnableOption "Virtualization tools";
  };
}
