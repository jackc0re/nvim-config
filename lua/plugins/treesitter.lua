-- nvim-treesitter (main branch, the 2025 rewrite)
--
-- IMPORTANT: this is NOT the old plugin. Since Neovim 0.11 treesitter
-- highlighting/folding/injections are built into Neovim itself; this plugin
-- now only installs and updates parsers.
--
-- Windows requirements (parser compilation happens locally):
--   * tree-sitter CLI:  npm i -g tree-sitter-cli  (or: scoop install tree-sitter)
--   * a C compiler:     MSVC (cl.exe), gcc (msys2 / scoop install gcc), or zig
--     (if cl.exe is missing, this config auto-points the build at gcc)
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",

	config = function()
		-- Register the install dir explicitly: setup() prepends it to the
		-- runtimepath, which is required for parser/query discovery (without
		-- this, :checkhealth reports "is not in runtimepath" on Windows).
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		-- The tree-sitter CLI defaults to MSVC (cl.exe) on Windows and fails
		-- with "program not found" when VS Build Tools aren't installed. Fall
		-- back to gcc (msys2/scoop) for parser compilation. Setting it here only
		-- affects this nvim process and its children — not the global env, so
		-- cargo/other tools are untouched.
		if vim.fn.has("win32") == 1 and vim.env.CC == nil then
			if vim.fn.executable("cl.exe") ~= 1 and vim.fn.executable("gcc") == 1 then
				vim.env.CC = "gcc"
			end
		end

		-- Parsers you want installed. Adjust to the languages you use.
		local ensure_installed = {
			"bash",
			"c",
			"cpp",
			"css",
			"go",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"rust",
			"sql",
			"toml",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
		}

		-- Only install what's missing (avoid reinstall churn on every startup)
		local installed = require("nvim-treesitter.config").get_installed()
		local missing = vim
			.iter(ensure_installed)
			:filter(function(parser)
				return not vim.tbl_contains(installed, parser)
			end)
			:totable()
		if #missing > 0 then
			require("nvim-treesitter").install(missing)
		end

		-- Treesitter highlighting is on by default in Neovim 0.11+, but make
		-- it explicit (and disable regex syntax) + use treesitter indentation.
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
			callback = function(ev)
				pcall(vim.treesitter.start, ev.buf)
				vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
