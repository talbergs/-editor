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
        { pkgs, system, ... }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule =
            let
              options = import ./_plugins_module_attrs.nix;
            in
            {
              inherit pkgs;
              module =
                with pkgs.lib;
                { config, ... }@top:
                {
                  options = options top;
                  # options = {
                  #   plugins.aa.enable = mkEnableOption "Enable aa plugin";
                  #   plugins.nvim-quicker.enable = mkEnableOption "Enable plugin";
                  #   plugins.nvim-quicker.setup = mkOption { type = with types; str; };
                  # };
                  imports = [
                    ./keymaps.nix
                    ./plugins.nix
                    ./colours.nix
                    ./options.nix
                    ./autocmd.nix
                    ./mostuff.nix
                  ];

                  config = import ./conf.nixvim.nix top;

                  #config = mkIf config.plugins.nvim-quicker.enable {
                  #  extraConfigLua = config.plugins.nvim-quicker.setup;
                  #  extraPlugins = [
                  #    (pkgs.vimUtils.buildVimPlugin {
                  #      name = "nvim-quicker";
                  #      src = pkgs.fetchFromGitHub {
                  #        owner = "stevearc";
                  #        repo = "quicker.nvim";
                  #        rev = "308088ebcec33f9ed551714e52390206b8f62ed6";
                  #        hash = "sha256-l2M4uVuQ+NW/Nf6fwGlBUqKiWzTld/tePMPMqk3W/oM=";
                  #      };
                  #    })
                  #  ];
                  #  #config contents
                  #};

                }; # import the module directly
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
