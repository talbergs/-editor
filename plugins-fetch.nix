{ pkgs, config, ... }:
let
  cfg = config.plugins.nvim-quicker2;
in
with pkgs.lib;
{

  options = {
    plugins.nvim-quicker2.enable = mkEnableOption "Enable plugin 2";
    plugins.nvim-quicker2.setup = mkOption { type = with types; str; };
  };

  config = {
    extraConfigLua = cfg.setup;
    extraPlugins = [
      # (pkgs.vimUtils.buildVimPlugin {
      #   name = "nvim-quicker";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "stevearc";
      #     repo = "quicker.nvim";
      #     rev = "308088ebcec33f9ed551714e52390206b8f62ed6";
      #     hash = "sha256-l2M4uVuQ+NW/Nf6fwGlBUqKiWzTld/tePMPMqk3W/oM=";
      #   };
      # })
    ];
    #config contents
  };
}
