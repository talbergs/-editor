return {
	set_user_options = function()
		-- Check the progress.
		-- https://github.com/nanotee/nvim-lua-guide
		-- vim.o.shortmess = "IWcFqT"
    --
		vim.o.showcmd = false
		vim.o.updatetime = 100     -- 100ms

		vim.wo.wrap = false
		vim.o.wrap = false
		vim.opt.wrap = false
		vim.wo.number = true
		vim.wo.relativenumber = false
		vim.wo.signcolumn = 'yes:2'
		vim.wo.colorcolumn = '120'
		vim.wo.foldmethod = 'indent'
		vim.wo.foldlevel = 99

		-- Check the progress.
		-- https://github.com/neovim/neovim/pull/13479
		local o = function(k, v)
			vim.bo[k] = v
			vim.o[k] = v
		end

		o('swapfile', false)
		o('expandtab', true)
		o('tabstop', 4)
		o('shiftwidth', 0)     -- Shiftwidth is equal to tabstop when it is zero.

		-- " j	Where it makes sense, remove a comment leader when joining lines.  For
		-- " 	example, joining:
		-- " 		int i;   // the index ~
		-- " 		         // in the list ~
		-- " 	Becomes:
		-- " 		int i;   // the index in the list ~
		-- "  Where it makes sense, remove a comment leader when joining lines. For example, joining.

		-- " q	Allow formatting of comments with "gq".
		-- " 	Note that formatting will not change blank lines or lines containing
		-- " 	only the comment leader.  A new paragraph starts after such a line,
		-- " 	or when the comment leader changes.
		-- setl formatoptions+=q

		-- " r	Automatically insert the current comment leader after hitting
		-- " 	<Enter> in Insert mode.
		-- " 	NOTE: use "o" to begin a new line without

		-- " -- hazard option, should be disabled by default.
		-- "
		-- " o	Automatically insert the current comment leader after hitting 'o' or
		-- " 	'O' in Normal mode.
		-- " setl formatoptions+=o
		o('formatoptions', 'jqr')     -- Shiftwidth is equal to tabstop when it is zero.


        vim.opt.tabstop = 4
        vim.opt.softtabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.expandtab = true
        vim.opt.smartindent = true
        vim.opt.smarttab = true
        vim.opt.wrap = false
        vim.opt.cmdheight = 0
        vim.opt.number = true
        vim.opt.title = true
        vim.opt.undofile = true
        vim.opt.swapfile = false
        vim.opt.signcolumn = 'yes:2'

        local fonts = {
          JETBRAINS = { 'JetBrains Mono', 10 },
          IOSEVKA = { 'Iosevka Nerd Font Mono', 12 },
          UBUNTU = { 'UbuntuMono Nerd Font Mono', 13 },
        }

        local current_font = fonts.JETBRAINS
        -- vim.opt.linespace = 6

        -- configure neovide
        if vim.g.neovide then
          vim.o.guifont = current_font[1]
            .. ':h'
            .. current_font[2]
            .. ':#e-subpixelantialias'

          vim.g.neovide_cursor_animation_length = 0.05
          vim.g.neovide_cursor_trail_size = 0.1

          local pad = 10
          -- padding between lines
          vim.g.neovide_padding_top = pad
          vim.g.neovide_padding_bottom = pad
          vim.g.neovide_padding_right = pad
          vim.g.neovide_padding_left = pad
        end
	end,
	set_user_commands = function()
		vim.api.nvim_create_user_command('Cq', 'cq', {})
	end,
}
