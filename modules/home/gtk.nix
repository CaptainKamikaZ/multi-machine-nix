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

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # Make sure adw-gtk3 and glib are present in user packages
  home.packages = with pkgs; [
    adw-gtk3
    glib
  ];

  # Force dconf/gsettings keys so GTK apps pick up the dark scheme immediately
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "adw-gtk3-dark";
    };
  };

  # Link the theme directly into ~/.themes so GTK3 finds adw-gtk3-dark without GTK_THEME env vars
  home.file.".themes/adw-gtk3-dark".source = "${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark";

  # Keep your GTK bookmarks
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