{ pkgs, config, ... }:
{
  config.globals.mapleader = " ";
  config.plugins.lsp.keymaps = pkgs.lib.mkIf config.plugins.lsp.enable {
    lspBuf = {
      K = "hover";
      gr = "references";
      gH = "clear_references";
      gh = "document_highlight";
      gd = "definition";
      gi = "implementation";
      gt = "type_definition";
      "<leader>a" = "code_action";
      "<leader>r" = "rename";
    };
  };

  config.plugins.cmp.settings.mapping = pkgs.lib.mkIf config.plugins.cmp.enable {
    # Explicitly triggers All sources complete menu.
    # When menu visible, accepts first suggestion.
    "<c-w>" = "cmp.mapping.complete()";
    "<c-q>" = "cmp.mapping.close()";
    "<c-d>" = "cmp.mapping.scroll_docs(4)";
    "<c-u>" = "cmp.mapping.scroll_docs(-4)";
    "<c-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
    "<c-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
    # TODO: make completion sources a runtime config
    # TODO: explicit completion sources keyseq and source pumenu:
    ## ^^^: imap <c-x> "open menu with set of completion sources".
  };

  config.keymaps = [
    # DAP

    {
      key = "<leader>du";
      action = ":lua require('dapui').toggle()<cr>";
      mode = [ "n" ];
    }

    {
      key = "<leader>do";
      action = ":lua require'dap'.step_out()<cr>";
      mode = [ "n" ];
    }

    {
      key = "<leader>di";
      action = ":lua require'dap'.step_into()<cr>";
      mode = [ "n" ];
    }

    {
      key = "<leader>dd";
      action = ":lua require'dap'.step_over()<cr>";
      mode = [ "n" ];
    }

    {
      key = "<leader>dc";
      action = ":lua require'dap'.continue()<cr>";
      mode = [ "n" ];
    }

    {
      key = "<leader>dB";
      action = ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>";
      mode = [ "n" ];
    }

    {
      key = "<leader>db";
      action = ":lua require'dap'.toggle_breakpoint()<cr>";
      mode = [ "n" ];
    }

    # ---
    {
      key = "<leader>hp";
      action = ":Gitsigns preview_hunk<cr>";
      mode = [ "n" ];
    }

    {
      key = "<leader>w";
      action = ":write<cr>";
      mode = [ "n" ];
    }

    {
      key = "<leader>n";
      action = ":Oil<cr>";
      mode = [ "n" ];
    }

    {
      key = "<leader>n";
      action = ":Oil<cr>";
      mode = [ "n" ];
    }

    {
      key = "<leader>b";
      action = ":Telescope buffers<cr>";
      mode = [ "n" ];
    }

    {
      key = "<leader>F";
      action = ":lua require'telescope.builtin'.grep_string()<cr>";
      mode = [ "n" ];
    }

    {
      key = "<leader>g";
      action = ":Telescope live_grep<cr>";
      mode = [ "n" ];
    }

    {
      key = "<leader>f";
      action = ":Telescope find_files<cr>";
      mode = [ "n" ];
    }

    {
      key = "<leader>l";
      action = ":Telescope current_buffer_fuzzy_find<cr>";
      mode = [ "n" ];
    }

    {
      key = "t";
      action = ":Telescope lsp_document_symbols<cr>";
      mode = [ "n" ];
    }

    {
      key = "<leader>t";
      action = ":Telescope lsp_document_symbols<cr>";
      mode = [ "n" ];
    }

    {
      key = "[c";
      action = ":Gitsigns prev_hunk<cr>";
      mode = [ "n" ];
    }

    {
      key = "]c";
      action = ":Gitsigns next_hunk<cr>";
      mode = [ "n" ];
    }

    {
      key = "[d";
      action = ":lua vim.diagnostic.goto_prev()<cr>";
      mode = [ "n" ];
    }

    {
      key = "]d";
      action = ":lua vim.diagnostic.goto_next()<cr>";
      mode = [ "n" ];
    }

    {
      key = "<c-k>";
      action = "10k";
      mode = [
        "n"
        "v"
      ];
    }

    {
      key = "<c-j>";
      action = "10j";
      mode = [
        "n"
        "v"
      ];
    }

    {
      key = "<c-l>";
      action = "10zl";
      mode = [ "n" ];
    }

    {
      key = "<c-h>";
      action = "10zh";
      mode = [ "n" ];
    }

    {
      key = "Q";
      action = ":nohl<cr>";
      mode = [ "n" ];
    }

    {
      key = "<cr>";
      action = "@@";
      mode = [ "n" ];
    }

    {
      key = "<f1>";
      action = ":set spell!<cr>";
      mode = [ "n" ];
    }

    {
      key = "<f2>";
      action = ":set list!<cr>";
      mode = [ "n" ];
    }

    {
      key = "<f3>";
      action = ":TSContextToggle<cr>";
      mode = [ "n" ];
    }

    {
      key = "<c-y>";
      action = "2<c-y>";
      mode = [ "n" ];
    }

    {
      key = "<c-e>";
      action = "2<c-e>";
      mode = [ "n" ];
    }

    {
      key = "<a-=>";
      action = ":cnext<cr>";
      mode = [ "n" ];
    }

    {
      key = "<a-->";
      action = ":cprev<cr>";
      mode = [ "n" ];
    }

    {
      key = "<a->>";
      action = ":tabmove +1<cr>";
      mode = [ "n" ];
    }

    {
      key = "<a-<>";
      action = ":tabmove -1<cr>";
      mode = [ "n" ];
    }

    {
      key = "<a-k>";
      action = ":tabnext<cr>";
      mode = [ "n" ];
    }

    {
      key = "<a-j>";
      action = ":tabprev<cr>";
      mode = [ "n" ];
    }

    {
      key = "<c-right>";
      action = ":vertical resize +5<cr>";
      mode = [ "n" ];
    }

    {
      key = "<c-left>";
      action = ":vertical resize -5<cr>";
      mode = [ "n" ];
    }

    {
      key = "<c-up>";
      action = ":resize +5<cr>";
      mode = [ "n" ];
    }

    {
      key = "<c-down>";
      action = ":resize -5<cr>";
      mode = [ "n" ];
    }

    {
      key = "<c-down>";
      action = ":resize -5<cr>";
      mode = [ "n" ];
    }

    {
      key = "<c-l>";
      action = "<c-g>u<esc>[s1z=`]a<c-g>u";
      mode = [ "i" ];
    }

    {
      key = "<M-`>";
      action = "<C-\><C-n>";
      mode = [ "t" ];
    }
  ];
}
