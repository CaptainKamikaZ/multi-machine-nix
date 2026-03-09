local wezterm = require("wezterm")

local config = {}

-- Appearance ---------------------------------------------------------------

config.color_scheme = "Tokyo Night Storm"  -- Best match for your cosmic background

config.window_background_opacity = 0.9
config.text_background_opacity = 0.9

config.macos_window_background_blur = 0  -- ignored on Linux but harmless
config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}

-- Fonts --------------------------------------------------------------------

config.font = wezterm.font_with_fallback({
  "JetBrains Mono Regular",
  "Hack",
})
config.font_size = 12
config.line_height = 1.0

-- Window Frame -------------------------------------------------------------

config.window_decorations = "RESIZE"  -- clean borderless look under Niri
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

config.window_frame = {
  active_titlebar_bg = "#1a1b26",
  inactive_titlebar_bg = "#1a1b26",
  border_left_width = "0px",
  border_right_width = "0px",
  border_bottom_height = "0px",
  border_top_height = "0px",
}

-- Cursor -------------------------------------------------------------------

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 600
config.cursor_thickness = 2

-- Keybindings --------------------------------------------------------------

config.keys = {
  -- Split panes
  { key = "d", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({}) },
  { key = "d", mods = "CTRL|ALT", action = wezterm.action.SplitVertical({}) },

  -- Pane navigation
  { key = "h", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "l", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "k", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "j", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Down") },

  -- Resize panes
  { key = "H", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 3 }) },
  { key = "L", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 3 }) },
  { key = "K", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 2 }) },
  { key = "J", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 2 }) },

  -- Tabs
  { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("DefaultDomain") },
  { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
  { key = "Tab", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
  { key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },

  -- Quick launcher
  { key = "p", mods = "CTRL|SHIFT", action = wezterm.action.ShowLauncher },
}

-- Misc ---------------------------------------------------------------------

config.scrollback_lines = 5000
config.audible_bell = "Disabled"
config.enable_wayland = false

return config
