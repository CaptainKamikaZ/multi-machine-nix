{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fastfetch
    htop
    lm_sensors
    slurp
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
    wezterm
    xfce.thunar
    xfce.thunar-volman
  ];
}
