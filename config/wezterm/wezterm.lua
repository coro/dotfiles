local wezterm = require("wezterm")
return {
  font = wezterm.font 'JetBrains Mono',
  font_size = 13.0,
  background = {
    {
      source = {
        File = wezterm.config_dir .. '/Coriolis_Station.png'
      },
      hsb = {
        brightness = 0.1
      },
      horizontal_align = "Center",
      vertical_align = "Middle",
    },
  },
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
  },
}
