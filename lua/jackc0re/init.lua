-- jackc0re — colorscheme loader
-- Usage: `:colorscheme jackc0re` (see colors/jackc0re.lua) or require here.
local M = {}

M.config = {
	transparent = false, -- strip backgrounds from editor chrome
}

---@param opts? { transparent?: boolean }
function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

-- Groups whose background is dropped when `transparent = true`.
local shell_groups = {
	"Normal",
	"NormalNC",
	"NormalFloat",
	"FloatBorder",
	"FloatTitle",
	"MsgArea",
	"LineNr",
	"SignColumn",
	"FoldColumn",
	"WinSeparator",
	"VertSplit",
	"WinBar",
	"WinBarNC",
	"StatusLine",
	"StatusLineNC",
	"TabLine",
	"TabLineFill",
	"TabLineSel",
}

function M.load()
	local palette = require("jackc0re.palette")
	local theme = require("jackc0re.theme")

	vim.cmd.hi("clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd.syntax("reset")
	end
	vim.o.background = "dark"
	vim.g.colors_name = "jackc0re"

	-- Terminal ANSI palette (terminal.ansi.*)
	for i, color in ipairs(palette.terminal_colors()) do
		vim.g["terminal_color_" .. (i - 1)] = color
	end

	local groups = theme.groups(palette)
	if M.config.transparent then
		for _, name in ipairs(shell_groups) do
			if groups[name] then
				groups[name].bg = nil
			end
		end
	end

	for name, opts in pairs(groups) do
		vim.api.nvim_set_hl(0, name, opts)
	end
end

return M
