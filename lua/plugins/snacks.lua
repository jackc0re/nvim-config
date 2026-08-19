-- snacks.nvim — UI utilities, slimmed down for speed.
--
-- Removed vs. the old config:
--   * picker   (fzf-lua is THE picker now)
--   * scroll   (animated smooth scrolling caused jank on Windows Terminal)
--   * scope    (unused)
--   * words    (LSP document highlight already covers reference jumping)
-- Disabled animations in `indent` (static guides render much faster).
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		explorer = { enabled = true },
		indent = { enabled = true, animate = { enabled = false } },
		input = { enabled = true }, -- replaces dressing.nvim
		notifier = { enabled = true, timeout = 3000 },
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
	},

	keys = {
		-- Explorer
		{ "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
		{ "<leader>E", function() Snacks.explorer.reveal() end, desc = "File Explorer (current buffer)" },
		-- Zen / zoom / scratch
		{ "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
		{ "<leader>Z", function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
		{ "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
		{ "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },

		-- Buffers / windows
		{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
		{ "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
		{ "<c-_>", function() Snacks.terminal() end, desc = "which_key_ignore" },

		-- Git
		{ "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
		{ "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },

		-- Notifications
		{ "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
	},

	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging
				_G.dd = function(...) Snacks.debug.inspect(...) end
				_G.bt = function() Snacks.debug.backtrace() end
				vim.print = _G.dd

				-- Toggles
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark Background" })
					:map("<leader>ub")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.indent():map("<leader>ug")
			end,
		})
	end,
}
