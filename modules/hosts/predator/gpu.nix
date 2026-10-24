{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      intel-vaapi-driver
      intel-media-driver
      libvdpau-va-gl
    ];
  };
}
