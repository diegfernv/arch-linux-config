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
