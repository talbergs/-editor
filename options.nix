{ pkgs, config, ... }: {

  config.localOpts = { wrap = false; };
  config.globalOpts = { signcolumn = "3-9"; };

  config.files = {
    "ftplugin/yml.lua" = {
      opts = {
        expandtab = true;
        shiftwidth = 2;
        tabstop = 2;
        # foldmethod = "indent";
        commentstring = "#%s";
      };
    };
    "ftplugin/nix.lua" = {
      opts = {
        expandtab = true;
        shiftwidth = 2;
        tabstop = 2;
        foldmethod = "indent";
        commentstring = "#%s";
      };
    };
  };

  config.opts = {
    number = true;

    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 4;
    expandtab = true;

    smarttab = true;
    autoindent = true;
    smartindent = true;
    showmode = false;

    wrap = false;

    swapfile = false;
    backup = false;
    undodir = "/tmp/nixvim/undodir";
    undofile = true;

    scrolloff = 2;
    signcolumn = "yes";
    foldenable = false;

    listchars = "space:⋅,trail:•,tab:˖ ,nbsp:⦸,extends:»,precedes:«,eol:↵";

    updatetime = 50;
    colorcolumn = "80";
    timeout = false;
  };
}
