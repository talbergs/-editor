{ pkgs, config, ... }: {

  autoCmd = [
    {
      event = "FileType";
      pattern = "nix";
      callback = { __raw = "function() vim.cmd('FormatOnSave') end"; };
    }
    {
      event = "TermEnter";
      pattern = "*";
      command = "setlocal clipboard=unnamedplus";
    }
    {
      event = "TermEnter";
      pattern = "*";
      command = "setl nonumber";
    }
  ];

}
