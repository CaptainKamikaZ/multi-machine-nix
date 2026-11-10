{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # CLI tools
    fastfetch
    htop
    kitty
    lsd
    lm_sensors

    # GUI apps
    audacity
    brave
    filezilla
    gimp
    nextcloud-client
    obsidian
    thunderbird
    vesktop
    vlc
    xwayland-satellite

    # KDE packages
    kdePackages.breeze
    kdePackages.kate
    kdePackages.kdenlive

  ];
}
