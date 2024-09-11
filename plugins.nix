## https://github.com/desdic/macrothis.nvim
## https://github.com/ofirgall/open.nvim
## https://github.com/rebelot/heirline.nvim
# https://en.wikipedia.org/wiki/Ada_(programming_language)
# https://github.com/jmbuhr/otter.nvim
{
  pkgs,
  lib,
  config,
  helpers,
  ...
}:
with lib;
let
  user_lua = ''
    vim.cmd[[
    function! SourceFileIfExists(filepath) abort
        try
            execute "source " . a:filepath
        catch
        endtry
    endfunction

    call SourceFileIfExists(".vim/vimrc.local")
    ]]
  '';
in
{
  config.extraConfigLua = concatLines [
    user_lua
  ];
  config.plugins = {
    phpactor.enable = true;
    phpactor.setup = ''
      require("phpactor").setup({
        install = {
          path = vim.fn.stdpath("data") .. "/opt/",
          branch = "master",
          bin = "${lib.getExe pkgs.phpactor}",
          php_bin = "${lib.getExe pkgs.php}",
          composer_bin = "${lib.getExe pkgs.php83Packages.composer}",
          git_bin = "${lib.getExe pkgs.git}",
          check_on_startup = "none",
        },
        lspconfig = {
          enabled = true,
          options = {},
        },
      })
    '';
    undotree = {
      enable = true;
      settings = {
        CursorLine = true;
        DiffAutoOpen = true;
        DiffCommand = "diff";
        DiffpanelHeight = 10;
        HelpLine = true;
        HighlightChangedText = true;
        HighlightChangedWithSign = true;
        HighlightSyntaxAdd = "DiffAdd";
        HighlightSyntaxChange = "DiffChange";
        HighlightSyntaxDel = "DiffDelete";
        RelativeTimestamp = true;
        SetFocusWhenToggle = true;
        ShortIndicators = false;
        SplitWidth = 40;
        TreeNodeShape = "*";
        TreeReturnShape = "\\";
        TreeSplitShape = "/";
        TreeVertShape = "|";
        WindowLayout = 4;
      };
    };
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        # completion.autocomplete = [ "some smart" "lua code" ];
        # completion.autocomplete = false;
        sources = [
          { name = "nvim_lsp"; }
          { name = "buffer"; }
          # { name = "copilot"; }
          { name = "async_path"; }
          # { name = "fish"; }
          # { name = "spell"; }
          # { name = "cmdline"; }
          # { name = "cmp-cmdline-history"; }
          # { name = "nerdfont"; }
          # { name = "emoji"; }
        ];
        # mapping = config.plugins.cmp.settings.mapping;
      };
    };

    lsp = {
      enable = true;
      servers.bashls.enable = true;
      servers.intelephense.enable = true;
      servers.intelephense.extraOptions = {
        # :help vim.lsp.start_client
        init_options.licenceKey = "008RLZPEP6YHQ1P";
        handlers = { };
      };
      servers.zls.enable = true;
      servers.tsserver.enable = true;
      servers.terraformls.enable = true;
      servers.cssls.enable = true;
      servers.dockerls.enable = true;
      servers.html.enable = true;
      servers.jsonls.enable = true;
      # servers.phpactor.enable = true;
      # servers.phpactor.extraOptions.init_options = helpers.mkRaw ''
      #   {
      #           -- Phpactor configuration maps 1:1 to lsp init_options
      #           -- https://phpactor.readthedocs.io/en/master/reference/configuration.html#ref-configuration
      #           -- ["language_server_psalm.enabled"] = true,
      #           ["language_server_phpstan.enabled"] = true,
      #           ["language_server_phpstan.level"] = 9,
      #           ["language_server_phpstan.bin"] = "${pkgs.php83Packages.phpstan}/bin/phpstan",
      #         }
      # '';
      servers.nixd.enable = true;
      servers.nil-ls.enable = true;
      servers.pyright.enable = true;
    };
    navic.enable = true;
    wtf.enable = true;
    sidebar.enable = true;
    sidebar.setup = ''
      local sidebar = require("sidebar-nvim")
      local opts = {open = true}
      sidebar.setup(opts)'';
    fidget.enable = true;
    navbuddy.enable = true;
    treesitter-context.enable = true;
    treesitter-context.settings = {
      enable = false;
    };
    commentary.enable = true;
    committia.enable = true;
    nvim-colorizer.enable = true;
    conform-nvim.enable = true;
    conform-nvim.settings.format_on_save = null;
    conform-nvim.settings.notify_on_error = true;
    conform-nvim.settings.formatters_by_ft = {
      html = [
        [
          "prettierd"
          "prettier"
        ]
      ];
      css = [
        [
          "prettierd"
          "prettier"
        ]
      ];
      javascript = [
        [
          "prettierd"
          "prettier"
        ]
      ];
      javascriptreact = [
        [
          "prettierd"
          "prettier"
        ]
      ];
      typescript = [
        [
          "prettierd"
          "prettier"
        ]
      ];
      typescriptreact = [
        [
          "prettierd"
          "prettier"
        ]
      ];
      java = [ "google-java-format" ];
      python = [ "black" ];
      lua = [ "stylua" ];
      nix = [ "nixfmt" ];
      markdown = [
        [
          "prettierd"
          "prettier"
        ]
      ];
      rust = [ "rustfmt" ];
    };
    quicker.enable = true;
    quicker.setup = ''require("quicker").setup()'';
    treesitter.enable = true;
    treesitter.nixvimInjections = true;
    fugitive.enable = true;
    macros_librarian.enable = true;
    macros_librarian.setup = ''require("nvim-macros").setup()'';
    lualine = {
      enable = true;

      settings = rec {
        options = {
          globalstatus = true;
          component_separators.left = "";
          component_separators.right = "";
          section_separators.left = "";
          section_separators.right = "";
          always_divide_middle = false;
          icons_enabled = false;
          ignore_focus = [ "txt" ];
        };

        extensions = [
          "oil"
          "man"
        ];

        inactive_winbar.__raw = winbar.__raw;
        winbar.__raw = ''
          {
            lualine_a = {
              {
                "filename",
                path = 2,
                symbols = {},
                color = function(section)
                  return { fg = vim.bo.modified and '#aa3355' or '#33aa88' }
                end,
                on_click = function (nr, btn, mod)
                -- 11c open in new tab
                -- 21  copy full path to +"
                end
              }
            },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
          }
        '';
        sections.__raw = ''
          {
            lualine_a = { "branch" },
            lualine_b = {
              {
                "filename",
                file_status = true,
                newfile_status = true,
                path = 4, -- Filename and parent dir, with tilde as the home directory
                symbols = {
                  modified = '[+]',
                  readonly = '[-]',
                  unnamed = '[No Name]',
                  newfile = '[New]',
                }
              },

            },
            lualine_c = {},
            lualine_x = {},
            lualine_y = { { "encoding", show_bomb = true, }, { "filetype", icon_only = true } },
            lualine_z = { "progress", "location" },
          }
        '';
      };
    };
    telescope.enable = true;
    oil.enable = true;
    gitsigns.enable = true;
    tabby.enable = true;
    tabby.setup = ''
      local theme = {
        fill = 'TabLineFill',
        -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
        head = 'TabLine',
        current_tab = 'TabLineSel',
        tab = 'TabLine',
        win = 'TabLine',
        tail = 'TabLine',
      }
      local line = function(line)
        return {
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            return {
              line.sep('|', hl, theme.fill),
              tab.is_current() and '▶' or '▷',
              tab.name(),
              line.sep(' ', hl, theme.fill),
              hl = hl,
              margin = ' ',
            }
          end),
          line.spacer(),
          hl = theme.fill,
        }
      end
      require('tabby').setup({ line = line })
    '';
  };
}
