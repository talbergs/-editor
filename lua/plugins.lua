return {
    list = {
        {
            "jackMort/ChatGPT.nvim",
            event = "VeryLazy",
            config = function()
                require("chatgpt").setup({
                })
            end,
            dependencies = {
                "MunifTanjim/nui.nvim",
                "nvim-lua/plenary.nvim",
                "folke/trouble.nvim",
                "nvim-telescope/telescope.nvim"
            }
        },
        {
            "SmiteshP/nvim-navic",
            requires = "neovim/nvim-lspconfig"
        },
        {
            "SmiteshP/nvim-navbuddy",
            requires = {
                "neovim/nvim-lspconfig",
                "SmiteshP/nvim-navic",
                "MunifTanjim/nui.nvim",
                "numToStr/Comment.nvim",        -- Optional
                "nvim-telescope/telescope.nvim" -- Optional
            },
        },
        {
            "https://github.com/zbirenbaum/copilot.lua",
            cmd = "Copilot",
            event = "InsertEnter",
            config = function()
                require("copilot").setup({
                    -- panel = {
                    --     enabled = true,
                    --     auto_refresh = true,
                    --     keymap = {
                    --         jump_prev = "[[",
                    --         jump_next = "]]",
                    --         accept = "<CR>",
                    --         refresh = "gr",
                    --         open = "<M-CR>"
                    --     },
                    --     layout = {
                    --         position = "bottom", -- | top | left | right
                    --         ratio = 0.4
                    --     },
                    -- },
                    -- suggestion = {
                    --     enabled = true,
                    --     auto_trigger = true,
                    --     debounce = 75,
                    --     keymap = {
                    --         accept = "<M-W>",
                    --         accept_word = false,
                    --         accept_line = true,
                    --         next = "<M-D>",
                    --         prev = "<M-U>",
                    --         dismiss = "<M-]>",
                    --     },
                    -- },
                    -- filetypes = {
                    --     help = false,
                    -- },
                    -- copilot_node_command = 'node', -- Node.js version must be > 18.x
                    -- server_opts_overrides = {},
                })
            end
        },
        { 'echasnovski/mini.nvim', version = '*',
            config = function()
                require('mini.completion').setup({})
                require('mini.statusline').setup({})
            end
        },
        {
            "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
            -- config = function()
            --     vim.diagnostic.config({
            --         underline = false,
            --         virtual_text = false,
            --         signs = false,
            --     })
            --     require("lsp_lines").setup()
            -- end,
        },
        {
            "https://github.com/neovim/nvim-lspconfig",
            config = function()
                require("lspconfig").pyright.setup({})
                require("lspconfig").terraformls.setup({})
                require("lspconfig").intelephense.setup({})
                require("lspconfig").gopls.setup({})
                require("lspconfig").lua_ls.setup({})
                -- require("nvim-navic").attach(client, bufnr)
            end,
        },
        {
            "https://github.com/nvim-treesitter/nvim-treesitter",
            config = function()
                require('nvim-treesitter.configs').setup({
                    ensure_installed = {},
                    highlight = {
                        enable = true,
                        disable = {},
                    },
                })
            end
        },
        {
            "https://github.com/nvim-neo-tree/neo-tree.nvim",
            dependencies = {
                "https://github.com/nvim-lua/plenary.nvim",
                "https://github.com/nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
                "https://github.com/MunifTanjim/nui.nvim",
            }
        },
        {
            'https://github.com/lewis6991/gitsigns.nvim',
            opts = {},
        },
        {
            'https://github.com/numToStr/Comment.nvim',
            opts = {},
        },
        {
            'https://github.com/nvim-telescope/telescope.nvim',
            dependencies = { 'nvim-lua/plenary.nvim' },
        },
        {
            "GCBallesteros/NotebookNavigator.nvim",
            keys = {
                -- { "]h", function() require("notebook-navigator").move_cell "d" end },
                -- { "[h", function() require("notebook-navigator").move_cell "u" end },
                -- { "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
                -- { "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
            },
            dependencies = {
                "echasnovski/mini.comment",
                "hkupty/iron.nvim", -- repl provider
                -- or "akinsho/toggleterm.nvim" -- repl provider
                "anuvyklack/hydra.nvim",
            },
            config = function()
                local nn = require "notebook-navigator"
                nn.setup({ activate_hydra_keys = "<leader>h" })
            end,
        },
        -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
        {
            "https://github.com/nvim-tree/nvim-web-devicons",
        },
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            config = function()
                -- print("statuslineDEBUG", pcall(require('talbergs.statusline').set, 'set'))
            end,
        },
        {
            "kylechui/nvim-surround",
            version = "*", -- Use for stability; omit to use `main` branch for the latest features
            config = function()
                require("nvim-surround").setup({
                    -- Configuration here, or leave empty to use defaults
                })
            end
        },
        {
            "https://github.com/nvim-pack/nvim-spectre",
        },
        {
            "https://github.com/tpope/vim-fugitive",
        },
        {
            "https://github.com/folke/noice.nvim",
            config = function()
                require("noice").setup({
                    cmdline = {
                        enabled = false,        -- enables the Noice cmdline UI
                        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
                        opts = {},              -- global options for the cmdline. See section on views
                        ---@type table<string, CmdlineFormat>
                        format = {
                            -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
                            -- view: (default is cmdline view)
                            -- opts: any options passed to the view
                            -- icon_hl_group: optional hl_group for the icon
                            -- title: set to anything or empty string to hide
                            cmdline = { pattern = "^:", icon = "", lang = "vim" },
                            search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                            search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                            filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                            lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "",
                                lang = "lua" },
                            help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
                            input = {}, -- Used by input()
                            -- lua = false, -- to disable a format, set to `false`
                        },
                    },
                    messages = {
                        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
                        -- This is a current Neovim limitation.
                        enabled = false,             -- enables the Noice messages UI
                        view = "notify",             -- default view for messages
                        view_error = "notify",       -- view for errors
                        view_warn = "notify",        -- view for warnings
                        view_history = "messages",   -- view for :messages
                        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
                    },
                    popupmenu = {
                        enabled = false, -- enables the Noice popupmenu UI
                        ---@type 'nui'|'cmp'
                        backend = "nui", -- backend to use to show regular cmdline completions
                        ---@type NoicePopupmenuItemKind|false
                        -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
                        kind_icons = {}, -- set to `false` to disable icons
                    },
                    -- default options for require('noice').redirect
                    -- see the section on Command Redirection
                    ---@type NoiceRouteConfig
                    redirect = {
                        view = "popup",
                        filter = { event = "msg_show" },
                    },
                    -- You can add any custom commands below that will be available with `:Noice command`
                    ---@type table<string, NoiceCommand>
                    commands = {
                        history = {
                            -- options for the message history that you get with `:Noice`
                            view = "split",
                            opts = { enter = true, format = "details" },
                            filter = {
                                any = {
                                    { event = "notify" },
                                    { error = true },
                                    { warning = true },
                                    { event = "msg_show", kind = { "" } },
                                    { event = "lsp",      kind = "message" },
                                },
                            },
                        },
                        -- :Noice last
                        last = {
                            view = "popup",
                            opts = { enter = true, format = "details" },
                            filter = {
                                any = {
                                    { event = "notify" },
                                    { error = true },
                                    { warning = true },
                                    { event = "msg_show", kind = { "" } },
                                    { event = "lsp",      kind = "message" },
                                },
                            },
                            filter_opts = { count = 1 },
                        },
                        -- :Noice errors
                        errors = {
                            -- options for the message history that you get with `:Noice`
                            view = "popup",
                            opts = { enter = true, format = "details" },
                            filter = { error = true },
                            filter_opts = { reverse = true },
                        },
                    },
                    notify = {
                        -- Noice can be used as `vim.notify` so you can route any notification like other messages
                        -- Notification messages have their level and other properties set.
                        -- event is always "notify" and kind can be any log level as a string
                        -- The default routes will forward notifications to nvim-notify
                        -- Benefit of using Noice for this is the routing and consistent history view
                        enabled = false,
                        view = "notify",
                    },
                    lsp = {
                        progress = {
                            enabled = false,
                            -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
                            -- See the section on formatting for more details on how to customize.
                            --- @type NoiceFormat|string
                            format = "lsp_progress",
                            --- @type NoiceFormat|string
                            format_done = "lsp_progress_done",
                            throttle = 1000 / 30, -- frequency to update lsp progress message
                            view = "mini",
                        },
                        override = {
                            -- override the default lsp markdown formatter with Noice
                            ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
                            -- override the lsp markdown formatter with Noice
                            ["vim.lsp.util.stylize_markdown"] = false,
                            -- override cmp documentation with Noice (needs the other options to work)
                            ["cmp.entry.get_documentation"] = false,
                        },
                        hover = {
                            enabled = false,
                            silent = false, -- set to true to not show a message if hover is not available
                            view = nil,     -- when nil, use defaults from documentation
                            ---@type NoiceViewOptions
                            opts = {},      -- merged with defaults from documentation
                        },
                        signature = {
                            enabled = false,
                            auto_open = {
                                enabled = false,
                                trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
                                luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
                                throttle = 50,  -- Debounce lsp signature help request by 50ms
                            },
                            view = nil,         -- when nil, use defaults from documentation
                            ---@type NoiceViewOptions
                            opts = {},          -- merged with defaults from documentation
                        },
                        message = {
                            -- Messages shown by lsp servers
                            enabled = false,
                            view = "notify",
                            opts = {},
                        },
                        -- defaults for hover and signature help
                        documentation = {
                            view = "hover",
                            ---@type NoiceViewOptions
                            opts = {
                                lang = "markdown",
                                replace = true,
                                render = "plain",
                                format = { "{message}" },
                                win_options = { concealcursor = "n", conceallevel = 3 },
                            },
                        },
                    },
                    markdown = {
                        hover = {
                            ["|(%S-)|"] = vim.cmd.help,                       -- vim help links
                            ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
                        },
                        highlights = {
                            ["|%S-|"] = "@text.reference",
                            ["@%S+"] = "@parameter",
                            ["^%s*(Parameters:)"] = "@text.title",
                            ["^%s*(Return:)"] = "@text.title",
                            ["^%s*(See also:)"] = "@text.title",
                            ["{%S-}"] = "@parameter",
                        },
                    },
                    health = {
                        checker = true, -- Disable if you don't want health checks to run
                    },
                    smart_move = {
                        -- noice tries to move out of the way of existing floating windows.
                        enabled = false, -- you can disable this behaviour here
                        -- add any filetypes here, that shouldn't trigger smart move.
                        excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
                    },
                    ---@type NoicePresets
                    presets = {
                        -- you can enable a preset by setting it to true, or a table that will override the preset config
                        -- you can also add custom presets that you can enable/disable with enabled=true
                        bottom_search = false,         -- use a classic bottom cmdline for search
                        command_palette = false,       -- position the cmdline and popupmenu together
                        long_message_to_split = false, -- long messages will be sent to a split
                        inc_rename = false,            -- enables an input dialog for inc-rename.nvim
                        lsp_doc_border = false,        -- add a border to hover docs and signature help
                    },
                    throttle = 1000 / 30,              -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
                    ---@type NoiceConfigViews
                    views = {}, ---@see section on views
                    ---@type NoiceRouteConfig[]
                    routes = {}, --- @see section on routes
                    ---@type table<string, NoiceFilter>
                    status = {}, --- @see section on statusline components
                    ---@type NoiceFormatOptions
                    format = {}, --- @see section on formatting
                })
            end
        },
        {
            "https://github.com/lukas-reineke/virt-column.nvim",
            config = function()
                require("virt-column").setup({
                    char = ":"
                })
            end
        },
        {
            "https://github.com/norcalli/nvim-colorizer.lua"
        }
    }
}

