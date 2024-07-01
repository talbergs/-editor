local set_telescope_material_theme = function()
    local normal_hl = vim.api.nvim_get_hl_by_name('Normal', true)

    local purple1 = '#333352'
    local purple2 = '#232338'
    local purple3 = '#12121c'
    local red1 = '#ba3648'
    local green1 = '#37ad39'
    local blue1 = '#0985de'

    ----------------------------------------------------------------------
    --                              Prompt                              --
    ----------------------------------------------------------------------
    vim.api.nvim_set_hl(0, 'TelescopePromptBorder', {
        fg = purple3,
        bg = purple3,
    })

    vim.api.nvim_set_hl(0, 'TelescopePromptNormal', {
        fg = normal_hl.foreground,
        bg = purple3,
    })

    vim.api.nvim_set_hl(0, 'TelescopePromptTitle', {
        fg = normal_hl.foreground,
        bg = red1,
    })

    vim.api.nvim_set_hl(0, 'TelescopePromptCounter', {
        fg = red1,
        bg = purple3,
    })

    vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', {
        fg = red1,
        bg = purple3,
    })

    ----------------------------------------------------------------------
    --                              Result                              --
    ----------------------------------------------------------------------
    vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', {
        fg = purple2,
        bg = purple2,
    })

    vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', {
        fg = normal_hl.foreground,
        bg = purple2,
    })

    vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', {
        fg = normal_hl.foreground,
        bg = blue1,
    })

    vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', {
        fg = blue1,
        bg = vim.api.nvim_get_hl_by_name('TelescopeSelection', true).background,
    })

    ----------------------------------------------------------------------
    --                             Preview                              --
    ----------------------------------------------------------------------

    vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', {
        fg = purple1,
        bg = purple1,
    })

    vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', {
        fg = normal_hl.foreground,
        bg = purple1,
    })

    vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', {
        fg = normal_hl.foreground,
        bg = green1,
    })
end

local make_transparent = function()
    vim.cmd[[
        hi Normal guibg=none
        hi NonText guibg=none
        hi WinBar guibg=none
        hi WinBarNC guibg=none
        hi WinSeparator guibg=none
        hi StatusLine guibg=none
        hi StatusLineNC guibg=none
        hi TabLine guibg=none
        hi TabLineFill guibg=none
        hi TabLineFill guibg=none
        hi TabLineSel guibg=none

        hi DiffAdd guibg=none guifg=#37ad39
        hi DiffChange guibg=none guifg=#0985de
        hi DiffDelete guibg=none guifg=#ba3648
        hi DiffText guibg=none guifg=#ba3648

        hi LspReferenceWrite guibg=none guifg=red
        hi LspReferenceRead guibg=none guifg=green
    ]]
end

return {
    set = function()
        -- COLOR GROUPS HL GROUPS
        vim.cmd[[colorscheme desert]]

        set_telescope_material_theme()
        make_transparent()
    end,
    set_light = function()
        vim.cmd[[colorscheme shine]]
    end,
}
