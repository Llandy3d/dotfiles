set nocompatible
set splitbelow
set splitright
set encoding=utf-8
syntax on
set number
set backspace=indent,eol,start

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

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

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

" Initialize plugin system
call plug#end()


let mapleader=" "       " leader is space

" jk is escape
inoremap jk <esc>

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
