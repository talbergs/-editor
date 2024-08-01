{ pkgs, config, ... }:
{

  autoCmd = [
    {
      event = "FileType";
      pattern = "nix";
      callback = {
        __raw = "function() vim.cmd('FormatOnSave') end";
      };
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
    {
      event = "FileType";
      pattern = "php";
      command = "setl noexpandtab";
      # callback.__raw = ''
      #   function() vim.cmd([[
      #     setl noexpandtab
      #     setl ts=2
      #     setl sw=2
      #   ]] end
      # '';
    }
  ];

}
