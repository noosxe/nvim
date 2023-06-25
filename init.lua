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
vim.o.termguicolors = true
-- }}} UI Config

-- Colors {{{
vim.cmd[[colorscheme tokyonight-night]]
-- }}} Colors

vim.o.mouse = 'a'

-- Telescope {{{

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- }}} Telescope

