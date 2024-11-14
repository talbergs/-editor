{ pkgs, config, ... }:

let

  colors = {
    macchiato = "#ed8796";
    rosewater = "#eb7a73";
    flamingo = "#eb7a73";
    red = "#eb7a73";
    maroon = "#eb7a73";
    pink = "#e396a4";
    mauve = "#e396a4";
    peach = "#e89a5e";
    yellow = "#e8b267";
    green = "#b9c675";
    teal = "#99c792";
    sky = "#99c792";
    sapphire = "#99c792";
    blue = "#8dbba3";
    lavender = "#8dbba3";
    text = "#f1e4c2";
    subtext2 = "#e5d5b1";
    subtext1 = "#e5d5b1";
    subtext0 = "#c5bda3";
    overlay2 = "#b8a994";
    overlay1 = "#a39284";
    overlay0 = "#656565";
    surface2 = "#5d5d5d";
    surface1 = "#505050";
    surface0 = "#393939";
    base = "#2e3233";
    mantle = "#242727";
    crust = "#1f2223";
  };

in
{
  config.extraConfigLua = ''
    vim.cmd[[hi WinBar guibg=#AAEEDD gui=bold,underline]]
    vim.cmd[[hi TabLineSel gui=italic,bold guifg=#907aa9]]
  '';
  # config.highlight = {
  # ExtraWhitespace2.fg = colors.macchiato;
  # WinBar.fg = "#AAEEDD";
  # WinBar.bg = "#AAEEDD";
  # WinBar.ctermbg = "#AAEEDD";
  # WinBar.link = "DiffDelete";
  # };
  config.colorscheme = "habamax";
  # config.colorscheme = "default";
  # config.colorscheme = "peachpuff";
  config.match = {
    ExtraWhitespace = "\\s\\+$";
  };
}
