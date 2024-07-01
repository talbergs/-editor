{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      perSystem = { pkgs, system, ... }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit pkgs;
            # module = import ./config; # import the module directly
            module = {
              options = { };
              imports = [
                ./keymaps.nix
                ./plugins.nix
                ./colours.nix
                ./options.nix
                ./autocmd.nix
                ./mostuff.nix
              ];
              config = { };
              # config = import ./conf.nixvim.nix;
            }; # import the module directly
            # You can use `extraSpecialArgs` to pass additional arguments to your module files
            extraSpecialArgs = {
              # inherit (inputs) foo;
            };
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in {
          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            default =
              nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          packages = {
            # Lets you run `nix run .` to start nixvim
            default = nvim;
            termWrapper = pkgs.makeShellScriptBin "nvim-terminal-emulator" ''
              ${pkgs.lib.getExe nvim} +
            '';
          };
        };
    };
}
