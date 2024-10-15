{ pkgs, config, ... }:
let
  jsphp = ((pkgs.fetchFromGitLab {
    owner = "joncoole";
    repo = "tree-sitter-nginx";
    rev = "b4b61db443602b69410ab469c122c01b1e685aa0";
    hash = "sha256-Sa7audtwH8EgrHJ5XIUKTdveZU2pDPoUq70InQ6qcKA=";
  }).overrideAttrs (drv: {
    fixupPhase = ''
      mkdir -p $out/queries/nginx
      mv $out/queries/*.scm $out/queries/nginx/
    '';
  }));
in {

  config.plugins.treesitter.grammarPackages =
    pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars ++ [ jsphp ];
  config.extraConfigLua = ''
    do
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      -- change the following as needed
      parser_config.nu = {
        install_info = {
          url = "''${treesitter-nu-grammar}", -- local path or git repo
          files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
          -- optional entries:
          --  branch = "main", -- default branch in case of git repo if different from master
          -- generate_requires_npm = false, -- if stand-alone parser without npm dependencies
          -- requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
        },
        filetype = "nu", -- if filetype does not match the parser name
      }
    end
  '';
}
