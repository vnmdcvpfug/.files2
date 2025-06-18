local wezterm = require 'wezterm'
local current_theme = require('current_theme')
local current_opacity = require('current_opacity')

local config = {
  enable_wayland = false,
  window_decorations = "NONE",
  use_resize_increments = true,
  enable_tab_bar = false,
  default_cursor_style = "SteadyUnderline",
  font = wezterm.font('Noto Sans Mono', { weight = 'Regular', italic = false }),
  font_size = 13.0,
  window_background_opacity = 1.00,
  window_padding = {
    left =   4,
    right =  4,
    top =    4,
    bottom = 4,
  },
  keys = {
    { key = 'w', mods = 'SUPER', action = wezterm.action.Nop },
  }
}

config.window_background_opacity = current_opacity.opacity
config.colors = current_theme.colors
return config
