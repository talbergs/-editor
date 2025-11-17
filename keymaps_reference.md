# Neovim Keymaps Reference

This document provides a comprehensive list of keybindings defined in `keymaps.nix`.

### Global Settings
| Setting | Value |
| :-- | :---- |
| Leader Key | ` ` (Space) |

### LSP Buffer Keymaps
| Key | Action |
| :-- | :----- |
| `K` | `hover` |
| `gr` | `references` |
| `gH` | `clear_references` |
| `gh` | `document_highlight` |
| `gd` | `definition` |
| `gi` | `implementation` |
| `gt` | `type_definition` |
| `<leader>a` | `code_action` |
| `<leader>r` | `rename` |

### Completion (CMP) Keymaps
| Key | Action | Mode |
| :-- | :----- | :--- |
| `<c-w>` | `cmp.mapping.complete()` | |
| `<c-q>` | `cmp.mapping.close()` | |
| `<c-d>` | `cmp.mapping.scroll_docs(4)` | |
| `<c-u>` | `cmp.mapping.scroll_docs(-4)` | |
| `<c-p>` | `cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})` | `i`, `s` |
| `<c-n>` | `cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})` | `i`, `s` |

### General Keymaps
| Key | Action | Mode | Category |
| :-- | :----- | :--- | :------- |
| `<leader>du` | `:lua require('dapui').toggle()<cr>` | `n` | DAP |
| `<leader>dws` | `:lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes)<cr>` | `n` | DAP |
| `<leader>dwf` | `:lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames)<cr>` | `n` | DAP |
| `<leader>dH` | `:lua require'dap.ui.widgets'.preview()<cr>` | `n` | DAP |
| `<leader>dh` | `:lua require'dap.ui.widgets'.hover()<cr>` | `n` | DAP |
| `<leader>do` | `:lua require'dap'.step_out()<cr>` | `n` | DAP |
| `<leader>di` | `:lua require'dap'.step_into()<cr>` | `n` | DAP |
| `<leader>dd` | `:lua require'dap'.step_over()<cr>` | `n` | DAP |
| `<leader>dc` | `:lua require'dap'.continue()<cr>` | `n` | DAP |
| `<leader>dB` | `:lua require'dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>` | `n` | DAP |
| `<leader>db` | `:lua require'dap'.toggle_breakpoint()<cr>` | `n` | DAP |
| `<leader>hp` | `:Gitsigns preview_hunk<cr>` | `n` | Gitsigns |
| `<leader>hr` | `:Gitsigns reset_hunk<cr>` | `n` | Gitsigns |
| `<leader>w` | `:write<cr>` | `n` | File |
| `<leader>n` | `:Oil<cr>` | `n` | File Navigation |
| `<leader>b` | `:Telescope buffers<cr>` | `n` | Telescope |
| `<leader>F` | `:lua require'telescope.builtin'.grep_string()<cr>` | `n` | Telescope |
| `<leader>g` | `:Telescope live_grep<cr>` | `n` | Telescope |
| `<leader>f` | `:Telescope find_files<cr>` | `n` | Telescope |
| `<leader>l` | `:Telescope current_buffer_fuzzy_find<cr>` | `n` | Telescope |
| `t` | `:Telescope lsp_document_symbols<cr>` | `n` | Telescope |
| `<leader>t` | `:Telescope lsp_document_symbols<cr>` | `n` | Telescope |
| `[c` | `:Gitsigns prev_hunk<cr>` | `n` | Gitsigns |
| `]c` | `:Gitsigns next_hunk<cr>` | `n` | Gitsigns |
| `[d` | `:lua vim.diagnostic.goto_prev()<cr>` | `n` | Diagnostics |
| `]d` | `:lua vim.diagnostic.goto_next()<cr>` | `n` | Diagnostics |
| `<c-k>` | `10k` | `n`, `v` | Navigation |
| `<c-j>` | `10j` | `n`, `v` | Navigation |
| `<c-l>` | `10zl` | `n` | Navigation |
| `<c-h>` | `10zh` | `n` | Navigation |
| `Q` | `:nohl<cr>` | `n` | Search |
| `<cr>` | `@@` | `n` | Macro |
| `<f1>` | `:set spell!<cr>` | `n` | Toggle |
| `<f2>` | `:set list!<cr>` | `n` | Toggle |
| `<f3>` | `:TSContextToggle<cr>` | `n` | Treesitter |
| `<c-y>` | `2<c-y>` | `n` | Scroll |
| `<c-e>` | `2<c-e>` | `n` | Scroll |
| `<a-=>` | `:cnext<cr>` | `n` | Quickfix |
| `<a-->` | `:cprev<cr>` | `n` | Quickfix |
| `<a->>` | `:tabmove +1<cr>` | `n` | Tabs |
| `<a-<>` | `:tabmove -1<cr>` | `n` | Tabs |
| `<a-k>` | `:tabnext<cr>` | `n` | Tabs |
| `<a-j>` | `:tabprev<cr>` | `n` | Tabs |
| `<c-right>` | `:vertical resize +5<cr>` | `n` | Window Resize |
| `<c-left>` | `:vertical resize -5<cr>` | `n` | Window Resize |
| `<c-up>` | `:resize +5<cr>` | `n` | Window Resize |
| `<c-down>` | `:resize -5<cr>` | `n` | Window Resize |
| `<c-l>` | `<c-g>u<esc>[s1z=\`a<c-g>u` | `i` | Insert Mode |
| `<M-\`>` | `<C-\
><C-n>` | `t` | Terminal Mode |
