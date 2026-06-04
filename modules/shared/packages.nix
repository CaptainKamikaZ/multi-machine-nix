{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alsa-utils
    cifs-utils
    ffmpeg-full
    gh
    git
    gvfs
    inetutils
    lshw
    onlyoffice-desktopeditors
    pciutils
    tailscale
    tree
    v4l-utils
    vim
    wget
    polkit
  ];
  programs.fish.enable = true;
  programs.niri.enable = true;
}
