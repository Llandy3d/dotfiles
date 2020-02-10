set nocompatible
set splitbelow
set splitright
set encoding=utf-8
syntax on
set number
set backspace=indent,eol,start
set history=200
set suffixes+=.pyc " Ignore the files when tab-completing
set tabstop=4
set softtabstop=4
set expandtab

" Disable the default Vim startup message.
set shortmess+=I

" allow hidden buffers with unsaved changes
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch
set hlsearch            " highlight matches


" Enable mouse support
set mouse+=a

set cursorline " highlight current line
set wildmenu " visual autocomplete for command menu

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
" This is used to show the git branch on vim-airline
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()


let mapleader=" "       " leader is space

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" jk is escape
inoremap jk <esc>

" Move between open buffers
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" faster window shortcuts
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l


" fzf bindings
nmap <leader>f :Files<cr>    " fuzzy find files in the working directory
nmap <leader>/ :BLines<cr>   " fuzzy find lines in the current buffer
nmap <leader>b :Buffers<cr>  " fuzzy find an open buffer
nmap <leader>r :Rg<cr>       " fuzzy find text in the working directory
nmap <leader>c :Commands<cr> " fuzzy find Vim commands
nmap <leader>h :History<cr>  " fuzzy find history

" Preview window when using Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)


map <leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] " ignore .pyc files
let NERDTreeShowHidden=1 " show . files

" close vim if the only window is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" one dark theme
colorscheme onedark

" show buffer line on top
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Set gitgutter sign priority to 0 so that linter sign have priority
let g:gitgutter_sign_priority = 0

if (has("termguicolors"))
  set termguicolors
endif

" virtualenv support 
" NOTE: to be tested
py3 << EOF
import os, sys, pathlib
if 'VIRTUAL_ENV' in os.environ:
    venv = os.getenv('VIRTUAL_ENV')
    site_packages = next(pathlib.Path(venv, 'lib').glob('python*/site-packages'), None)
    if site_packages:
        sys.path.insert(0, str(site_packages))
EOF

