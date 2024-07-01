-- DOCS:
    -- vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', {
-- nvim_set_hl({ns_id}, {name}, {*val})                           *nvim_set_hl()*
--     Sets a highlight group.
--
--     Note:
--         Unlike the `:highlight` command which can update a highlight group,
--         this function completely replaces the definition. For example:
--         `nvim_set_hl(0, 'Visual', {})` will clear the highlight group
--         'Visual'.
--
--     Note:
--         The fg and bg keys also accept the string values `"fg"` or `"bg"`
--         which act as aliases to the corresponding foreground and background
--         values of the Normal group. If the Normal group has not been defined,
--         using these values results in an error.
--
--     Note:
--         If `link` is used in combination with other attributes; only the
--         `link` will take effect (see |:hi-link|).
--
--     Parameters: ~
--       • {ns_id}  Namespace id for this highlight |nvim_create_namespace()|.
--                  Use 0 to set a highlight group globally |:highlight|.
--                  Highlights from non-global namespaces are not active by
--                  default, use |nvim_set_hl_ns()| or |nvim_win_set_hl_ns()| to
--                  activate them.
--       • {name}   Highlight group name, e.g. "ErrorMsg"
--       • {val}    Highlight definition map, accepts the following keys:
--                  • fg (or foreground): color name or "#RRGGBB", see note.
--                  • bg (or background): color name or "#RRGGBB", see note.
--                  • sp (or special): color name or "#RRGGBB"
--                  • blend: integer between 0 and 100
--                  • bold: boolean
--                  • standout: boolean
--                  • underline: boolean
--                  • undercurl: boolean
--                  • underdouble: boolean
--                  • underdotted: boolean
--                  • underdashed: boolean
--                  • strikethrough: boolean
--                  • italic: boolean
--                  • reverse: boolean
--                  • nocombine: boolean
--                  • link: name of another highlight group to link to, see
--                    |:hi-link|.
--                  • default: Don't override existing definition |:hi-default|
--                  • ctermfg: Sets foreground of cterm color |ctermfg|
--                  • ctermbg: Sets background of cterm color |ctermbg|
--                  • cterm: cterm attribute map, like |highlight-args|. If not
--                    set, cterm attributes will match those from the attribute
--                    map documented above.
--
-- in lua crate new higlight groups
-- Create a group for focused ft icon:


local AT_MY_TABLINE_SHINE = "@my.tabline.shine"
local AT_MY_TABLINE_GLOW = "@my.tabline.glow"
local AT_MY_TABLINE_JUMP = "@my.tabline.jump"
local AT_MY_TABLINE_DIM = "@my.tabline.dim"

local init_hlgroups = function()
    vim.api.nvim_set_hl(0, AT_MY_TABLINE_SHINE, {
        fg = "#cdf03f",
        bg = nil,
    })

    vim.api.nvim_set_hl(0, AT_MY_TABLINE_GLOW, {
        bold = true,
        fg = "#cd853f",
        bg = nil
    })

    vim.api.nvim_set_hl(0, AT_MY_TABLINE_DIM, {
        fg = "#7f7f8c",
        bg = nil
    })

    vim.api.nvim_set_hl(0, AT_MY_TABLINE_JUMP, {
        bold = true,
        fg = "#00ff8c",
        bg = "#cd853f"
    })
end
init_hlgroups()

local git_branch = function()
    if vim.g.loaded_fugitive then
        return vim.fn.FugitiveHead()
    end
    return ''
end

local buffer_nr = function()
    return string.format(
        "[%s #%03d]",
        require("nvim-web-devicons").get_icon("vala"),
        vim.fn.bufnr()
    )
end

local visual_lines_count = function ()
    local count = require('lualine.components.selectioncount')()
    if count == "" then
        return ""
    end

    return count
    -- return string.format(
    --     "[%s %s]",
    --     require("nvim-web-devicons").get_icon(".env"),
    --     count
    -- )
end

local file_encoding = function ()
    local enc = require('lualine.components.encoding')()
    if enc == "utf-8" then
        return ""
    end

    return string.format(
        "[%s %s]",
        require("nvim-web-devicons").get_icon("rmd"),
        enc
    )
end

-- statusline=%!luaeval('require("talbergs.statusline").statusline()')

