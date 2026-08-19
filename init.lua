-- Leader keys must be set before lazy.nvim loads any plugins.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
