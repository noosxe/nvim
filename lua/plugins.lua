-- PLUGINS

-- Install packer.
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'folke/tokyonight.nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        tag = "v0.9.1",
        run = ':TSUpdate',
        config = function ()
            require'nvim-treesitter.configs'.setup {
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end
    }
    use 'famiu/bufdelete.nvim'
    use {
        "nvim-neo-tree/neo-tree.nvim",
        tag = "3.6",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function ()
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
            require("neo-tree").setup {
                close_if_last_window = false,
                filesystem = {
                    filtered_items = {
                        visible = true,
                        hide_dotfiles = false,
                        hide_gitignored = false,
                    },
                    use_libuv_file_watcher = true,
                }
            }
        end
    }

    use {
        'williamboman/mason.nvim',
        tag = "v1.8.0",
        requires = {
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',
            {
                'ms-jpq/coq_nvim',
                branch = 'coq',
            },
            {
                'ms-jpq/coq.artifacts',
                branch = 'artifacts',
            },
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()

            vim.cmd([[ let g:coq_settings = { 'auto_start': 'shut-up' } ]])

            local coq = require("coq")

            require("mason-lspconfig").setup_handlers {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function (server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup(coq.lsp_ensure_capabilities {})
                end,
            }
        end
    }

    use {
        'petertriho/nvim-scrollbar',
        config = function()
            require'scrollbar'.setup {}
        end
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require'gitsigns'.setup {}
            require'scrollbar.handlers.gitsigns'.setup {}
        end
    }

    use {
        'akinsho/bufferline.nvim',
        tag = "v4.4.0",
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require'bufferline'.setup {
                options = {
                    diagnostics = 'nvim_lsp',
                    diagnostics_indicator = function(count)
                        return "("..count..")"
                    end,
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "File Explorer",
                            text_align = "left",
                            separator = true,
                        },
                    },
                    separator_style = "thick",
                    close_command = function(bufnum)
                        require('bufdelete').bufdelete(bufnum, true)
                    end,
                },
            }
        end
    }

    use 'folke/twilight.nvim'
    use {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require 'colorizer'.setup {}
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.3',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function()
            require('telescope').setup {
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    }
                }
            }

            -- require('telescope').load_extension('fzf')
        end
    }

    use {
        'MunifTanjim/prettier.nvim',
        config = function()
            local prettier = require("prettier")

            prettier.setup({
                bin = 'prettierd', -- or `'prettier'`
                filetypes = {
                    "css",
                    "graphql",
                    "html",
                    "javascript",
                    "javascriptreact",
                    "json",
                    "less",
                    "markdown",
                    "scss",
                    "svelte",
                    "typescript",
                    "typescriptreact",
                    "yaml",
                },
            })
        end
    }

    use {
        'ray-x/go.nvim',
        config = function()
            require('go').setup()

            local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                    require('go.format').goimport()
                end,
                group = format_sync_grp,
            })
        end
    }

    use 'sbdchd/neoformat'

    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            local null_ls = require("null-ls")

            local sources = { null_ls.builtins.formatting.prettier }

            null_ls.setup({
                sources,
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ async = false })
                            end,
                        })
                    end
                end,
            })
        end
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require("indent_blankline").setup {
                char = "",
                char_highlight_list = {
                    "IndentBlanklineIndent1",
                    "IndentBlanklineIndent2",
                },
                space_char_highlight_list = {
                    "IndentBlanklineIndent1",
                    "IndentBlanklineIndent2",
                },
                show_trailing_blankline_indent = false,
            }
        end
    }

    use 'evanleck/vim-svelte'
    use {
        'NeogitOrg/neogit',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require'neogit'.setup {}
        end
    }

    use {
        "utilyre/barbecue.nvim",
        tag = "v1.2.0",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        after = "nvim-web-devicons", -- keep this if you're using NvChad
        config = function()
            require("barbecue").setup {
                theme = 'tokyonight',
            }
        end,
    }

    use {
        "folke/trouble.nvim",
        requires = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require"trouble".setup {
                mode = "document_diagnostics",
            }
        end
    }

    use {
        "lewis6991/hover.nvim",
        config = function()
            require("hover").setup {
                init = function()
                    -- Require providers
                    require("hover.providers.lsp")
                    -- require('hover.providers.gh')
                    -- require('hover.providers.gh_user')
                    -- require('hover.providers.jira')
                    -- require('hover.providers.man')
                    -- require('hover.providers.dictionary')
                end,
                preview_opts = {
                    border = nil
                },
                -- Whether the contents of a currently open hover window should be moved
                -- to a :h preview-window when pressing the hover keymap.
                preview_window = false,
                title = true
            }

            -- Setup keymaps
            vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
            vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
        end
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
end)
