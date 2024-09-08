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
            "quicker"
            "macros_librarian"
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

    in
    {

      extraConfigLua = concatLines [
        quicker_lua
        macros_librarian_lua
      ];
      extraPlugins = [
        quicker
        macros_librarian
      ];

    };
}
