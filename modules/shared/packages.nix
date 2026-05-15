{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alsa-utils
    anki-bin
    cifs-utils
    distrobox
    ffmpeg-full
    gh
    git
    gvfs
    inetutils
    lshw
    obs-cmd
    pciutils
    podman
    protonup-qt
    streamcontroller
    tailscale
    temurin-bin-25
    timeshift
    v4l-utils
    vim
    wget
    noctalia
    polkit
    quickshell
    xwayland-satellite
  ];
}