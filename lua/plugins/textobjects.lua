-- nvim-treesitter-textobjects (main branch rewrite)
--
-- Syntax-aware textobjects: af/if (function), ac/ic (class), ao (comment),
-- plus parameter swapping with <leader>a / <leader>A.
return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},

	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = {
				-- Automatically jump forward to the textobject, like targets.vim
				lookahead = true,
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
				include_surrounding_whitespace = true,
			},
			move = {
				set_jumps = true, -- whether to set jumps in the jumplist
			},
		})

		local select = require("nvim-treesitter-textobjects.select")
		local map_textobject = function(keys, query, desc)
			vim.keymap.set({ "x", "o" }, keys, function()
				select.select_textobject(query, "textobjects")
			end, { desc = desc })
		end

		map_textobject("af", "@function.outer", "Outer function")
		map_textobject("if", "@function.inner", "Inner function")
		map_textobject("ac", "@class.outer", "Outer class")
		map_textobject("ic", "@class.inner", "Inner class")
		map_textobject("ao", "@comment.outer", "Outer comment")

		-- Swap function parameters/arguments
		local swap = require("nvim-treesitter-textobjects.swap")
		vim.keymap.set("n", "<leader>a", function()
			swap.swap_next("@parameter.inner")
		end, { desc = "Swap with next parameter" })
		vim.keymap.set("n", "<leader>A", function()
			swap.swap_previous("@parameter.inner")
		end, { desc = "Swap with previous parameter" })

		-- Jump to next/previous function start (overrides built-ins with
		-- treesitter-aware versions)
		local move = require("nvim-treesitter-textobjects.move")
		vim.keymap.set({ "n", "x", "o" }, "]m", function()
			move.goto_next_start("@function.outer", "textobjects")
		end, { desc = "Next function start" })
		vim.keymap.set({ "n", "x", "o" }, "[m", function()
			move.goto_previous_start("@function.outer", "textobjects")
		end, { desc = "Previous function start" })
	end,
}
