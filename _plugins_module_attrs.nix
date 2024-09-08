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

      extraConfigLua = concatLines [
        (if config.plugins.aa.enable then ''print("y101o")'' else "")
        (if config.plugins.aa1.enable then ''print("y102o")'' else "")
        (if config.plugins.aa2.enable then ''print("y103o")'' else "")
      ];

    };
}
