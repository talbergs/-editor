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
  config = {
    # extraConfigLua = mkIf config.plugins.aa.enable ''print("y99o")'';
  };
}
