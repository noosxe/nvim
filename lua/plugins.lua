return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        tag = "v1.5.1"
    }, {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("tokyonight").setup {
                style = "night",
                on_highlights = function(hl, c)
                    hl.TabLineSel = {bg = c.magenta2, fg = c.magenta2}
                end
            }

            vim.cmd [[colorscheme tokyonight]]
        end,
        tag = "v2.4.0"
    }, {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim"
        }
    }, {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                -- Add a language of your choice
                ensure_installed = {
                    "arduino", "bash", "c", "cpp", "css", "dart", "diff",
                    "dockerfile", "git_config", "git_rebase", "gitattributes",
                    "gitcommit", "gitignore", "glsl", "go", "gomod", "gosum",
                    "hlsl", "html", "http", "java", "javascript", "jq", "jsdoc",
                    "json", "json5", "lua", "make", "odin", "promql", "proto",
                    "python", "regex", "rust", "scss", "sql", "starlark",
                    "svelte", "toml", "tsx", "typescript", "vim", "vue", "yaml",
                    "zig"
                },
                sync_install = false,
                ignore_install = {""}, -- List of parsers to ignore installing
                highlight = {
                    enable = true, -- false will disable the whole extension
                    disable = {""}, -- list of language that will be disabled
                    additional_vim_regex_highlighting = true
                },
                indent = {enable = true, disable = {"yaml"}},
                rainbow = {
                    enable = true,
                    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                    max_file_lines = nil -- Do not enable for files with more than n lines, int
                    -- colors = {}, -- table of hex strings
                    -- termcolors = {} -- table of colour name strings
                }
            }
        end,
        tag = "v0.9.1"
    }, {"folke/zen-mode.nvim", opts = {}},
    {"folke/twilight.nvim", opts = {}, tag = "v1.0.0"}, {
        "nvim-telescope/telescope.nvim",
        dependencies = {"nvim-lua/plenary.nvim"},
        tag = '0.1.3',
        lazy = true
    }, {"famiu/bufdelete.nvim"}, {
        "akinsho/bufferline.nvim",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup {
                options = {
                    show_buffer_icons = false,
                    show_buffer_close_icons = false,
                    separator_style = {"", ""},
                    indicator = {style = "underline"},
                    diagnostics = 'nvim_lsp',
                    diagnostics_indicator = function(count)
                        return "(" .. count .. ")"
                    end,
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "File Explorer",
                            text_align = "left",
                            separator = false
                        }
                    },
                    close_command = function(bufnum)
                        require('bufdelete').bufdelete(bufnum, true)
                    end,
                    middle_mouse_command = function(bufnum)
                        require('bufdelete').bufdelete(bufnum, true)
                    end,
                    right_mouse_command = function(bufnum)
                        require('bufdelete').bufdelete(bufnum, true)
                    end
                }
            }
        end,
        tag = "v4.4.0"
    }, {
        "nvim-lualine/lualine.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            require("lualine").setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = {left = '', right = ''},
                    section_separators = {left = '', right = ''},
                    disabled_filetypes = {statusline = {}, winbar = {}},
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {statusline = 1000, tabline = 1000, winbar = 1000}
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
                extensions = {'neo-tree', 'trouble'}
            }
        end
    }, {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim", -- optional
            "ibhagwan/fzf-lua" -- optional
        },
        config = true
    }, {
        "norcalli/nvim-colorizer.lua",
        config = function() require("colorizer").setup() end
    }, {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP Support
            {"neovim/nvim-lspconfig"}, -- Required
            {'williamboman/mason.nvim', tag = "v1.8.0"}, -- Optional
            {'williamboman/mason-lspconfig.nvim', tag = "v1.17.1"}, -- Optional
            {'jose-elias-alvarez/null-ls.nvim'},
            {
                'jay-babu/mason-null-ls.nvim',
                event = {"BufReadPre", "BufNewFile"}
            }, -- Autocompletion
            {'hrsh7th/nvim-cmp'}, -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'hrsh7th/cmp-buffer'}, -- Optional
            {'hrsh7th/cmp-path'}, -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'}, -- Optional
            -- Snippets
            {'L3MON4D3/LuaSnip'} -- Required
        },
        config = function()
            local lsp_zero = require('lsp-zero')

            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({buffer = bufnr})
            end)

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'bashls', 'cssls', 'cssmodules_ls', 'dockerls',
                    'docker_compose_language_service', 'eslint', 'gopls',
                    'html', 'jsonls', 'lua_ls', 'marksman', 'rust_analyzer',
                    'svelte', 'tsserver', 'taplo', 'yamlls'
                },
                automatic_installation = true,
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        -- (Optional) configure lua language server
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end
                }
            })
            require("mason-null-ls").setup({
                ensure_installed = {"prettierd"},
                automatic_installation = false,
                handlers = {}
            })
            require("null-ls").setup({
                sources = {
                    -- Anything not supported by mason.
                }
            })

            local cmp = require('cmp')

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<return>'] = cmp.mapping.confirm({select = true})
                })
            })
        end
    }, {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua", "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter"
        },
        config = function() require("go").setup() end,
        event = {"CmdlineEnter"},
        ft = {"go", 'gomod'},
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    }, {
        "smoka7/hop.nvim",
        version = "*",
        opts = {},
        config = function()
            require("hop").setup {
                keys = "etovxqpdygfblzhckisuran",
                term_seq_bias = 0.5
            }

            -- Changing the default f keyword
            vim.api.nvim_set_keymap('', 'f',
                                    "<cmd>lua require'hop'.hint_char1()<cr>", {})

            -- Pattern Matching with t keyword
            vim.api.nvim_set_keymap('n', 't', "<cmd>HopPattern<CR>",
                                    {noremap = true})
        end
    }, {
        "petertriho/nvim-scrollbar",
        config = function() require("scrollbar").setup() end
    }, {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup {}
            require("scrollbar.handlers.gitsigns").setup {}
        end
    }, {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        config = function() require("ibl").setup() end
    }, {
        "utilyre/barbecue.nvim",
        tag = "v1.2.0",
        dependencies = {"SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons"},
        config = function()
            require("barbecue").setup {theme = 'tokyonight'}
        end
    }
}
