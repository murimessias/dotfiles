local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config = {
  color_scheme = "Catppuccin Frappe",
  hide_tab_bar_if_only_one_tab = true,
  window_padding = {
    bottom = 32,
    left = 32,
    right = 32,
    top = 32,
  },
  font_size = 13,
  line_height = 1.24,
  ---- Font Settings ----
  font = wezterm.font_with_fallback {
    {
      family = 'JetBrains Mono',
    },
    {
      family = "Symbols Nerd Font Mono",
      scale = 0.8,
    }
  },
}

return config
