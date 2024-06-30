local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-tree/nvim-tree.lua' -- File Browsing
    use 'nvim-tree/nvim-web-devicons'
    use 'ellisonleao/gruvbox.nvim' -- Color Theme
    use 'nvim-lualine/lualine.nvim'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets' -- VSCode Like snippets
    use 'lewis6991/gitsigns.nvim' -- OPTIONAL: for git status
    use 'romgrk/barbar.nvim' -- Buffer tabs
    use 'norcalli/nvim-colorizer.lua' -- Hex colors
    use 'windwp/nvim-autopairs' -- Bracket Completion
    use 'lukas-reineke/indent-blankline.nvim' -- Indent line
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
    }                                     -- Language server protocol
    use 'nvim-treesitter/nvim-treesitter' -- Syntax highlighting
    use 'github/copilot.vim' -- Copilot
    if packer_bootstrap then
    require('packer').sync()
    end
end)