local lineno_and_columno = function ()
    local cur = vim.api.nvim_win_get_cursor(0)
    local lineno, column = cur[1], cur[2]
    local num_of_lines = vim.api.nvim_buf_line_count(0)
    local percent = math.floor(lineno / num_of_lines * 100)
    local fmt = ""

    if percent > 1 then
        fmt = string.format("%02d", percent)
    else
        fmt = "   "
    end

    return string.format(
        "[%s %s %s]",
        require("nvim-web-devicons").get_icon("prisma"),
        string.format("%03d/%03d", lineno, column),
        fmt
    )
end

local lsp_clients = function ()
    local widgets = { names = {}, is_attached = {} }
    local bufnr = vim.api.nvim_get_current_buf()
    for _, client in ipairs(vim.lsp.get_active_clients()) do
        table.insert(widgets.is_attached, client.attached_buffers[bufnr])
        table.insert(widgets.names, client.config.name or client.name)
    end

    return widgets
end

local hl_search_status = function ()
    local status = require('lualine.components.searchcount'):new({}):update_status()
    if status == "" then
        return ""
    end

    if status == "[0/0]" then
        return "No matches on " .. vim.fn.execute("echo @/")
    end

    return status
end

local spinning_char_pos = 1;
local function mk_spinning_char()
    -- spinner = ⁕ ⁖ ⁘ ⁙ ⁜ ⁛ ⁚‧⁖ ⁜ ⁂ •
    local chars = { "⁕", "⁖", "⁘", "⁙", "⁜", "⁛", "⁚", "‧", "⁖", "⁜", "⁂", "•" }
    if #chars < spinning_char_pos then
        spinning_char_pos = 1
    else
        spinning_char_pos = 1 + spinning_char_pos
    end

    return chars[spinning_char_pos]
end

-- doc
local hi_group = function (group, text)
    if text == "" then
        return ""
    end

    return "%#" .. group .. "#" .. text
end

local statusline = function ()
    local widgets = {}

    table.insert(widgets, hi_group("Normal", "%=")) -- right align it all
    local lsp_widgets = lsp_clients()
    for i, name in ipairs(lsp_widgets.names) do
        local hi = lsp_widgets.is_attached[i] and AT_MY_TABLINE_SHINE or AT_MY_TABLINE_DIM
        local marker = lsp_widgets.is_attached[i] and mk_spinning_char() or "†"
        name = string.format("[%s %s]", marker, name)
        table.insert(widgets, hi_group(hi, name))
    end

    table.insert(widgets, hi_group("Folded", vim.fn.getcwd()))

    widgets = vim.tbl_filter(function(val)
        return val ~= ""
    end, widgets)

    return table.concat(widgets)
end

local style_btn = function (txt, hi)
    txt = txt or "nil"
    if hi ~= nil then
        return hi_group(hi, "⎨") .. txt .. hi_group(hi, "⎬")
    end
    return "⎨" .. txt .. "⎬"
end

_G.styles_lightmode_toggle = function()
    if not _G.styles_lightmode_state then
        require("talbergs.styles").set_light()
        _G.styles_lightmode_state = true
    else
        require("talbergs.styles").set()
        _G.styles_lightmode_state = nil
    end
end

local set_on_click_G_fn = function (text, fnname)
    return "%0@v:lua." .. fnname .. "@" .. text .. "%"
end

local function tab_focused_window_ft(tab_idx)
    local winid = vim.fn.tabpagewinnr(tab_idx)
    local bufnr = vim.fn.winbufnr(winid)
    if bufnr == -1 then
        return ""
    end
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    return ft
end

local tab_ft_icons_indicator = function (unique_fts, cursor_at_ft)
    local sep = " "
    local decors = vim.tbl_map(function (ft)
        local hl_back = "NonText"
        local hl_front = "DiagnosticWarn"
        local icons = require("nvim-web-devicons")
        local iconft = ft
        if ft == "terraform" then
            iconft = "tf"
        end
        local icon = icons.get_icon_by_filetype(iconft) or icons.get_icon(iconft) or ""
        local hl = cursor_at_ft == ft and hl_front or hl_back

        return {hl, icon}
    end, unique_fts)

    local icons = vim.tbl_map(function (decor)
        return hi_group(decor[1], decor[2])
    end, decors)

    return table.concat(vim.tbl_values(icons), sep)
end

