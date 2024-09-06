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

}
