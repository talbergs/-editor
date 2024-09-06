{
  pkgs,
  config,
  helpers,
  ...
}:
{
  # plugins.my = pkgs.lib.mkEnableOption;

  # quicker = pkgs.vimUtils.buildVimPlugin {
  #   name = "nvim-quicker";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "stevearc";
  #     repo = "quicker.nvim";
  #     rev = "308088ebcec33f9ed551714e52390206b8f62ed6";
  #     hash = "sha256-l2M4uVuQ+NW/Nf6fwGlBUqKiWzTld/tePMPMqk3W/oM=";
  #   };
  # };
  # quicker_lua = ''
  #   require("quicker").setup()
  # '';

}
