-- obsidian.nvim — tools for working with Markdown notes in your Obsidian vault
-- Docs: https://github.com/obsidian-nvim/obsidian.nvim
-- All commands live under :Obsidian (try :Obsidian help)
return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended: track latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	cmd = "Obsidian",
	keys = {
		{ "<leader>oo", "<cmd>Obsidian quick_switch<cr>", desc = "Obsidian Open Note (switch)" },
		{ "<leader>on", "<cmd>Obsidian new<cr>", desc = "Obsidian New Note" },
		{ "<leader>os", "<cmd>Obsidian search<cr>", desc = "Obsidian Search (ripgrep)" },
		{ "<leader>ot", "<cmd>Obsidian today<cr>", desc = "Obsidian Today's Daily Note" },
		{ "<leader>od", "<cmd>Obsidian dailies<cr>", desc = "Obsidian Recent Dailies" },
		{ "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Obsidian Backlinks" },
		{ "<leader>oc", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Obsidian Toggle Checkbox" },
		{ "<leader>ol", "<cmd>Obsidian links<cr>", desc = "Obsidian Show Note Links" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
	},
	opts = {
		workspaces = {
			{
				name = "RuesLaTete",
				path = "D:/RuesLaTete/RuesLaTete",
			},
		},

		-- New notes land in the vault inbox, per the vault's AGENTS.md
		notes_subdir = "00. INBOX",
		new_note_location = "notes_subdir",

		-- Vault convention: descriptive titles with spaces, not random IDs
		note_id_func = function(title)
			if title == nil or title == "" then
				return os.time() .. "-" .. tostring(os.date("%Y-%m-%d"))
			end
			-- keep the title readable, strip characters illegal on Windows
			return title:gsub('[<>:"/\\|?*]', "-"):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
		end,

		-- Daily notes: 04.Journal/YYYY/YYYY-MM-DD.md (matches existing files)
		daily_notes = {
			-- NOTE: must be a string (a function here breaks Workspace.set mkdir in 3.16.x).
			-- Evaluated at startup, so the year rolls over on the next nvim launch.
			folder = "04.Journal/" .. os.date("%Y"),
			date_format = "%Y-%m-%d",
		},

		-- Templates shipped in the vault (e.g. :Obsidian template Zettel)
		templates = {
			subdir = "99.System/Templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
		},

		-- Frontmatter per the vault's AGENTS.md (type/created/tags)
		note_frontmatter = function(note)
			local path = tostring(note.path or "")
			if path:find("04.Journal", 1, true) then
				return {
					type = "daily",
					created = os.date("%Y-%m-%d %H:%M"),
					tags = { "daily" },
				}
			end
			return {
				type = "inbox",
				created = os.date("%Y-%m-%d %H:%M"),
				tags = { "inbox" },
			}
		end,

		-- NOTE: completion is provided by obsidian.nvim's built-in LSP server
		-- (obsidian-ls) — no completion config needed.
		finder = "fzf-lua",

		-- Disable built-in UI tweaks; render-markdown.nvim handles the pretty stuff
		ui = { enable = false },

		mappings = {
			-- <CR>: follow link / toggle checkbox / open tag, depending on cursor
			["<cr>"] = "smart_action",
			-- Jump to prev/next [[link]] in the buffer
			["[o"] = "nav_link_prev",
			["]o"] = "nav_link_next",
		},
	},
}
