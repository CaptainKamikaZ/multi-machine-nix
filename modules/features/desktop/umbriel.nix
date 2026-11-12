# modules/features/desktop/umbriel.nix
{ config, lib, pkgs, inputs, device, ... }:

{
  imports = [ inputs.umbriel.homeModules.default ];

  programs.umbriel = {
    enable = true;
    settings = {
      general = {
        autostart = [ "noctalia" ];
        show_cheatsheet = true;
        focus_on_activate = true;
      };
      input = {
        keyboard.layout = "us";
        focus = {
          follows_mouse = true;
          follows_mouse_max_scroll = 0.5;
        };
      };  
      output = if device == "desktop" then {
        "DP-1" = {
          mode = "1600x900@59.978";
          scale = 1.0;
          transform = "270";
          position = [ 1920 700 ];
        };
        "DP-2" = {
          mode = "1920x1080@60.000";
          scale = 1.0;
          transform = "normal";
          position = [ 0 1080 ];
        };
        "DP-3" = {
          mode = "1920x1080@60.000";
          scale = 1.0;
          transform = "normal";
          position = [ 0 0 ];
        };
      } else {};

      appearance = {
        prefer_no_csd = true;
        border_width = 2;
        corner_radius = 10;
        blur = {
          enabled = true;
          optimized = true;
          radius = 3;
        };
        shadow = {
          enabled = true;
          softness = 10;
          offset_x = 2;
          offset_y = 2;
        };
      };   

      hot_corners.top_left = {
        enabled = true;
        delay_ms = 500;
        action = "overview-open";
      };

      layout = {
        gap = 5;
        extent_presets = [ 0.333 0.5 0.667 ];  # for Mod+R cycling
      };

      layer_rule = [
        {
          match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";
          blur = true;
          blur_ignore_alpha = 0.6;
          blur_optimized = false;
        }
      ];

      window_rule = [
        {
          match.app_id = "^dev.noctalia.Noctalia$";
          default_floating = true;
        }
        {
          blur = true;
          blur_optimized = true;
        }
      ];   

      keybinds = {
        "Mod+Return" = "spawn kitty";
        "Mod+Q" = "window-close";
        "Mod" = "spawn noctalia msg panel-toggle launcher";
        "Mod+S" = "spawn noctalia msg settings-toggle";
        "Mod+Escape" = "session-quit";
        "Mod+Shift+Escape" = { action = "shortcuts-inhibit-toggle"; allow_when_inhibited = true; repeat = false; };
        "Ctrl+Alt+L" = { action = "spawn noctalia msg session lock"; allow_when_inhibited = true; repeat = false; };
        "Alt+Tab" = "spawn noctalia msg window-switcher hold";

        # Launch apps
        "Mod+B" = "spawn brave";
        "Mod+D" = "spawn thunar";
        "Mod+C" = "spawn code";

        # Media & Brightness
        "XF86AudioRaiseVolume" = { action = "spawn noctalia msg volume-up"; allow_when_locked = true; };
        "XF86AudioLowerVolume" = { action = "spawn noctalia msg volume-down"; allow_when_locked = true; };
        "XF86AudioMute" = { action = "spawn noctalia msg volume-mute"; allow_when_locked = true; repeat = false; };
        "XF86AudioPlay" = { action = "spawn noctalia msg media toggle"; allow_when_locked = true; repeat = false; };
        "XF86AudioNext" = { action = "spawn noctalia msg media next"; allow_when_locked = true; };
        "XF86AudioPrev" = { action = "spawn noctalia msg media previous"; allow_when_locked = true; };
        "XF86MonBrightnessUp" = { action = "spawn noctalia msg brightness-up"; allow_when_locked = true; };
        "XF86MonBrightnessDown" = { action = "spawn noctalia msg brightness-down"; allow_when_locked = true; };

        # Screenshots
        "Print" = "spawn noctalia msg screenshot-fullscreen";
        "Mod+Shift+S" = "spawn noctalia msg screenshot-region --confirm-region";
        "Mod+Shift+A" = "spawn noctalia msg screenshot-annotate";
        "Mod+Shift+W" = "spawn noctalia msg screenshot-window --confirm-window";

        # Navigation & Workspaces
        "Mod+Left" = "window-focus-left";
        "Mod+Down" = "window-focus-down";
        "Mod+Up" = "window-focus-up";
        "Mod+Right" = "window-focus-right";
        "Mod+H" = "window-focus-left";
        "Mod+J" = "window-focus-down";
        "Mod+K" = "window-focus-up";
        "Mod+L" = "window-focus-right";
        "Mod+F1" = "window-focus-next";
        "Mod+Shift+Left" = "column-move-left";
        "Mod+Shift+Down" = "window-move-down";
        "Mod+Shift+Up" = "window-move-up";
        "Mod+Shift+Right" = "column-move-right";

        # Window state
        "Mod+T" = { action = "window-toggle-floating"; repeat = false; };
        "Mod+Shift+T" = { action = "window-focus-switch-floating"; repeat = false; };
        "Mod+P" = { action = "window-toggle-pinned"; repeat = false; };
        "Mod+M" = { action = "window-toggle-maximize-to-edges"; repeat = false; };
        "Mod+F" = { action = "window-toggle-fullscreen"; repeat = false; };
        "Mod+Ctrl+F" = { action = "window-toggle-maximize"; repeat = false; };
        "Mod+R" = "window-cycle-primary-extent";
        "Mod+Shift+R" = "window-cycle-primary-extent-back";
        "Mod+Minus" = "window-modify-primary-extent -0.02";
        "Mod+Equal" = "window-modify-primary-extent +0.02";
        "Mod+Ctrl+Minus" = "window-modify-secondary-extent -0.02";
        "Mod+Ctrl+Equal" = "window-modify-secondary-extent +0.02";
        "Mod+Comma" = "window-consume-left";
        "Mod+Period" = "window-consume-right";
        "Mod+Ctrl+Comma" = "window-consume-from-left";
        "Mod+Ctrl+Period" = "window-consume-from-right";
        "Mod+W" = { action = "column-toggle-tabbed"; repeat = false; };
        "Mod+Alt+Right" = "column-focus-tab-next";
        "Mod+Alt+Left" = "column-focus-tab-previous";
        "Mod+WheelLeft" = "window-focus-left";
        "Mod+WheelRight" = "window-focus-right";
        "Mod+O" = { action = "overview-toggle"; repeat = false; };
        
        # Workspaces
        "Mod+1" = "workspace-switch 1";
        "Mod+2" = "workspace-switch 2";
        "Mod+3" = "workspace-switch 3";
        "Mod+4" = "workspace-switch 4";
        "Mod+5" = "workspace-switch 5";
        "Mod+6" = "workspace-switch 6";
        "Mod+7" = "workspace-switch 7";
        "Mod+8" = "workspace-switch 8";
        "Mod+9" = "workspace-switch 9";
        "Mod+Page_Up" = "workspace-previous";
        "Mod+Page_Down" = "workspace-next";
        "Mod+WheelUp" = "workspace-previous";
        "Mod+WheelDown" = "workspace-next";
        "Mod+Shift+1" = "window-move-to-workspace 1";
        "Mod+Shift+2" = "window-move-to-workspace 2";
        "Mod+Shift+3" = "window-move-to-workspace 3";
        "Mod+Shift+4" = "window-move-to-workspace 4";
        "Mod+Shift+5" = "window-move-to-workspace 5";
        "Mod+Shift+6" = "window-move-to-workspace 6";
        "Mod+Shift+7" = "window-move-to-workspace 7";
        "Mod+Shift+8" = "window-move-to-workspace 8";
        "Mod+Shift+9" = "window-move-to-workspace 9";

        # Scratchpad
        "Mod+Shift+Space" = { action = "window-move-to-scratchpad"; repeat = false; };
        "Mod+Space" = "scratchpad-toggle";
        "Mod+Ctrl+Space" = { action = "window-restore-from-scratchpad"; repeat = false; };
        "Mod+Tab" = "scratchpad-focus-next";
      };

      include.optional.files = [ "${config.home.homeDirectory}/.config/umbriel/noctalia.toml" ];
    };
  };
}