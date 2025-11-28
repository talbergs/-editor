-- vim: foldmethod=marker
--
-- TODO: mcp chromium-web-devtools integration 
-- workflow: on Jira task press record, reproduce bug, stop recording, upload to Jira ticket
--
--
-- {{ v0.12.0 lsp setup 101 }} {{{
vim.pack.add { -- Neovim init file using built-in package management (v0.12+)
	{ src = 'https://github.com/neovim/nvim-lspconfig' }, -- still using this
	{ src = 'https://github.com/mason-org/mason.nvim' },
	{ src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
	{ src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
}

local ensure_installed = {
    "lua_ls",
    "stylua",
    "gopls",
    "intelephense",
    "phpcs",
    "phpcbf",
    "pyright",
    "html-lsp",
    "css-lsp",
    -- "tsserver",
    "rust_analyzer",
}

-- vim.lsp.config.go = {
--   default_config = {
--     cmd = { "gopls" },
--     filetypes = { "go", "gomod" },
--     root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
--     settings = {},
--   },
-- }

require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({
	ensure_installed = ensure_installed,
})

vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = {
					'vim',
					'require'
				},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})
-- }}}

vim.cmd.colorscheme("habamax")

vim.pack.add({
  -- LLM/AI Plugins
  "https://github.com/David-Kunz/gen.nvim",
  "https://github.com/Kurama622/llm.nvim",
  "https://github.com/gutsavgupta/nvim-gemini-companion",

  "https://github.com/norcalli/nvim-colorizer.lua", -- Color highlighter
  "https://github.com/nvim-lualine/lualine.nvim", -- Statusline
  "https://github.com/nvim-tree/nvim-web-devicons", -- Icons

  -- Core Functionality
  "https://github.com/echasnovski/mini.nvim", -- Library of minimal plugins
  "https://github.com/lewis6991/gitsigns.nvim", -- Git decorations
  "https://github.com/mbbill/undotree", -- Undo history visualizer
  "https://github.com/nvim-treesitter/nvim-treesitter", -- Treesitter
  "https://github.com/nvim-treesitter/nvim-treesitter-context", -- Treesitter context
  "https://github.com/stevearc/conform.nvim", -- Formatter
  "https://github.com/stevearc/oil.nvim", -- File manager
  "https://github.com/tpope/vim-commentary", -- Commenting
  "https://github.com/tpope/vim-fugitive", -- Git wrapper
  "https://github.com/ray-x/go.nvim", -- Go plugin

  -- Completion
  "https://github.com/hrsh7th/nvim-cmp", -- Completion engine
  "https://github.com/hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
  "https://github.com/hrsh7th/cmp-path", -- Path source for nvim-cmp
  "https://github.com/hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
  "https://github.com/hrsh7th/cmp-calc", -- Calculator source for nvim-cmp
  "https://github.com/L3MON4D3/LuaSnip", -- Snippet engine
  "https://github.com/saadparwaiz1/cmp_luasnip", -- Snippet source for nvim-cmp
  -- "https://github.com/zbirenbaum/copilot.lua", -- Copilot completion
  -- "https://github.com/zbirenbaum/copilot-cmp", -- Copilot source for nvim-cmp

  -- Debugging
  "https://github.com/mfussenegger/nvim-dap", -- Debug Adapter Protocol
  "https://github.com/rcarriga/nvim-dap-ui", -- UI for nvim-dap

  -- Telescope
  "https://github.com/nvim-telescope/telescope.nvim",

  -- Other
  "https://github.com/VidocqH/lsp-lens.nvim",
  "https://github.com/SmiteshP/nvim-navic",
  "https://github.com/SmiteshP/nvim-navbuddy",
  "https://github.com/piersolenski/wtf.nvim", -- Diagnostics
  "https://github.com/rhysd/committia.vim",

  -- Dependencies
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
})

require("treesitter-context").setup({
    enable = false,
    multiwindow = true,
    line_numbers = true,
})

require("nvim-treesitter.configs").setup({
    ensure_installed = {"go", "lua", "python", "rust", "typescript", "yaml", "json", "nix",
        "bash", "php", "html", "css", "javascript", "c", "cpp", "markdown",
    },
    highlight = {
        enable = true,
    },
})

vim.pack.add({
    "https://github.com/stevearc/quicker.nvim",
})
require("quicker").setup()

vim.pack.add({
  "https://github.com/folke/which-key.nvim",
})
require("which-key").setup({delay=3000})

-- {{ Global options }} {{{
vim.opt.modelineexpr = true
vim.opt.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.foldmethod = "indent"
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.showmode = false
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.scrolloff = 2
vim.opt.foldenable = false
vim.opt.listchars = "space:⋅,trail:•,tab:˖ ,nbsp:⦸,extends:»,precedes:«,eol:↵"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "0"
vim.opt.timeout = false
vim.opt.winbar = "%f"

-- Ensure undodir exists
local undodir = "/tmp/nixvim/undodir"
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir

-- Window-local options
vim.wo.wrap = false
-- }}}

