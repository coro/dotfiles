local wezterm = require("wezterm")

local HOME_DIR = os.getenv("HOME")
local function get_current_working_dir(tab)
	local current_dir = tab.active_pane.current_working_dir.file_path

	return current_dir == HOME_DIR and wezterm.nerdfonts.md_home
		or string.gsub(current_dir, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	return wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Text = string.format(" %d  %s ", tab.tab_index + 1, get_current_working_dir(tab)) },
	})
end)

return {
	font = wezterm.font("JetBrainsMono NF"),
	font_size = 13.0,
	colors = require("cyberdream"),
	tab_bar_at_bottom = true,
	window_background_opacity = 0.9,
	macos_window_background_blur = 7,
	mouse_wheel_scrolls_tabs = false,
	use_fancy_tab_bar = true,
	leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = (function()
		local k = {
			{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
			{ key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
			{ key = "_", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
			{ key = "Backspace", mods = "SHIFT|CTRL", action = wezterm.action.ClearScrollback("ScrollbackAndViewport") },
		}
		for i = 1, 7 do
			k[#k + 1] = { key = "phys:" .. i, mods = "SHIFT|CTRL", action = wezterm.action.ActivateTab(i - 1) }
		end
		return k
	end)(),
}
