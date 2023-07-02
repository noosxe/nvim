-- vim:foldmethod=marker:foldlevel=0

-- Dependencies

require("plugins")

vim.cmd [[ let g:svelte_preprocessors = ['typescript'] ]]

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
vim.o.winblend = 30
vim.diagnostic.config({
  virtual_text = true,
})
vim.opt.list = true
vim.opt.listchars:append "eol:↴"

-- }}} UI Config

-- Colors {{{

vim.cmd[[colorscheme tokyonight-night]]
vim.cmd[[highlight IndentBlanklineIndent1 guibg=#1a1b26 gui=nocombine]]
vim.cmd[[highlight IndentBlanklineIndent2 guibg=#16161e gui=nocombine]]

-- }}} Colors

-- Behavior {{{

vim.o.mouse = 'a'
vim.o.wildignorecase = true
vim.o.wildoptions = 'fuzzy,pum,tagfile'

vim.diagnostic.config {
  virtual_text = false,
  virtual_lines = { only_current_line = true }
}

-- }}} Behavior

-- Telescope {{{

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- }}} Telescope

-- Trouble {{{

vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)

-- }}} Trouble

-- Lualine {{{

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- }}} Lualine
