{ config, pkgs, lib, device, ... }:

let
  cfg = config.features.niri;

  # Choose terminal based on device (you can expand this later)
  terminalCmd = "kitty";

  # Load your base KDL config
  rawConfig = builtins.readFile ./config.kdl;

  # Replace @TERMINAL@ placeholder
  finalConfig = builtins.replaceStrings
    [ "@TERMINAL@" ]
    [ terminalCmd ]
    rawConfig;

  # Desktop monitor layout
  desktopOutputs = ''
    output "DP-3" {
      mode "1920x1080@60.000"
      scale 1
      transform "normal"
      position x=0 y=1080
      focus-at-startup
    }
    output "DP-2" {
      mode "1600x900@59.978"
      scale 1
      transform "270"
      position x=1920 y=700
    }
    output "HDMI-A-1" {
      mode "1920x1080@60.000"
      scale 1
      transform "normal"
      position x=0 y=0
    }
  '';

  # ThinkPad monitor layout
  thinkpadOutputs = ''
    output "eDP-1" {
      mode "1920x1080@60"
      scale 1.25
      transform "normal"
    }
  '';

  # HP laptop monitor layout
  hpLaptopOutputs = ''
    output "eDP-1" {
      mode "1920x1080@60.01"
      scale 1.5
      transform "normal"
    }
  '';

  # Choose output config based on device
  outputConfig =
    if device == "desktop" then desktopOutputs
    else if device == "thinkpad" then thinkpadOutputs
    else if device == "hp-laptop" then hpLaptopOutputs
    else "";
in
{
  options.features.niri = {
    enable = lib.mkEnableOption "Enable the Niri compositor feature";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.niri;
      description = "Which Niri package to use (wrapped or upstream).";
    };
  };

  config = lib.mkIf cfg.enable {

    #
    # Install Niri system-wide
    #
    environment.systemPackages = [
      cfg.package
    ];

    #
    # Provide Niri session to the display manager
    #
    services.displayManager = {
      enable = true;
      defaultSession = "niri";
      sessionPackages = [ cfg.package ];
    };

    #
    # Home‑Manager config installation
    #
    home-manager.users.justin = {
      xdg.enable = true;

      xdg.configFile."niri/config.kdl".text =
        ''
          // Output configuration injected by Home Manager
          ${outputConfig}
        ''
        + finalConfig;

      programs.niri = {
        enable = true;
        package = cfg.package;
      };
    };

    #
    # Wayland environment variables
    #
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };
  };
}
