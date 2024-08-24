# https://github.com/m-demare/hlargs.nvim
## https://github.com/desdic/macrothis.nvim
## https://github.com/kr40/nvim-macros
## https://github.com/ofirgall/open.nvim
## https://github.com/rebelot/heirline.nvim
# https://en.wikipedia.org/wiki/Ada_(programming_language)
# https://github.com/jmbuhr/otter.nvim
{
  pkgs,
  config,
  helpers,
  ...
}:
{
  config.extraPlugins = with pkgs.vimPlugins; [ tabby-nvim ];
  config.extraConfigLua = ''
    local theme = {
      fill = 'TabLineFill',
      -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
      head = 'TabLine',
      current_tab = 'TabLineSel',
      tab = 'TabLine',
      win = 'TabLine',
      tail = 'TabLine',
    }
    require('tabby').setup({
      line = function(line)
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
          -- line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            -- return {
              -- line.sep('|', theme.win, theme.fill),
              -- win.is_current() and '◆' or '◇',
              -- win.buf_name(),
              -- line.sep(' ', theme.win, theme.fill),
              -- hl = theme.win,
              -- margin = ' ',
            -- }
          -- end),
          -- {
            -- line.sep(' ', theme.tail, theme.fill),
            -- { '   ', hl = theme.tail },
          -- },
          hl = theme.fill,
        }
      end,
      -- option = {}, -- setup modules' option,
    })
  '';
  config.plugins = {
    # https://github.com/sidebar-nvim/sidebar.nvim
    # sidebar-nvim.enable = true;
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
      servers.phpactor.enable = true;
      servers.phpactor.extraOptions.init_options = helpers.mkRaw ''
        {
                -- Phpactor configuration maps 1:1 to lsp init_options
                -- https://phpactor.readthedocs.io/en/master/reference/configuration.html#ref-configuration
                -- ["language_server_psalm.enabled"] = true,
                ["language_server_phpstan.enabled"] = true,
                ["language_server_phpstan.level"] = 9,
                -- ["language_server_phpstan.bin"] = "${pkgs.php83Packages.phpstan}/bin/phpstan",
              }
      '';
      servers.nixd.enable = true;
      servers.nil-ls.enable = true;
      servers.pyright.enable = true;
    };
    navic.enable = true;
    # https://github.com/piersolenski/wtf.nvim
    wtf.enable = true;
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
    conform-nvim.formatOnSave = null;
    conform-nvim.notifyOnError = true;
    conform-nvim.formattersByFt = {
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
    treesitter.enable = true;
    treesitter.nixvimInjections = true;
    fugitive.enable = true;
    lualine = {
      enable = true;
      globalstatus = true;
      componentSeparators.left = "";
      componentSeparators.right = "";
      sectionSeparators.left = "";
      sectionSeparators.right = "";
      alwaysDivideMiddle = false;
      iconsEnabled = false;
      ignoreFocus = [ "txt" ];
      extensions = [
        "oil"
        "man"
      ];
      sections.lualine_a = [
        {
          name = "filename";
          extraConfig = {
            file_status = false;
            path = 2;
          };
        }
      ];
      # - `branch` (git branch)
      # - `buffers` (shows currently available buffers)
      # - `diagnostics` (diagnostics count from your preferred source)
      # - `diff` (git diff status)
      # - `encoding` (file encoding)
      # - `fileformat` (file format)
      # - `filename`
      # - `filesize`
      # - `filetype`
      # - `hostname`
      # - `location` (location in file in line:column format)
      # - `mode` (vim mode)
      # - `progress` (%progress in file)
      # - `searchcount` (number of search matches when hlsearch is active)
      # - `selectioncount` (number of selected characters or lines)
      # - `tabs` (shows currently available tabs)
      # - `windows` (shows currently available windows)
      sections.lualine_b = [ "branch" ];
      sections.lualine_c = [ "diagnostic" ];
      sections.lualine_x = [ "" ];
      sections.lualine_y = [ "" ];
      sections.lualine_z = [ "location" ];
    };
    telescope.enable = true;
    oil.enable = true;
    gitsigns.enable = true;
  };
}
