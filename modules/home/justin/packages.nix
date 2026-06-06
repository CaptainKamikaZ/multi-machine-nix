{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # CLI tools
    fastfetch
    htop
    lsd
    lm_sensors

    # GUI apps
    anki-bin
    audacity
    brave
    discord
    easyeffects
    filezilla
    gimp
    nextcloud-client
    obsidian
    thunderbird
    vlc
    xwayland-satellite

    # KDE packages
    kdePackages.breeze
    kdePackages.kate
    kdePackages.kdenlive

  ];
}
