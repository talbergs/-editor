let
  mk = 2;
in
{
  options =
    { lib, ... }:
    with lib;
    {
      plugins.aa.enable = mkEnableOption "Enable aa plugin";
      plugins.aa2.enable = mkEnableOption "Enable aa plugin";
      plugins.nvim-quicker.enable = mkEnableOption "Enable plugin";
      plugins.nvim-quicker.setup = mkOption { type = with types; str; };
    };

  # implementation
  config =
    { lib, config, ... }:
    with lib;
    {

      extraConfigLua = mkIf config.plugins.aa.enable ''print("y100o")'';

    };
}
