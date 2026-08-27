-- render-markdown.nvim — in-buffer Markdown rendering (headings, checkboxes,
-- tables, code blocks, quotes…) so notes read like the Obsidian preview.
-- Docs: https://github.com/MeanderingProgrammer/render-markdown.nvim
-- Toggle per-buffer with :RenderMarkdown toggle
return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- parsers: markdown, markdown_inline (already ensured)
		"echasnovski/mini.icons", -- icons for headings/bullets (already installed)
	},
	opts = {
		-- Defaults are well-tuned; only tweak what matters.
		heading = {
			sign = false, -- no sign-column icons, keep the gutter clean
		},
		bullet = {
			sign = false,
		},
		-- Keep rendered state when entering insert mode on a line? Default
		-- anti-conceal behavior is sensible: renders everything in normal mode,
		-- reveals raw text on the cursor line so you can still edit it.
		anti_conceal = {
			enabled = true,
		},
	},
}
