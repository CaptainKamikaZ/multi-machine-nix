{ pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };

    # GTK3 dark preference
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    # GTK4 dark preference
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    # GTK2 generates ~/.gtkrc-2.0 automatically
    gtk2.extraConfig = ''
      gtk-theme-name="Breeze-Dark"
    '';
  };

  # Allow GTK2 to overwrite the existing ~/.gtkrc-2.0 file
  home.file.".gtkrc-2.0".force = true;

  # Ensure GTK apps respect the theme
  home.sessionVariables.GTK_THEME = "Breeze-Dark";
}