-- local plugs_old = {
-- 	{
-- 		"https://github.com/sindrets/diffview.nvim",
-- 	},
--
-- 	{
-- 		"https://github.com/niuiic/git-log.nvim",
-- 	},
--
-- 	{
-- 		"https://github.com/tanvirtin/vgit.nvim",
-- 		init = function ()
-- 			require('vgit').setup()
-- 		end,
-- 		requires = {
-- 			'nvim-lua/plenary.nvim',
-- 		}
-- 	},
--
-- 	{
-- 		"https://github.com/VidocqH/lsp-lens.nvim",
-- 		init = function()
-- 			require 'lsp-lens'.setup({})
-- 		end
-- 	},
--
-- 	{
-- 		"https://github.com/python-lsp/python-lsp-server",
-- 	},
--
-- 	{
-- 		"https://github.com/nvim-treesitter/nvim-treesitter-context",
-- 		init = function()
-- 			require('treesitter-context').setup({
-- 				enable = false,         -- Enable this plugin (Can be enabled/disabled later via commands)
-- 				max_lines = 0,          -- How many lines the window should span. Values <= 0 mean no limit.
-- 				min_window_height = 0,  -- Minimum editor window height to enable context. Values <= 0 mean no limit.
-- 				line_numbers = true,
-- 				multiline_threshold = 20, -- Maximum number of lines to show for a single context
-- 				trim_scope = 'outer',   -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
-- 				mode = 'cursor',        -- Line used to calculate context. Choices: 'cursor', 'topline'
-- 				-- Separator between context and content. Should be a single character string, like '-'.
-- 				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
-- 				separator = "~",
-- 				zindex = 20,   -- The Z-index of the context window
-- 				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
-- 			})
-- 		end
-- 	},
--
--
-- 	{
-- 		"norcalli/nvim-colorizer.lua",
-- 	},
--
-- 	-- LSP-ZERO block..
-- 	{
-- 		{
-- 			'VonHeikemen/lsp-zero.nvim',
-- 			branch = 'v3.x',
-- 			config = false,
-- 			init = function()
-- 				-- Disable automatic setup, we are doing it manually
-- 				vim.g.lsp_zero_extend_cmp = 0
-- 				vim.g.lsp_zero_extend_lspconfig = 0
-- 			end,
-- 		},
-- 		{
-- 			'williamboman/mason.nvim',
-- 			config = true,
-- 		},
--
-- 		-- Autocompletion
-- 		{
-- 			'hrsh7th/nvim-cmp',
-- 			event = 'InsertEnter',
-- 			dependencies = {
-- 				{ 'L3MON4D3/LuaSnip' },
-- 			},
-- 			config = function()
-- 				-- Here is where you configure the autocompletion settings.
-- 				local lsp_zero = require('lsp-zero')
-- 				lsp_zero.extend_cmp()
--
-- 				-- And you can configure cmp even more, if you want to.
-- 				local cmp = require('cmp')
-- 				local cmp_action = lsp_zero.cmp_action()
--
-- 				cmp.setup({
-- 					formatting = lsp_zero.cmp_format(),
-- 					mapping = cmp.mapping.preset.insert({
-- 						['<C-Space>'] = cmp.mapping.complete(),
-- 						['<C-u>'] = cmp.mapping.scroll_docs(-4),
-- 						['<C-d>'] = cmp.mapping.scroll_docs(4),
-- 						['<C-f>'] = cmp_action.luasnip_jump_forward(),
-- 						['<C-b>'] = cmp_action.luasnip_jump_backward(),
-- 					})
-- 				})
-- 			end
-- 		},
--
-- 		-- LSP
--
-- 		{
-- 			'neovim/nvim-lspconfig',
-- 			cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
-- 			event = { 'BufReadPre', 'BufNewFile' },
-- 			config = function()
-- 				local lsp_zero = require('lsp-zero')
-- 				lsp_zero.extend_lspconfig()
-- 				lsp_zero.on_attach(function(client, bufnr)
-- 					require('talbergs.remap').set_lsp_remap(bufnr)
-- 					if client.server_capabilities.documentSymbolProvider then
-- 					end
-- 				end)
-- 			end
-- 		}
-- 	},
--
--
--
--
--
-- 	-- https://github.com/Wansmer/treesj
-- 	{
-- 		'Wansmer/treesj',
-- 		keys = { '<space>m', '<space>j', '<space>s' },
-- 		dependencies = { 'nvim-treesitter/nvim-treesitter' },
-- 		config = function()
-- 			require('treesj').setup({ --[[ your config ]] })
-- 		end,
-- 	},
-- }
