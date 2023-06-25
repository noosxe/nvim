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
    use 'famiu/bufdelete.nvim'
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function ()
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
            require("neo-tree").setup {
                close_if_last_window = true,
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
        'j-hui/fidget.nvim',
        tag = 'legacy',
        config = function()
            require'fidget'.setup {}
        end
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require'gitsigns'.setup {}
        end
    }

    use {
        'akinsho/bufferline.nvim',
        tag = "*",
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
        tag = '0.1.2',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        config = function()
            require'lsp_lines'.setup {}
        end
    }

    use {
        'MunifTanjim/prettier.nvim',
        config = function()
            local prettier = require("prettier")

            prettier.setup({
                bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
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
                    "typescript",
                    "typescriptreact",
                    "yaml",
                },
            })
        end
    }

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
                                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                                -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
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

end)
