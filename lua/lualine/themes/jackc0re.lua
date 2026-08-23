-- lualine theme — picked up automatically by lualine's `theme = "auto"`
-- because vim.g.colors_name == "jackc0re".
-- Mode badges use the Zed theme's accent / player colors.
local p = require("jackc0re.palette")

local bg = p.bg
local panel = p.bg_panel
local fg = p.fg_bright
local muted = p.fg_muted
local bg_fg = p.bg -- text on accent backgrounds

return {
	normal = {
		a = { fg = bg_fg, bg = p.cursor, gui = "bold" }, -- players[1].cursor
		b = { fg = fg, bg = panel },
		c = { fg = muted, bg = bg },
	},
	insert = {
		a = { fg = bg_fg, bg = p.blue, gui = "bold" },
		b = { fg = fg, bg = panel },
		c = { fg = muted, bg = bg },
	},
	visual = {
		a = { fg = bg_fg, bg = p.purple, gui = "bold" },
		b = { fg = fg, bg = panel },
		c = { fg = muted, bg = bg },
	},
	replace = {
		a = { fg = bg_fg, bg = p.red, gui = "bold" },
		b = { fg = fg, bg = panel },
		c = { fg = muted, bg = bg },
	},
	command = {
		a = { fg = bg_fg, bg = p.cyan, gui = "bold" },
		b = { fg = fg, bg = panel },
		c = { fg = muted, bg = bg },
	},
	terminal = {
		a = { fg = bg_fg, bg = p.cyan, gui = "bold" },
		b = { fg = fg, bg = panel },
		c = { fg = muted, bg = bg },
	},
	inactive = {
		a = { fg = muted, bg = bg, gui = "bold" },
		b = { fg = p.fg_disabled, bg = bg },
		c = { fg = p.fg_disabled, bg = bg },
	},
}