-- {{ LSP document highlight autocmds }} {{{
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = {'*.js', '*.php', '*.go', '*.lua'},
  callback = function()
      -- check if lsp client is attached to buffer and it supports documentHighlight
      local clients = vim.lsp.get_clients()
      for _, client in ipairs(clients) do
          if client.server_capabilities.documentHighlightProvider then
                  if vim._HL then
                      return
                  end

                    ok, res = pcall(vim.lsp.buf.document_highlight)
                    if not ok then
                        return
                    end
                  -- add debounce
                  vim.defer_fn(function()
                      print(99)
                      vim.lsp.buf.document_highlight()
                  end, 1000)
          end
      end
  end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
  callback = function()
      if vim._HL == 1 then
          return
      end
    vim.lsp.buf.clear_references()
  end,
})

-- }}}
--
-- LspReferenceWrite extmark highlight will signify the write action
-- LspReferenceRead extmark highlight will signify the read action
-- better - make the current color more dark or light and make italic or bold
vim.cmd.highlight("LspReferenceRead guifg=#FFFFAA gui=italic")
vim.cmd.highlight("LspReferenceText guifg=#FFFFAA gui=italic")
vim.cmd.highlight("LspReferenceWrite guifg=#AAFFAA gui=bold")

-- {{ Filetype-specific settings }} {{{
vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.commentstring = "#%s"
  end,
})

-- if working on files within git who's remote URL contains "zabbix", set specific settings:
-- - set tabstop and tablshift to 4 and not expandtab
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local git_remote = vim.fn.systemlist("git config --get remote.origin.url")[1] or ""
    if string.find(git_remote, "zabbix") then
      vim.bo.expandtab = false
      vim.bo.shiftwidth = 4
      vim.bo.tabstop = 4
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "nix",
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.foldmethod = "indent"
    vim.bo.commentstring = "#%s"
  end,
})
-- }}}

-- :Gemini
require("gemini").setup({
  cmds = { "gemini", "qwen" }, -- Use both
})

require("oil").setup({})


-- Keymaps from keymaps_reference.md

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Completion (CMP) Keymaps
-- These mappings should be configured within the `nvim-cmp` setup.
-- For example:
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" }, -- For snippets
    -- { name = "copilot" }, -- Copilot source
    { name = "buffer" },
    { name = "path" },
    { name = "calc" },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
        calc = "[Calc]",
        -- copilot = "[Copilot]",
      })[entry.source.name]
      return vim_item
    end,
  },
})

-- Copilot setup
-- require("copilot").setup({
--   suggestion = {
--     auto_trigger = true,
--     keymap = {
--       accept = "<C-e>",
--       accept_word = false,
--       accept_line = false,
--       next = "<M-]>",
--       prev = "<M-[>",
--       dismiss = "<C-]>",
--     },
--   },
-- })

-- require("copilot_cmp").setup()

-- General Keymaps
local map = vim.keymap.set

-- DAP
map("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "DAP: Toggle UI" })
map("n", "<leader>dws", function()
  require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes)
end, { desc = "DAP: Widget Scopes" })
map("n", "<leader>dwf", function()
  require("dap.ui.widgets").centered_float(require("dap.ui.widgets").frames)
end, { desc = "DAP: Widget Frames" })
map("n", "<leader>dH", function()
  require("dap.ui.widgets").preview()
end, { desc = "DAP: Preview" })
map("n", "<leader>dh", function()
  require("dap.ui.widgets").hover()
end, { desc = "DAP: Hover" })
map("n", "<leader>do", function()
  require("dap").step_out()
end, { desc = "DAP: Step Out" })
map("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "DAP: Step Into" })
map("n", "<leader>dd", function()
  require("dap").step_over()
end, { desc = "DAP: Step Over" })
map("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "DAP: Continue" })
map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP: Set Breakpoint with condition" })
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "DAP: Toggle Breakpoint" })

-- map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "LSP: Hover" })
vim.keymap.del("n", "grr") -- Unmap builtin go to references mapping.
vim.keymap.del("n", "grt") -- Unmap builtin go to references mapping.
vim.keymap.del("n", "gri") -- Unmap builtin go to references mapping.
vim.keymap.del("n", "gra") -- Unmap builtin go to references mapping.
vim.keymap.del("n", "grn") -- Unmap builtin go to references mapping.

