{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # CLI tools
    fastfetch
    htop
    lsd
    lm_sensors
    slurp

    # GUI apps
    audacity
    brave
    discord
    easyeffects
    filezilla
    gimp
    helvum
    nextcloud-client
    obsidian
    onlyoffice-desktopeditors
    prismlauncher
    thunderbird
    vlc
    vscode

    # KDE packages
    kdePackages.breeze
    kdePackages.kate
    kdePackages.kdenlive

  ];
}
