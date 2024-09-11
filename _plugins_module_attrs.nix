{ pkgs, lib, ... }:
with lib;
{
  options =
    { lib, ... }:
    with lib;
    {
      plugins =
        genAttrs
          [
            "sidebar"
            "quicker"
            "macros_librarian"
            "tabby"
            "phpactor"
          ]
          (plugins_name: {
            enable = mkEnableOption "Enable ${plugins_name} plugin";
            setup = mkOption { type = with types; str; };
          });
    };

  # Implementation:
  config =
    { lib, config, ... }:
    with lib;
    let

      # Improved styling - including syntax highlighting of grep results.
      # Show context lines - easily view lines above and below the quickfix results.
      # Editable buffer - make changes across your whole project by editing the quickfix buffer and :w.
      sidebar = pkgs.vimUtils.buildVimPlugin {
        name = "nvim-sidebar";
        src = pkgs.fetchFromGitHub {
          owner = "sidebar-nvim";
          repo = "sidebar.nvim";
          rev = "5695712eef6288fff667343c4ae77c54911bdb1b";
          hash = "sha256-TCj5TUtEgTjT0WBR8usCcWT+b+w8ac+M6KAfMxIKItw=";
        };
      };
      sidebar_lua = if config.plugins.sidebar.enable then config.plugins.sidebar.setup else "";

      # Improved styling - including syntax highlighting of grep results.
      # Show context lines - easily view lines above and below the quickfix results.
      # Editable buffer - make changes across your whole project by editing the quickfix buffer and :w.
      quicker = pkgs.vimUtils.buildVimPlugin {
        name = "nvim-quicker";
        src = pkgs.fetchFromGitHub {
          owner = "stevearc";
          repo = "quicker.nvim";
          rev = "308088ebcec33f9ed551714e52390206b8f62ed6";
          hash = "sha256-l2M4uVuQ+NW/Nf6fwGlBUqKiWzTld/tePMPMqk3W/oM=";
        };
      };
      quicker_lua = if config.plugins.quicker.enable then config.plugins.quicker.setup else "";

      # nvim-macros is your go-to Neovim plugin for supercharging your macro game!
      # 🚀 It's all about making macro management in Neovim a breeze.
      # Say goodbye to the fuss and hello to efficiency!
      # This plugin lets you save, yank, and run your macros like a pro,
      # and even handles those pesky special characters with ease.
      macros_librarian = pkgs.vimUtils.buildVimPlugin {
        name = "nvim-macros";
        src = pkgs.fetchFromGitHub {
          owner = "kr40";
          repo = "nvim-macros";
          rev = "f29d08ee7844ed6c9552699206e8c977d6936ee4";
          hash = "sha256-UDmMx4myoj0hx78C682BKMJ6RE0RQ/ilQatmMPGHtg8=";
        };
      };
      macros_librarian_lua =
        if config.plugins.macros_librarian.enable then config.plugins.macros_librarian.setup else "";

      # Makes tabs nameable.
      tabby = pkgs.vimPlugins.tabby-nvim;
      tabby_lua = if config.plugins.tabby.enable then config.plugins.tabby.setup else "";

      # Gives PHPstan analysis.
      phpactor = pkgs.vimUtils.buildVimPlugin {
        name = "phpactor";
        src = pkgs.fetchFromGitHub {
          owner = "gbprod";
          repo = "phpactor.nvim";
          rev = "db250633e7b9f0e08cc7cce364de8b7adad4f6d2";
          hash = "sha256-URA67dtZ51xZiw9YyoIuMlMgVLiDDK51BDotAOQISw0=";
        };
      };
      phpactor_lua = '''';

    in
    {

      extraConfigLua = concatLines [
        quicker_lua
        sidebar_lua
        macros_librarian_lua
        tabby_lua
        phpactor_lua
      ];
      extraPlugins = [
        quicker
        sidebar
        macros_librarian
        tabby
        phpactor
      ];

    };
}
