{ pkgs, config, ... }:
{
  gtk = {
    enable = true;
    font = {
      name = "Inter";
      size = 11;
    };

    theme = {
      name = "catppuccin-mocha-blue-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        variant = "mocha";
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "blue";
      };
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  home.sessionVariables = {
    GTK_THEME = "catppuccin-mocha-blue-standard";
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    "gtk-2.0/gtkrc" = {
      source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-2.0/gtkrc";
      force = true;
    };
  };

  xdg.configFile."gtk-3.0/bookmarks".text = ''
  file:///home/justin/Nextcloud/Documents Documents
  file:///home/justin/Nextcloud/Photos Photos
  file:///home/justin/Videos Videos
  file:///home/justin/Downloads Downloads

  # Remote shares
  file:///mnt/share/data/foundry Foundry
  file:///mnt/share/media Media

  '';
}
