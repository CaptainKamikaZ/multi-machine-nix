{ pkgs, config, ... }:
{
  gtk = {
    enable = true;

    font = {
      name = "Inter";
      size = 11;
    };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  home.packages = with pkgs; [
    catppuccin-gtk
    catppuccin-papirus-folders
    papirus-icon-theme
    glib 
  ];

  xdg.configFile."gtk-3.0/bookmarks".text = ''
    file://${config.home.homeDirectory}/Nextcloud/Documents Documents
    file://${config.home.homeDirectory}/Nextcloud/Photos Photos
    file://${config.home.homeDirectory}/Videos Videos
    file://${config.home.homeDirectory}/Downloads Downloads

    # Remote shares
    file:///mnt/share/data/foundry Foundry
    file:///mnt/share/media Media
  '';
}