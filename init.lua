-- config

require("config.lazy")

-- Test to see if this will fix the tab issue
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- System clipboard
vim.opt.clipboard = "unnamedplus"
