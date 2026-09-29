{ pkgs, config, ... }:
{
  gtk = {
    enable = true;

    font = {
      name = "Inter";
      size = 11;
    };

    # Baseline dark theme structure required for GTK3 apps like Thunar
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

  # Make sure adw-gtk3 is installed
  home.packages = with pkgs; [
    adw-gtk3
    glib
  ];

  # Import Noctalia's actual CSS target file into GTK3
  xdg.configFile."gtk-3.0/gtk.css".text = ''
    @import url("${config.home.homeDirectory}/.config/gtk-3.0/noctalia.css");
  '';
    xdg.configFile."gtk-4.0/gtk.css".text = ''
    @import url("${config.home.homeDirectory}/.config/gtk-4.0/noctalia.css");
  '';

  # Keep your bookmarks
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