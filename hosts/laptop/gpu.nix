{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vaapiIntel
      intel-media-driver
      libvdpau-va-gl
    ];
  };

  services.xserver.videoDrivers = [ "modesetting" ];
}
