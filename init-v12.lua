vim.pack.add({
  -- LLM/AI Plugins
  "https://github.com/David-Kunz/gen.nvim",
  "https://github.com/Kurama622/llm.nvim",
  "https://github.com/gutsavgupta/nvim-gemini-companion",

  -- UI & Appearance
  "https://github.com/j-hui/fidget.nvim", -- Standalone UI for nvim-lsp progress
  "https://github.com/nanozuki/tabby.nvim", -- Tabline
  "https://github.com/norcalli/nvim-colorizer.lua", -- Color highlighter
  "https://github.com/nvim-lualine/lualine.nvim", -- Statusline
  "https://github.com/nvim-tree/nvim-web-devicons", -- Icons
  "https://github.com/folke/which-key.nvim", -- Key binding hints

  -- Core Functionality
  "https://github.com/echasnovski/mini.nvim", -- Library of minimal plugins
  "https://github.com/lewis6991/gitsigns.nvim", -- Git decorations
  "https://github.com/mbbill/undotree", -- Undo history visualizer
  "https://github.com/neovim/nvim-lspconfig", -- LSP configuration
  "https://github.com/nvim-treesitter/nvim-treesitter", -- Treesitter
  "https://github.com/nvim-treesitter/nvim-treesitter-context", -- Treesitter context
  "https://github.com/stevearc/conform.nvim", -- Formatter
  "https://github.com/stevearc/oil.nvim", -- File manager
  "https://github.com/tpope/vim-commentary", -- Commenting
  "https://github.com/tpope/vim-fugitive", -- Git wrapper

  -- Completion
  "https://github.com/hrsh7th/nvim-cmp", -- Completion engine
  "https://github.com/hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
  "https://github.com/hrsh7th/cmp-path", -- Path source for nvim-cmp

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
  "https://github.com/sslivkoff/quicker.vim",
  "https://github.com/desdic/nvim-macros",

  -- Dependencies
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
})

-- :Gemini
require("gemini").setup({
  cmds = { "gemini", "qwen" }, -- Use both
})

-- Keymaps from keymaps_reference.md

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- LSP Buffer Keymaps
-- To use these, add `on_attach = on_attach` to your lsp server setup.
-- For example:
-- require('lspconfig').pylsp.setup({
--   on_attach = on_attach,
-- })
local on_attach = function(client, bufnr)
  local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
  end

  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "LSP: Hover" })
  map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { desc = "LSP: References" })
  -- gH: clear_references - not a standard LSP function. Using nohlsearch to clear highlights.
  map("n", "gH", "<cmd>nohlsearch<cr>", { desc = "LSP: Clear References/Highlights" })
  map("n", "gh", "<cmd>lua vim.lsp.buf.document_highlight()<cr>", { desc = "LSP: Document Highlight" })
  map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "LSP: Definition" })
  map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", { desc = "LSP: Implementation" })
  map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", { desc = "LSP: Type Definition" })
  map("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "LSP: Code Action" })
  map("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "LSP: Rename" })
end

-- Completion (CMP) Keymaps
-- These mappings should be configured within the `nvim-cmp` setup.
-- For example:
-- local cmp = require'cmp'
-- cmp.setup({
--   mapping = cmp.mapping.preset.insert({
--     ['<c-w>'] = cmp.mapping.complete(),
--     ['<c-q>'] = cmp.mapping.close(),
--     ['<c-d>'] = cmp.mapping.scroll_docs(4),
--     ['<c-u>'] = cmp.mapping.scroll_docs(-4),
--     ['<c-p>'] = cmp.mapping.select_prev_item(),
--     ['<c-n>'] = cmp.mapping.select_next_item(),
--     -- Other mappings...
--   }),
--   -- Other cmp settings...
-- })

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
  vim.diagnostic.goto_prev()
end, { desc = "Diagnostics: Previous" })
map("n", "]d", function()
  vim.diagnostic.goto_next()
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
map("n", "<f3>", ":TSContextToggle<cr>", { silent = true, desc = "Toggle: Treesitter Context" })

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
