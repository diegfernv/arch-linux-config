local cmp = require("cmp")
local map = cmp.mapping

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    mapping = map.preset.insert({
        ['<C-b>'] = map.scroll_docs(-4),
        ['<C-f>'] = map.scroll_docs(4),
        ['<C-o>'] = map.complete(),
        ['<C-e>'] = map.abort(),
        ['<CR>'] = map.confirm({ select = true }),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    }),
})
