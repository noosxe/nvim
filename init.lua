-- vim:foldmethod=marker:foldlevel=0

require "keymaps"
require "options"
require "lazy-config"
require "telescope-config"
require "neo-tree-config"
require "whichkey"

-- vim.cmd [[ let g:svelte_preprocessors = ['typescript'] ]]

-- GENERAL SETTINGS

-- Colors {{{

vim.cmd[[colorscheme tokyonight]]
vim.cmd[[highlight IndentBlanklineIndent2 guibg=#1a1b26 gui=nocombine]]
vim.cmd[[highlight IndentBlanklineIndent1 guibg=#16161e gui=nocombine]]

-- }}} Colors

