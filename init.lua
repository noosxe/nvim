-- vim:foldmethod=marker:foldlevel=0

require "keymaps"
require "options"
require "lazy-config"
require "whichkey"

-- vim.cmd [[ let g:svelte_preprocessors = ['typescript'] ]]

-- GENERAL SETTINGS

-- Spaces & Tabs {{{
--[[
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
--]]
-- }}} Spaces & Tabs

-- UI Config {{{
--[[
vim.o.number = true
vim.o.relativenumber = true
vim.o.showcmd = true
vim.o.showmatch = true
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.winblend = 30
vim.diagnostic.config({
  virtual_text = true,
})
vim.opt.list = true
vim.opt.listchars:append "eol:↴"
--]]
-- }}} UI Config

-- Colors {{{

vim.cmd[[colorscheme tokyonight]]
vim.cmd[[highlight IndentBlanklineIndent2 guibg=#1a1b26 gui=nocombine]]
vim.cmd[[highlight IndentBlanklineIndent1 guibg=#16161e gui=nocombine]]

-- }}} Colors

-- Behavior {{{
--[[
vim.o.mouse = 'a'
vim.o.wildignorecase = true
vim.o.wildoptions = 'fuzzy,pum,tagfile'

vim.diagnostic.config {
  virtual_text = true,
  virtual_lines = { only_current_line = true }
}
vim.o.clipboard = "unnamedplus"
--]]
-- }}} Behavior

-- Telescope {{{
--[[
local builtin = prequire('telescope.builtin')

if builtin then
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
end
--]]
-- }}} Telescope

-- Trouble {{{

vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)

-- }}} Trouble

