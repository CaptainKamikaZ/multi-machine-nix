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
    kdePackages.kate
    kdePackages.kdenlive
    nextcloud-client
    obsidian
    onlyoffice-desktopeditors
    prismlauncher
    thunderbird
    vlc
    vscode

    # Terminals & file managers
    wezterm
    xfce.thunar
    xfce.thunar-volman
  ];
}
