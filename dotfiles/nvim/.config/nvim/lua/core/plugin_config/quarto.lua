require("quarto").setup({
    debug = false,
    closePreviewOnExit = true,
    lspFeatures = {
        enabled = false,
        chunks = "all",
        languages = { "r", "python", "julia", "bash", "html" },
        diagnostics = {
            enabled = false,
            triggers = { "BufWritePost" },
        },
        completion = {
            enabled = false,
        },
    },
    codeRunner = {
        enabled = true,
        default_method = 'molten', -- 'molten' or 'slime'
        ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
                        -- Takes precedence over `default_method`
        never_run = { "yaml" }, -- filetypes which are never sent to a code runner
    }
})

