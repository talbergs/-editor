{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { pkgs, system, ... }@sys:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule =
            let
              # Implements and declares custom plugins on nixvim api.
              # Provides nixvim module with:
              #   plugins.<name>.enable *bool
              #   plugins.<name>.setup *str "Lua string"
              # <name> - ussually smth fetchFromGitHub
              _plugins = import ./_plugins_module_attrs.nix sys;
            in
            {
              inherit pkgs;
              module =
                with pkgs.lib;
                { config, ... }@top:
                {

                  options = _plugins.options top;
                  config = _plugins.config top;

                  imports = [
                    ./keymaps.nix
                    ./plugins.nix
                    ./colours.nix
                    ./options.nix
                    ./autocmd.nix
                    ./mostuff.nix
                  ];
                };
              # You can use `extraSpecialArgs` to pass additional arguments to your module files.
              extraSpecialArgs = {
                # inherit (inputs) foo;
              };
            };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          checks = {
            # Run `nix flake check .` to verify that your config is not broken.
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          packages = {
            # Lets you run `nix run .` to start nixvim
            default = nvim;
            termWrapper = pkgs.writeShellScriptBin "nvim-terminal-emulator" ''
              ${pkgs.lib.getExe nvim} +term +startinsert $@
            '';
          };
        };
    };
}
