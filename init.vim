" basic configuration
set wrap  " enable line wrapping
set linebreak  " avoid wrapping a line in the middle of a word
set number  " line numbers
set relativenumber  " set relative line numbers
set ignorecase  " ignore case when searching
set smartcase  " automatically switch search to case-sensitive when search query constains an uppercase letter
set cursorline  " highlight the line currently under cursor
set showmatch  " show matching brackets
set mouse=a  " enable mouse for scrolling and resizing
set hidden  " enable new buffer creation without saving previous buffer
set clipboard+=unnamedplus  " always use the clipboard for all operations
au TermOpen * setlocal nonumber norelativenumber  " remove line numbers and relative line numbers in terminal


" plugins with vim-plug
call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'frazrepo/vim-rainbow'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'tpope/vim-sleuth'
Plug 'Yggdroot/indentLine'
Plug 'majutsushi/tagbar'
" colorschemes
Plug 'altercation/vim-colors-solarized'
Plug 'cocopon/iceberg.vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'tomasiser/vim-code-dark'
Plug 'bluz71/vim-nightfly-guicolors'
call plug#end()


" plugin configurations
" nightfly
set termguicolors  " allows colorscheme to work
colorscheme nightfly  " use nightfly colorscheme

" NERDTree
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
let NERDTreeMinimalUI = 1  " Disables display of the 'Bookmarks' label and 'Press ? for help' text.
let NERDTreeShowHidden = 1  " Tells the NERDTree whether to display hidden files on startup.

" airline
" use some powerline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = ''

" vim-gitgutter
set updatetime=100  " reduce delay to 100ms

" CoC
" install the missing extensions after coc.nvim service started
let g:coc_global_extensions = ['coc-pyright', 'coc-tsserver', 'coc-java', 'coc-html', 'coc-css', 'coc-json']
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" GoTo code navigation.
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" ALE
let g:ale_enabled = 0  " do not auto lint; want to use linting from coc instead of ale
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}  " fixers for all files
let g:ale_fix_on_save = 1  " fix on save

" vim-markdown
let g:vim_markdown_conceal = 0  " disable concealing syntax for markdown
let g:vim_markdown_conceal_code_blocks = 0  " disable conceal for code blocks in markdown

" indentLine
let g:indentLine_char = '│'  " use prettier lines
let g:indentLine_setColors = 0  " for nightfly colorscheme
