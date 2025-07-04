-- See https://wezfurlong.org/wezterm/

local wezterm = require("wezterm")
local action = wezterm.action
local action_callback = wezterm.action_callback

local config = wezterm.config_builder()

local theme = "Kanagawa (Gogh)"
-- local theme = "Cloud (terminal.sexy)"
-- local theme = "Hybrid (terminal.sexy)"

config.check_for_updates = false
config.color_scheme = theme
config.inactive_pane_hsb = {
	hue = 1.0,
	saturation = 1.0,
	brightness = 1.0,
}

config.font = wezterm.font("Berkeley Mono NF", {stretch="SemiCondensed", weight="Medium"})
config.font_size = 19.0
config.freetype_load_flags = "NO_HINTING"

config.set_environment_variables = {}
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.window_decorations = "RESIZE"
config.scrollback_lines = 10000

config.enable_kitty_keyboard = false
config.send_composed_key_when_right_alt_is_pressed = false
config.disable_default_key_bindings = true
config.tab_bar_at_bottom = false

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

tabline.setup({
	options = {
		theme = theme,
		section_separators = {
			left = wezterm.nerdfonts.ple_lower_left_triangle,
			right = wezterm.nerdfonts.ple_lower_right_triangle,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.ple_right_half_circle_thick,
			right = wezterm.nerdfonts.ple_left_half_circle_thick,
		},
		color_overrides = {
			block_mode = {
				a = { fg = "#181825", bg = "#cba6f7" },
				b = { fg = "#cba6f7", bg = "#313244" },
				c = { fg = "#cdd6f4", bg = "#181825" },
			},
		},
	},
	sections = {
		tabline_b = {},
		tabline_x = {},
		tabline_y = { "datetime" },

		tab_inactive = { "index", { "parent", padding = 0 }, "/", { "cwd", padding = { left = 0, right = 1 } } },
	},
})

tabline.apply_to_config(config)

local function edit_with_scrollback(window, pane)
	local scrollback = window:get_selection_text_for_pane(pane)
	if scrollback == nil or scrollback == "" then
		return
	end

	local filename = os.tmpname()
	local f = io.open(filename, "w+")
	if not f then
		return
	end

	local success = f:write(scrollback)
	if not success then
		f:close()
		return
	end

	f:flush()
	f:close()

	-- Open a new window
	window:perform_action(
		action.Multiple({
			action.SpawnCommandInNewWindow({
				args = { "/opt/homebrew/bin/hx", filename },
				cwd = pane:get_current_working_dir(),
			}),
			-- action.CopyMode 'Close',
		}),
		pane
	)

	-- Wait file to be read by vim and then remove it
	wezterm.sleep_ms(1000)
	os.remove(filename)
end

local function select_block_backward(window, pane)
	if window:active_key_table() ~= "copy_mode" then
		window:perform_action(action.ActivateCopyMode, pane)
	end

	window:perform_action(
		action.Multiple({
			action.CopyMode("ClearSelectionMode"),
			action.CopyMode({ MoveBackwardZoneOfType = "Output" }),
			action.CopyMode({ SetSelectionMode = "SemanticZone" }),
		}),
		pane
	)
end

local function select_block_forward(window, pane)
	if window:active_key_table() ~= "copy_mode" then
		window:perform_action(action.ActivateCopyMode, pane)
	end

	window:perform_action(
		action.Multiple({
			action.CopyMode("ClearSelectionMode"),
			action.CopyMode({ MoveForwardZoneOfType = "Output" }),
			action.CopyMode({ SetSelectionMode = "SemanticZone" }),
		}),
		pane
	)
end

local function basename(s)
	if type(s) ~= "string" then
		return
	end
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local editors = { "hx", "nvim" }

local function is_editor(name)
	if type(name) ~= "string" or not name then
		return
	end

	for _, editor in pairs(editors) do
		if name == editor then
			return true
		end
	end
	return false
end

local function close_pane_if_not_in_editor(window, pane, key, mods)
	local proc_name = basename(pane:get_foreground_process_name())

	if is_editor(proc_name) then
		window:perform_action(action.SendKey({ mods = mods, key = key }), pane)
	else
		window:perform_action(action.CloseCurrentPane({ confirm = true }), pane)
	end
