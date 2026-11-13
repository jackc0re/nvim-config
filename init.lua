-- Leader keys must be set before lazy.nvim loads any plugins.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")

-- Local colorscheme ported from the Zed theme (see colors/jackc0re.lua).
-- transparent = true lets the terminal's acrylic/blur show through.
require("jackc0re").setup({ transparent = true })
vim.cmd.colorscheme("jackc0re")
