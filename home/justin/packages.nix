{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # CLI tools
    fastfetch
    htop
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
    kdePackages.kirigami
    kdePackages.qtwayland

    # Terminals & file managers
    wezterm
    xfce.thunar
    xfce.thunar-volman
  ];
}
