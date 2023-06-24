-- vim:foldmethod=marker:foldlevel=0

-- Dependencies

require("plugins")

-- GENERAL SETTINGS

-- Spaces & Tabs {{{
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
-- }}} Spaces & Tabs

-- UI Config {{{
vim.o.number = true
vim.o.relativenumber = true
vim.o.showcmd = true
vim.o.showmatch = true
vim.o.cursorline = true
-- }}} UI Config

-- Colors {{{
vim.cmd[[colorscheme tokyonight-night]]
-- }}} Colors

vim.o.mouse = 'a'

-- LSP {{{



-- }}} LSP


