-- lualine — statusline with native gruvbox integration
-- (the theme sets `enable.lualine = true`, so theme = "auto" just works)
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",

	opts = {
		options = {
			theme = "auto",
			globalstatus = true, -- one statusline for all windows
			component_separators = { left = "│", right = "│" },
			section_separators = {},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff" },
			lualine_c = { { "filename", path = 1 } }, -- relative path
			lualine_x = {
				{ "diagnostics", sources = { "nvim_diagnostic" } },
				"encoding",
				"filetype",
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
}