end

config.mouse_bindings = {
	{
		event = { Down = { streak = 3, button = "Left" } },
		action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
		mods = "NONE",
	},
}

config.keys = {
	{ key = "-", mods = "CMD", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "1", mods = "CMD", action = action.ActivateTab(0) },
	{ key = "2", mods = "CMD", action = action.ActivateTab(1) },
	{ key = "3", mods = "CMD", action = action.ActivateTab(2) },
	{ key = "4", mods = "CMD", action = action.ActivateTab(3) },
	{ key = "5", mods = "CMD", action = action.ActivateTab(4) },
	{ key = "6", mods = "CMD", action = action.ActivateTab(5) },
	{ key = "7", mods = "CMD", action = action.ActivateTab(6) },
	{ key = "8", mods = "CMD", action = action.ActivateTab(7) },
	{ key = "9", mods = "CMD", action = action.ActivateTab(8) },
	{ key = "=", mods = "CMD", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "D", mods = "CMD", action = action.ScrollByPage(1) },
	{ key = "L", mods = "CMD", action = action.ShowDebugOverlay },
	{
		key = "P",
		mods = "CMD",
		action = action.QuickSelectArgs({
			label = "open url",
			patterns = { "https?://\\S+" },
			action = action_callback(function(window, pane)
				local url = window:get_selection_text_for_pane(pane)
				wezterm.open_with(url)
			end),
		}),
	},
	{ key = "U", mods = "CMD", action = action.ScrollByPage(-1) },
	{ key = "[", mods = "CMD", action = action.ActivateCopyMode },
	{ key = "c", mods = "CMD", action = action.CopyTo("Clipboard") },
	{ key = "e", mods = "CMD", action = action_callback(edit_with_scrollback) },
	{ key = "f", mods = "CMD", action = action.Search({ CaseInSensitiveString = "" }) },
	{ key = "p", mods = "CMD", action = action.QuickSelect },
	{ key = "t", mods = "CMD", action = action.SpawnTab("CurrentPaneDomain") },
	{ key = "v", mods = "CMD", action = action.PasteFrom("Clipboard") },
	
	{ key = "LeftArrow",  mods = "CMD", action = action.ActivatePaneDirection("Left") },
	{ key = "DownArrow",  mods = "CMD", action = action.ActivatePaneDirection("Down") },
	{ key = "UpArrow",    mods = "CMD", action = action.ActivatePaneDirection("Up") },
	{ key = "RightArrow", mods = "CMD", action = action.ActivatePaneDirection("Right") },
	{ key = "LeftArrow",  mods = "CMD|SHIFT", action = action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "DownArrow",  mods = "CMD|SHIFT", action = action.AdjustPaneSize({ "Down", 5 }) },
	{ key = "UpArrow",    mods = "CMD|SHIFT", action = action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "RightArrow", mods = "CMD|SHIFT", action = action.AdjustPaneSize({ "Right", 5 }) },
	
	{
		key = "w",
		mods = "CMD",
		action = action_callback(function(window, pane)
			close_pane_if_not_in_editor(window, pane, utf8.char(0x1E), nil)
		end),
	},
	{ key = "z", mods = "CMD", action = action.TogglePaneZoomState },
	{ key = "UpArrow", mods = "CMD|ALT", action = action_callback(select_block_backward) },
	{ key = "DownArrow", mods = "CMD|ALT", action = action_callback(select_block_forward) },
}

local function trim_enter_from_selection(window, pane)
  local selection_text = window:get_selection_text_for_pane(pane)
  if selection_text then
    -- Trim trailing newlines and spaces
    local trimmed_text = selection_text:gsub("⏎%s+$", "")
    window:copy_to_clipboard(trimmed_text)
  end
	window:perform_action(
		action.Multiple({
			action.ScrollToBottom,
			action.CopyMode("Close"),
		}),
		pane
	)
end

local copy_mode = wezterm.gui.default_key_tables().copy_mode
table.insert(copy_mode, { key = 'y', mods = 'NONE', action = action_callback(trim_enter_from_selection) })
config.key_tables = { copy_mode = copy_mode }

return config

