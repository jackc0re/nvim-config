-- Tabline showing tabs (bufferline in "tabs" mode)
return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "UIEnter",
	opts = {
		options = {
			mode = "tabs",
			separator_style = "slant",
		},
	},
}
