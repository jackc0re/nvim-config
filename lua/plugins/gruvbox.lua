-- gruvbox (motaz-shokry's flavor) — https://gitlab.com/motaz-shokry/gruvbox.nvim
-- Lua gruvbox with a softer #1b1b1b hard background and devicon theming.
return {
	"https://gitlab.com/motaz-shokry/gruvbox.nvim",
	name = "gruvbox",
	lazy = false,
	priority = 1000,

	---@module 'gruvbox'
	---@type gruvbox.Options
	opts = {
		-- variant = "hard", -- auto | hard | medium | soft | light
		dark_variant = "medium",
		dim_inactive_windows = false,
		extend_background_behind_borders = false,

		enable = {
			terminal = true,
			migrations = true,
			devicons = true, -- theme all devicons with gruvbox colors
			lualine = true, -- native lualine integration
		},

		styles = {
			bold = true,
			italic = true,
			transparency = false,
		},
	},

	-- Options must be set before loading the colorscheme
	config = function(_, opts)
		require("gruvbox").setup(opts)
		vim.cmd.colorscheme("gruvbox")
	end,
}
