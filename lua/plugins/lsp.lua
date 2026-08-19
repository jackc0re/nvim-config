-- LSP configuration — modern Neovim (0.11+) style.
--
-- The old `require('lspconfig')[server].setup{}` + mason-lspconfig handler
-- framework is deprecated. Servers are now defined with vim.lsp.config()
-- and activated with vim.lsp.enable(). nvim-lspconfig still provides the
-- per-server default configs; mason just installs the binaries.
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Installs LSP servers/formatters into stdpath("data")/mason/bin
		-- (mason's setup() adds that dir to PATH so lspconfig finds them)
		{ "williamboman/mason.nvim", opts = {} },
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			opts = {},
		},
		-- LSP progress notifications (loads only when an LSP attaches)
		{ "j-hui/fidget.nvim", opts = {}, event = "LspAttach" },
	},

	config = function()
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			},
			virtual_text = {
				source = "if_many",
				spacing = 2,
				format = function(diagnostic)
					return diagnostic.message
				end,
			},
		})

		-- Buffer-local keymaps + document highlights whenever an LSP attaches
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
				map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
				map("gy", require("fzf-lua").lsp_typedefs, "[T]ype [D]efinition")
				map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>cr", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				local client = vim.lsp.get_client_by_id(event.data.client_id)

				-- Highlight references of the word under the cursor
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
					local highlight_augroup =
						vim.api.nvim_create_augroup("user-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("user-lsp-detach", { clear = true }),
						callback = function(ev2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "user-lsp-highlight", buffer = ev2.buf })
						end,
					})
				end

				-- Inlay hints toggle
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		local capabilities = require("blink-cmp").get_lsp_capabilities()

		-- Language servers to enable. Each entry can override cmd/filetypes/
		-- settings/capabilities of the defaults shipped by nvim-lspconfig.
		local servers = {
			bashls = {},
			marksman = {},
			clangd = {},
			gopls = {},
			pyright = {},
			-- Rust is handled by rustaceanvim (rustowl was removed: it is NOT
			-- the Rust LSP, just an optional lifetime-visualization tool)
			lua_ls = {
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
						diagnostics = { disable = { "missing-fields" } },
					},
				},
			},
		}

		for server_name, server_cfg in pairs(servers) do
			vim.lsp.config(server_name, vim.tbl_deep_extend("force", {
				capabilities = capabilities,
			}, server_cfg))
			vim.lsp.enable(server_name)
		end

		-- Install servers + tooling via Mason (async, only what's missing).
		-- NOTE: these are Mason package names, which differ from lspconfig
		-- server names: lua_ls -> "lua-language-server", bashls ->
		-- "bash-language-server". Passing lspconfig names makes mason error
		-- with `Cannot find package "lua_ls"`.
		require("mason-tool-installer").setup({
			ensure_installed = {
				"bash-language-server", -- bashls
				"clangd",
				"gopls",
				"lua-language-server", -- lua_ls
				"marksman",
				"pyright",
				"stylua", -- Lua formatter
				"prettierd", -- JS/TS formatter
			},
		})
	end,
}
