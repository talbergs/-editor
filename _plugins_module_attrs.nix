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
  # options = { lib, ... }: with lib; (mkApi "aa");
  options =
    { lib, ... }:
    with lib;
    {
      plugins =
        genAttrs
          [
            "aa"
            "aa1"
            "aa2"
          ]
          (plugins_name: {
            enable = mkEnableOption "Enable ${plugins_name} plugin";
            setup = mkOption { type = with types; str; };
          });
    };

  # implementation
  config =
    { lib, config, ... }:
    with lib;
    {

      extraConfigLua = mkIf config.plugins.aa.enable ''print("y101o")'';
      # ++ mkIf config.plugins.aa1.enable ''print("y102o")''
      # ++ mkIf config.plugins.aa2.enable ''print("y103o")'';

    };
}
