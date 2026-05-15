{
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./dotfiles/wezterm/wezterm.lua;
  };
}
