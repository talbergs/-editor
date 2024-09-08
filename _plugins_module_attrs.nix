{ pkgs, lib, ... }:
with lib;
let
  mkApi = plugins_name: {
    plugins = {
      "${plugins_name}" = {
        enable = mkEnableOption "Enable ${plugins_name} plugin";
        setup = mkOption { type = with types; str; };
      };
    };
  };
in
{
  # options = { lib, ... }: with lib; (mkApi "aa");
  options =
    { lib, ... }:
    with lib;
    {
      plugins = genAttrs [ "quicker" ] (plugins_name: {
        enable = mkEnableOption "Enable ${plugins_name} plugin";
        setup = mkOption { type = with types; str; };
      });
    };

  # implementation
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
      quicker_lua2 = ''
        require("quicker").setup()
      '';
      quicker_lua = if config.plugins.quicker.enable then config.plugins.quicker.setup else "";

    in
    {

      extraConfigLua = concatLines [ quicker_lua ];
      extraPlugins = [ quicker ];

    };
}
