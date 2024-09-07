{ pkgs, config, ... }:
{
  config.luaLoader.enable = false;
  config.autoGroups.me.clear = true;

  config.userCommands.Shoutout = {
    command = ":luafile /tmp/nixvim.init.lua";
  };
  config.userCommands.Format = {
    command = ":lua require('conform').format({async=true;lsp_fallback=true})";
  };
  config.userCommands.FormatOnSave = {
    command = ":lua require('conform').setup({format_on_save={lsp_fallback=true}})";
  };
  config.userCommands.FormatOnSaveOff = {
    command = ":lua require('conform').setup({format_on_save=null})";
  };
  config.userCommands.Cq = {
    command = ":cq";
  };

  config.autoCmd = [

    {
      event = [ "TextYankPost" ];
      group = "me";
      pattern = [ "*" ];
      command = ''lua vim.highlight.on_yank({higroup="MacchiatoRed", timeout=150})'';
    }

  ];

  config.filetype = {
    filename = {
      "flake.lock" = "json";
    };
  };

  config.highlight = {
    MacchiatoRed.fg = "#ed8796";
  };
  config.match = {
    ExtraWhitespace = "\\s\\+$";
  };

  config.extraFiles = { };

  config.extraConfigLua = ''
    local disabled_built_ins = {
      '2html_plugin',
      'getscript',
      'getscriptPlugin',
      -- 'gzip',
      'logipat',
      -- 'netrw',
      -- 'netrwPlugin',
      -- 'netrwSettings',
      -- 'netrwFileHandlers',
      'matchit',
      'matchparen',
      -- 'tar',
      'tarPlugin',
      'rrhelper',
      'vimball',
      'vimballPlugin',
      -- 'zip',
      -- 'zipPlugin',
    }

    for _, plugin in pairs(disabled_built_ins) do
      vim.g['loaded_' .. plugin] = 1
    end
    -- a legacy config gradually moving over to nix
    -- require('me.remap').set_base_remap()
    -- require('me.autocommands').set()
    -- require('me.settings').set_user_commands()
    -- require('me.settings').set_user_options()
    -- require('me.styles').set()

    -- (( fast WASD wordjump ))[
    -- TODO: For this to work in memory you need a reminder by visual pre-jump-feedback
    vim.keymap.set('n', '<a-w>', function() vim.fn.search('\\<' .. vim.fn.expand('<cword>') .. '\\>', 'Wz') end)
    vim.keymap.set('n', '<a-s>', function() vim.fn.search('\\<' .. vim.fn.expand('<cword>') .. '\\>', 'bWz') end)
    -- vim.keymap.set('n', '<a-a>', function() vim.fn.search('\\<' .. vim.fn.expand('<cword>') .. '\\>', 'Wz') end)
    -- vim.keymap.set('n', '<a-d>', function() vim.fn.search('\\<' .. vim.fn.expand('<cword>') .. '\\>', 'bWz') end)
    -- vim.keymap.set("i", "<c-x>", function() ShowMenu() end)
  '';
}
