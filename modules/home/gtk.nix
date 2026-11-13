{ pkgs, config, ... }:
{
  gtk = {
    enable = true;
    font = {
      name = "Inter";
      size = 11;
    };
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    colorScheme = "dark";
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  xdg.configFile."gtk-3.0/gtk.css".text = ''
    @import url("noctalia.css");
  '';
  xdg.configFile."gtk-4.0/gtk.css".text = ''
    @import url("noctalia.css");
  '';

  xdg.configFile."gtk-3.0/bookmarks".text = ''
    file://${config.home.homeDirectory}/Nextcloud/Documents Documents
    file://${config.home.homeDirectory}/Nextcloud/Photos Photos
    file://${config.home.homeDirectory}/Videos Videos
    file://${config.home.homeDirectory}/Downloads Downloads

    # Remote shares
    file:///mnt/share/media Media
  '';
}   