local tab_labels_metadata = function (tabscount, currenttab)
    local tabs = {}
    local i = 0
    local is_hidden_buf = function (ft)
        return ft == "neo-tree" or ft == "spectre_panel"
    end

    while i < tabscount do
        local unique_fts = {}
        i = i + 1
        local tab_buf_list = vim.fn.tabpagebuflist(i)
        if tab_buf_list == 0 then
            vim.notify_once("E730: using List as a Number", vim.log.levels.WARN)
        end

        for _, bufnr in ipairs(tab_buf_list) do
            local ft = vim.api.nvim_get_option_value('filetype', {buf = bufnr})
            if not is_hidden_buf(ft) then
                unique_fts[ft] = ft
            end
        end

        local ft = tab_focused_window_ft(i)
        local tab = {
            unique_fts = unique_fts,
            cursor_at_ft = is_hidden_buf(ft) and "" or ft,
            is_focused_tab = currenttab == i
        }
        table.insert(tabs, tab)
    end
    return tabs
end

-- ⎛    ⎞  ⎛   ⎞  ⎛    ⎞
--
-- ⎝    ⎠  ⎝   ⎠  ⎝    ⎠
--
-- ⎝    ⎠  ⎛   ⎞  ⎝    ⎠
--
-- ⌌    ⌍  ⌌    ⌍  ⌌    ⌍
--
-- ⌜    ⌝  ⌜    ⌝  ⌜    ⌝
--
-- ‗⎧    ⎫‗‗⎧    ⎫‗‗⎧    ⎫‗ -- CHOSEN
--
-- ⎧    ⎫…⎧    ⎫‗⎧    ⎫
--
-- ⎡    ⎤ ⎡   ⎤ ⎡    ⎤
--
-- ⎢    ⎥◯⎢   ⎥◯⎢    ⎥
--
-- ⎢    ⎥•⎢   ⎥◯⎢    ⎥
--
-- ⎣    ⎦ ⎣   ⎦ ⎣    ⎦
--
-- ⌈    ⌉ ⌈    ⌉ ⌈    ⌉
--
-- ⌊    ⌋‗⌊    ⌋ ⌊    ⌋
local mk_tab_body = function (tab)
    local theme = {
        l = "⎧",
        r = "⎫",
        s = "░",
    }
    local hi1 = tab.is_focused_tab and AT_MY_TABLINE_GLOW or AT_MY_TABLINE_DIM
    local fts_widget = tab_ft_icons_indicator(tab.unique_fts, tab.cursor_at_ft)
    local marker_l = tab.is_focused_tab and "♰ " or "  "
    local marker_r = tab.is_focused_tab and " ♰" or "  "

    return table.concat({
        hi_group(hi1, theme.s),
        hi_group(hi1, theme.l),
        hi_group(AT_MY_TABLINE_SHINE, marker_l),
        hi_group(hi1, fts_widget .. " "),
        hi_group(AT_MY_TABLINE_SHINE, marker_r),
        hi_group(hi1, theme.r),
        hi_group(hi1, theme.s),
    })
end

local tabline = function ()
    local widgets = {}

    -- [[leftmost section]]
    --@-- Tab line's tab must be wrapped in "%T" to receive mouse events.
    ----- Individual tabpage ID is a number in range 1..N, where N is the number of tab pages. ID changes.
    local tabscount = vim.fn.tabpagenr('$')
    local currenttab = vim.fn.tabpagenr()
    local tabs = tab_labels_metadata(tabscount, currenttab)
    for i, tab in ipairs(tabs) do
        table.insert(widgets, "%" .. i .. "T" .. mk_tab_body(tab) .. "%T")
    end

    -- [[centered section]]
    --@-- [Block] or [Line] visual selection meta-data, hidden in other editor modes
    table.insert(widgets, "%=")
    local hl_search = hl_search_status()
    if hl_search ~= "" then
        table.insert(widgets, hi_group(AT_MY_TABLINE_SHINE, "⋕⎝" .. hl_search .. "⎠"))
    end
    table.insert(widgets, "%=")

    -- [[far right section]]
    table.insert(widgets, "%=")

    -- [Light/Dark theme toggler] - on click - white scheme for sunny days to make text visible
    local theme_btn = _G.styles_lightmode_state and "☾" or "☼" -- ☽☼☾ | ⏾✶
    theme_btn = style_btn(theme_btn, AT_MY_TABLINE_DIM)
    theme_btn = set_on_click_G_fn(theme_btn, 'styles_lightmode_toggle')

    local branch = git_branch()
    if branch ~= "" then
        local icon = require("nvim-web-devicons").get_icon("git")
        table.insert(widgets, style_btn(icon .. " " .. branch, AT_MY_TABLINE_DIM))
    end
    table.insert(widgets, theme_btn)

    return table.concat(widgets)
