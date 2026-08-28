-- tv.nvim — television (tv) inside a floating neovim window.
--
-- fzf-lua stays THE picker for files/grep/LSP (see fzf-lua.lua); this plugin
-- bridges the stuff only tv can do into neovim: tldr, zoxide, gh-repos,
-- docker, scoop-apps, recent-files, and every other channel in
-- %LOCALAPPDATA%\television\config\cable\.
--
-- Requires on PATH: television (scoop install television)
-- Usage: `:Tv <channel>` (Tab-completed) or `:Tv` for the channel selector.
--
-- Keybinds live under <leader>t (tab mappings keep to/tx/tn/tp/tf, these use
-- different suffixes): tt selector, tl tldr, tz zoxide, tg gh-repos,
-- tr recent-files, td docker-containers.
return {
	"alexpasmantier/tv.nvim",
	lazy = true,
	cmd = "Tv",
	keys = {
		{ "<leader>tt", "<cmd>Tv<cr>", desc = "tv: channel selector" },
		{ "<leader>tl", "<cmd>Tv tldr<cr>", desc = "tv: tldr pages" },
		{ "<leader>tz", "<cmd>Tv zoxide<cr>", desc = "tv: zoxide directories" },
		{ "<leader>tg", "<cmd>Tv gh-repos<cr>", desc = "tv: github repos" },
		{ "<leader>tr", "<cmd>Tv recent-files<cr>", desc = "tv: recent files" },
		{ "<leader>td", "<cmd>Tv docker-containers<cr>", desc = "tv: docker containers" },
	},
	config = function()
		local h = require("tv").handlers

		require("tv").setup({
			window = {
				width = 0.85,
				height = 0.85,
				border = "rounded",
				title = " tv ",
				title_pos = "center",
			},
			channels = {
				-- reachable via `:Tv <channel>`; Enter falls back to
				-- h.open_as_files unless overridden here
				text = {
					handlers = {
						["<CR>"] = h.open_at_line, -- jump to file:line
						["<C-q>"] = h.send_to_quickfix,
					},
				},
				["recent-files"] = {
					handlers = {
						["<CR>"] = h.open_as_files,
						["<C-q>"] = h.send_to_quickfix,
					},
				},
				tldr = {
					handlers = {
						["<CR>"] = h.copy_to_clipboard,
					},
				},
				zoxide = {
					handlers = {
						-- cd the current tab into the picked directory
						["<CR>"] = function(entries)
							vim.cmd("tcd " .. vim.fn.fnameescape(entries[1]))
						end,
					},
				},
				["gh-repos"] = {
					handlers = {
						["<CR>"] = function(entries)
							vim.ui.open("https://github.com/" .. entries[1])
						end,
						["<C-y>"] = h.copy_to_clipboard,
					},
				},
				["docker-containers"] = {
					handlers = {
						["<CR>"] = h.copy_to_clipboard,
					},
				},
			},
		})
	end,
}
