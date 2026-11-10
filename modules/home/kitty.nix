{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 13;
    };

    settings = {
      background_opacity = "0.8";
      background_tint = "1.0";
      background_blur = "32";
      dynamic_background_opacity = true;
      dim_opacity = "1.0";
      window_padding_width = 8;
      cursor_blink_interval = 0;
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      scrollback_lines = 10000;
      enable_audio_bell = "no";
      confirm_os_window_close = 0;
      cursor_shape = "block";
      shell_integration = "no-cursor";

      # Disable focus-based window dimming inside Kitty settings
      inactive_text_alpha = "1.0";
    };

  extraConfig = ''
    include themes/noctalia.conf
  '';
  };
}