-- Indentation: 4 spaces, converted from tabs
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Wrap existing lines nicely
vim.opt.breakindent = true

-- Line numbers: absolute + relative
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true

-- Persist undo history across sessions
vim.opt.undofile = true

-- Mouse support (resizable splits, scrolling)
vim.opt.mouse = "a"

-- Mode is shown by the statusline
vim.opt.showmode = false

-- Case-insensitive search unless \C or a capital letter is used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep the signcolumn always open (avoids layout shifts from diagnostics)
vim.opt.signcolumn = "yes"

vim.opt.splitright = true
vim.opt.splitbelow = true

-- Show invisible whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "⋅", nbsp = "␣" }

-- Context lines around the cursor
vim.opt.scrolloff = 10

-- True colors (required by gruvbox and virtually every modern theme)
vim.opt.termguicolors = true

-- System clipboard sync.
-- NOTE: setting this option resolves the clipboard provider on first use.
-- On Windows, if win32yank.exe is missing Neovim falls back to spawning
-- powershell.exe for every yank/paste (300ms-2s each!). Setting it inside
-- vim.schedule() keeps the provider probe from blocking startup.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

if vim.fn.has("win32") == 1 and vim.fn.executable("win32yank.exe") ~= 1 then
	vim.notify(
		[[
win32yank.exe not found — clipboard operations will be SLOW
(powershell fallback spawns a shell for every yank/paste).
Fix: scoop install win32yank   (or download from github.com/equalsraf/win32yank)]],
		vim.log.levels.WARN
	)
end
