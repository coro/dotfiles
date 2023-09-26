local wezterm = require("wezterm")
return {
  font = wezterm.font 'JetBrains Mono',
  font_size = 13.0,
  color_scheme = "nightfox",
  tab_bar_at_bottom = true,
  window_background_opacity = 0.9,
  macos_window_background_blur = 7,
  mouse_wheel_scrolls_tabs = false,
  use_fancy_tab_bar = false,
  leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 1000 },
  keys = {
    {
      key = 'c',
      mods = 'LEADER',
      action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    },
    {
      key = '-',
      mods = 'LEADER',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = '_',
      mods = 'LEADER',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    { key = 'phys:1', mods = 'SHIFT|CTRL', action = wezterm.action.ActivateTab(0) },
    { key = 'phys:2', mods = 'SHIFT|CTRL', action = wezterm.action.ActivateTab(1) },
    { key = 'phys:3', mods = 'SHIFT|CTRL', action = wezterm.action.ActivateTab(2) },
    { key = 'phys:4', mods = 'SHIFT|CTRL', action = wezterm.action.ActivateTab(3) },
    { key = 'phys:5', mods = 'SHIFT|CTRL', action = wezterm.action.ActivateTab(4) },
    { key = 'phys:6', mods = 'SHIFT|CTRL', action = wezterm.action.ActivateTab(5) },
    { key = 'phys:7', mods = 'SHIFT|CTRL', action = wezterm.action.ActivateTab(6) },
    { key = 'Backspace', mods = 'SHIFT|CTRL', action = wezterm.action.ClearScrollback("ScrollbackAndViewport") },
  },
}
