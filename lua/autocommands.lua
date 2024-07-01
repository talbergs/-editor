        -- -- Don't auto comment new line
        -- vim.api.nvim_create_autocmd('BufEnter', {
        -- 	group = custom,
        -- 	command = 'set formatoptions-=cro',
        -- })
        --
        -- vim.api.nvim_create_autocmd('BufWritePost', {
        -- 	pattern = '*/**/lua/*.lua',
        -- 	command = '!stylua %',
        -- })

        -- vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "TermOpen" }, {
        --     callback = function(args)
        --         if vim.startswith(vim.api.nvim_buf_get_name(args.buf), "term://") then
        --             vim.cmd("startinsert")
        --         end
        --     end,
        -- })

        -- vim.api.nvim_create_autocmd("TermOpen", {
        --     command = [[setlocal nonumber norelativenumber winhl=Normal:NormalFloat]]
        -- })

        --TODO: this lags editor, there is bug
        ----- AUCOMANDS BEGIN
        ----
        --local timer = vim.loop.new_timer()
        --local function write_lines()
        --local current_line = vim.api.nvim_get_current_line()
        --local cursor_pos = vim.api.nvim_win_get_cursor(0)
        --local line_start = math.max(1, cursor_pos[1] - 100)
        --local line_end = math.min(vim.api.nvim_buf_line_count(0), cursor_pos[1] + 100)
        --local lines = vim.api.nvim_buf_get_lines(0, line_start - 1, line_end, false)
        --local text = table.concat(lines, "\n")
        --local file_name = vim.api.nvim_buf_get_name(0)
        --local time = os.date("!%Y-%m-%dT%H:%M:%SZ") -- ISO 8601 format
        --local json = string.format('{"text": "%s", "file_name": "%s", "time": "%s"}', text, file_name, time)
        --local file = io.open(os.getenv("HOME") .. "/.cache/ai/data", "a")
        --file:write(json .. "\n")
        --file:close()
        --end
        --vim.api.nvim_command("augroup mygroup")
        --vim.api.nvim_command("autocmd!")
        --vim.api.nvim_command("autocmd CursorMoved * call v:lua.start_timer()")
        --vim.api.nvim_command("augroup END")
        --function start_timer()
        --timer:start(5000, 0, vim.schedule_wrap(write_lines))
        --end
        --
        --- AUCOMANDS END

        -- local popup = require("plenary.popup")
        -- local Win_id

        -- function ShowMenu(opts, cb)
        --     local height = 20
        --     local width = 30
        --     local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

        --     Win_id = popup.create("", {
        --         title = "MyProjects",
        --         highlight = "MyProjectWindow",
        --         line = math.floor(((vim.o.lines - height) / 2) - 1),
        --         col = math.floor((vim.o.columns - width) / 2),
        --         minwidth = width,
        --         minheight = height,
        --         borderchars = borderchars,
        --         callback = cb,
        --     })
        --     local bufnr = vim.api.nvim_win_get_buf(Win_id)
        --     vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>lua CloseMenu()<CR>", { silent = false })
        -- end

        -- local function complete_popup()
        --     local items = {
        --         { label = 'Word complete',    value = 'w' },
        --         { label = 'Copilot complete', value = 'c' },
        --         { label = 'LSP complete',     value = 'l' },
        --     }
        --     local opts = {
        --         border = {},
        --         focusable = false,
        --         select = function(selected)
        --             if selected then
        --                 if selected == 'w' then
        --                     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, false, true), 'n', true)
        --                 elseif selected == 'c' then
        --                     -- Copilot complete
        --                 elseif selected == 'l' then
        --                     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-x><C-o>', true, false, true), 'n', true)
        --                 end
        --             end
        --         end,
        --     }
        --     popup.create(items, opts)
        -- end
