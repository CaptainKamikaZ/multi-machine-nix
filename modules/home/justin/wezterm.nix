{ pkgs, ... }:

{
  programs.wezterm = {
    enable = true;

    # Load your Lua config directly from dotfiles
    extraConfig = builtins.readFile ../../dotfiles/wezterm/wezterm.lua;
  };

  # Optional: if you want wezterm available as a CLI tool
  home.packages = [
    pkgs.wezterm
  ];
}
