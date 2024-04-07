require('hologram').setup{
    auto_display = true -- WIP automatic markdown image display, may be prone to breaking
}

--Indent Blank Line
--=========================================================
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#FB4934" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#FABD2F" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#83A598" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#FE8019" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#B8BB26" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#D3869B" })
end)

require("ibl").setup { indent = { highlight = highlight } }

--Show Function always
--=========================================================
require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}