end

local winbar = function ()
    local widgets = {}

    table.insert(widgets, hi_group(AT_MY_TABLINE_SHINE, "%r"))
    -- if vim.bo.ro == true then
    --     table.insert(widgets, hi_group(AT_MY_TABLINE_SHINE, " [RO] "))
    -- end

    local title = "%f" -- vim.fn.expand("%:t")
    table.insert(widgets, hi_group("NonText", " "))
    if vim.bo.modified == true then
        -- table.insert(widgets, hi_group(AT_MY_TABLINE_JUMP, " [+] " .. title))
        table.insert(widgets, hi_group(AT_MY_TABLINE_GLOW, "◯• " .. title))
        table.insert(widgets, hi_group("NonText", "  "))
    else
        -- table.insert(widgets, hi_group(AT_MY_TABLINE_GLOW,    "     " .. title))
        table.insert(widgets, hi_group("NonText",    "◯  " .. title))
        table.insert(widgets, hi_group("NonText", " •"))
    end

    -- center widgets...
    table.insert(widgets, "%=")
    local vlines = visual_lines_count()
    if vlines ~= "" then
        table.insert(widgets, hi_group(AT_MY_TABLINE_SHINE, "☰ " .. visual_lines_count() .. " "))
    end
    -- table.insert(widgets, hi_group("NonText", hl_search_status()))
    local reg = vim.fn.reg_recording()
    if reg ~= "" then
        local horse = require("nvim-web-devicons").get_icon("huff")
        local msg = string.format("%s macro @%s", horse, reg)
        table.insert(widgets, hi_group(AT_MY_TABLINE_SHINE, msg))
    end

    -- right side widgets...
    table.insert(widgets, "%=")
    table.insert(widgets, hi_group("NonText", " "))
    table.insert(widgets, hi_group("NonText", buffer_nr()))
    table.insert(widgets, hi_group("NonText", file_encoding()))

    widgets = vim.tbl_filter(function(val)
        return val ~= ""
    end, widgets)

    return table.concat(widgets)
end

local set = function()
    -- configure vim to suppress messages likeun "File written"
    -- vim.opt.shortmess:append("c")
    vim.opt.showtabline = 2
    vim.opt.laststatus = 3
    vim.opt.showmode = false
    -- restack this call to the end of the event loop
    vim.defer_fn(init_hlgroups, 0)
    vim.opt.tabline = "%!luaeval('require(\"talbergs.statusline\").tabline()')"
    vim.opt.winbar = "%!luaeval('require(\"talbergs.statusline\").winbar()')"
    vim.opt.statusline = "%!luaeval('require(\"talbergs.statusline\").statusline()')"
end

-- -- REDRAW TIMER (let that foot terminal sweat)
-- local last_redraw = nil
-- local timer_going = false
-- local function redraw_callback(now)
--     last_redraw = now or vim.loop.now()
--     vim.api.nvim_command('redrawstatus!')
-- end
--
-- local timer = vim.loop.new_timer()
-- vim.loop.timer_start(timer, 2, 0, wrapped_redraw_callback)
--
-- local wrapped_redraw_callback = vim.schedule_wrap(redraw_callback)
-- local function redraw()
--     local now = vim.loop.now()
--     print(last_redraw, now)
--     if last_redraw == nil or now - last_redraw >= 2000 then
--         redraw_callback(now)
--     elseif not timer_going then
--         print("aaaaa3")
--         timer_going = true
--     end
-- end
-- redraw()

-- global_test_statusline_generator = statusline
-- global_test_tabline_generator = tabline
-- vim.opt.showtabline = 2
-- vim.opt.laststatus = 3
-- vim.opt.tabline = "%!luaeval('global_test_tabline_generator()')"

-- global_test_winbar_generator = winbar
-- vim.opt.winbar = "%!luaeval('global_test_winbar_generator()')"
-- vim.opt.statusline = "%!luaeval('global_test_statusline_generator()')"

return {
    statusline = statusline,
    tabline = tabline,
    winbar = winbar,
    set = set
    -- set = function () return nil end
}
