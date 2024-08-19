local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

map('n', '<c-q>', ':q<CR>', {})
map('n', '<c-w>', ':w<CR>', {})

map('n', '<C-K>', ':wincmd k<CR>', opts)
map('n', '<C-J>', ':wincmd j<CR>', opts)
map('n', '<C-H>', ':wincmd h<CR>', opts)
map('n', '<C-L>', ':wincmd l<CR>', opts)


map('n', '<C-e>', ':NvimTreeFindFile<CR>', {})
map('n', '<C-r>', ':NvimTreeToggle<CR>', {})

-- Buffer Tables
-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)

-- Sort automatically by...
map('n', '<localleader>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<localleader>bn', '<Cmd>BufferOrderByName<CR>', opts)
map('n', '<localleader>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<localleader>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<localleader>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- Quarto
map('n', '<localleader>qa', "<Cmd>QuartoActivate<CR>", opts)
map('n', '<localleader>rc', "<Cmd>QuartoSend<CR>", opts)
map('n', '<localleader>ra', "<Cmd>QuartoSendAbove<CR>", opts)
map('n', '<localleader>rb', "<Cmd>QuartoSendBellow<CR>", opts)
map('n', '<localleader>rA', "<Cmd>QuartoSendAll<CR>", opts)
map('n', '<localleader>rl', "<Cmd>QuartoSendLine<CR>", opts)


map('n', '<C-Enter>', "<Cmd>QuartoSend<CR>", opts)


-- Terminal
map('n', '<localleader>tt', "<Cmd>ToggleTerm size=10 direction=horizontal name=terminal<CR>", opts)