map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { desc = "LSP: References" })
map("n", "gH", "<cmd>vim.lsp.buf.clear_references()<cr>", { desc = "LSP: Clear References/Highlights" })
map("n", "gh", "<cmd>lua vim.lsp.buf.document_highlight() ; vim._HL = 1<cr>", { desc = "LSP: Document Highlight" })
-- map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "LSP: Definition" })
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", { desc = "LSP: Implementation" })
map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", { desc = "LSP: Type Definition" })
map("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "LSP: Code Action" })
map("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "LSP: Rename" })

-- Gitsigns
map("n", "<leader>hp", ":Gitsigns preview_hunk<cr>", { silent = true, desc = "Gitsigns: Preview Hunk" })
map("n", "<leader>hr", ":Gitsigns reset_hunk<cr>", { silent = true, desc = "Gitsigns: Reset Hunk" })
map("n", "[c", ":Gitsigns prev_hunk<cr>", { silent = true, desc = "Gitsigns: Previous Hunk" })
map("n", "]c", ":Gitsigns next_hunk<cr>", { silent = true, desc = "Gitsigns: Next Hunk" })

-- File
map("n", "<leader>w", ":write<cr>", { silent = true, desc = "File: Write" })
map("n", "<leader>n", ":Oil<cr>", { silent = true, desc = "File: Oil File Explorer" })

-- Telescope
map("n", "<leader>b", ":Telescope buffers<cr>", { silent = true, desc = "Telescope: Buffers" })
map("n", "<leader>F", function()
  require("telescope.builtin").grep_string()
end, { desc = "Telescope: Grep String" })
map("n", "<leader>g", ":Telescope live_grep<cr>", { silent = true, desc = "Telescope: Live Grep" })
map("n", "<leader>f", ":Telescope find_files<cr>", { silent = true, desc = "Telescope: Find Files" })
map(
  "n",
  "<leader>l",
  ":Telescope current_buffer_fuzzy_find<cr>",
  { silent = true, desc = "Telescope: Fuzzy Find in Buffer" }
)
map("n", "t", ":Telescope lsp_document_symbols<cr>", { silent = true, desc = "Telescope: Document Symbols" })
map("n", "<leader>t", ":Telescope lsp_document_symbols<cr>", { silent = true, desc = "Telescope: Document Symbols" })

-- Diagnostics
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Diagnostics: Previous" })

map("n", "]d", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Diagnostics: Next" })

-- Navigation
map({ "n", "v" }, "<c-k>", "10k", { desc = "Navigation: Up 10 lines" })
map({ "n", "v" }, "<c-j>", "10j", { desc = "Navigation: Down 10 lines" })
map("n", "<c-l>", "10zl", { desc = "Navigation: Scroll right" })
map("n", "<c-h>", "10zh", { desc = "Navigation: Scroll left" })

-- Search
map("n", "Q", ":nohl<cr>", { silent = true, desc = "Search: No Highlight" })

-- Macro
map("n", "<cr>", "@@", { desc = "Macro: Execute macro" })

-- Toggle
map("n", "<f1>", ":set spell!<cr>", { silent = true, desc = "Toggle: Spell" })
map("n", "<f2>", ":set list!<cr>", { silent = true, desc = "Toggle: List" })
map("n", "<f3>", ":TSContext toggle<cr>", { silent = true, desc = "Toggle: Treesitter Context" })

-- Scroll
map("n", "<c-y>", "2<c-y>", { desc = "Scroll: Up" })
map("n", "<c-e>", "2<c-e>", { desc = "Scroll: Down" })

-- Quickfix
map("n", "<a-=>", ":cnext<cr>", { silent = true, desc = "Quickfix: Next" })
map("n", "<a-->", ":cprev<cr>", { silent = true, desc = "Quickfix: Previous" })

-- Tabs
map("n", "<a->>", ":tabmove +1<cr>", { silent = true, desc = "Tabs: Move Right" })
map("n", "<a-<>", ":tabmove -1<cr>", { silent = true, desc = "Tabs: Move Left" })
map("n", "<a-k>", ":tabnext<cr>", { silent = true, desc = "Tabs: Next" })
map("n", "<a-j>", ":tabprev<cr>", { silent = true, desc = "Tabs: Previous" })

-- Window Resize
map("n", "<c-right>", ":vertical resize +5<cr>", { silent = true, desc = "Window: Resize Vertical +" })
map("n", "<c-left>", ":vertical resize -5<cr>", { silent = true, desc = "Window: Resize Vertical -" })
map("n", "<c-up>", ":resize +5<cr>", { silent = true, desc = "Window: Resize Horizontal +" })
map("n", "<c-down>", ":resize -5<cr>", { silent = true, desc = "Window: Resize Horizontal -" })

-- Insert Mode
map("i", "<c-l>", "<c-g>u<esc>[s1z=`a<c-g>u", { desc = "Insert: Correct spelling" })

-- Terminal Mode
map("t", "<M-`>", "<C-\\><C-n>", { desc = "Terminal: Escape to Normal" })
