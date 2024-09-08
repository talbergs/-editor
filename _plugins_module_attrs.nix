{ lib, ... }:
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
  options = { lib, ... }: with lib; (mkApi "aa");

  # implementation
  config =
    { lib, config, ... }:
    with lib;
    {

      extraConfigLua = mkIf config.plugins.aa.enable ''print("y101o")'';

    };
}
