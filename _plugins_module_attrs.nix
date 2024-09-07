{ lib, ... }:
with lib;
{
  # options = {
  plugins.aa.enable = mkEnableOption "Enable aa plugin";
  plugins.nvim-quicker.enable = mkEnableOption "Enable plugin";
  plugins.nvim-quicker.setup = mkOption { type = with types; str; };
  # };
}
