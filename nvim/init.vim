:set number
:set relativenumber
:set mouse=a
:set scrolloff=8

:syntax enable

:set tabstop=4
:set softtabstop=4
:set shiftwidth=4
:set expandtab
:set autoindent
:set smarttab
:set fileformat=unix

" Coc basics
" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
:set encoding=utf-8
" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
:set updatetime=300
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
:set signcolumn=yes

" let mapleader = ' '

call plug#begin()
    Plug 'tpope/vim-surround' " Surrounding ysw
	Plug 'vim-airline/vim-airline' "Themeing
	Plug 'vim-airline/vim-airline-themes' "Themeing
	Plug 'preservim/nerdtree' "File Browsing
	Plug 'morhetz/gruvbox' "Text Color
	Plug 'windwp/nvim-autopairs' "Bracket Completion
	Plug 'norcalli/nvim-colorizer.lua' "Show hex color
    Plug 'ryanoasis/vim-devicons' " Developer Icons
    Plug 'preservim/tagbar' " Code Navigation (Doesnt work)
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " Auto Completion
    Plug 'lukas-reineke/indent-blankline.nvim' " Indent line
    Plug 'ur4ltz/surround.nvim' " () {} etc.
    Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
    Plug 'edluffy/hologram.nvim' " Show Images
call plug#end()

colorscheme gruvbox
lua require("nvim-autopairs").setup()

nmap <F8> :TagbarToggle<CR>
nmap <C-L> <Leader>

nmap <C-s> :w<CR>
nmap <C-q> :q<CR>
nmap <C-w> :bd<CR>
nmap <C-Left> :bp<CR>
nmap <C-Right> :bn<CR>
nmap <C-t> :NERDTreeToggle<CR>
nmap <C-r> :NERDTreeFind<CR>

" ================= Auto completion ======================
" https://github.com/neoclide/coc.nvin

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <S-TAB> coc#refresh()

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" =========================================================

" autocmd VimEnter * NERDTreeFind | wincmd p

let NERDTreeQuitOnOpen=1
let g:NERDTreeMinimalUI=0
let g:NERDTreeFileLines = 1
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

if(has("termguicolors"))
    set termguicolors
endif

let g:airline_theme='deus'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline#extensions#tabline#enabled=1
let g:airline#extensiones#tabline#fnamemode=':t'

" Terminal
" =========================================================
lua require 'toggleterm'.setup()
nmap <C-y> :ToggleTerm size=10 direction=horizontal<CR> 

" =========================================================
lua require 'colorizer'.setup()
lua require('init')
