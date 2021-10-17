set nocompatible
set splitbelow
set splitright
set encoding=utf-8
syntax on
set number
set backspace=indent,eol,start
set history=200
set suffixes+=.pyc " Ignore the files when tab-completing
filetype plugin indent on
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent


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
set mouse+=a  " touchpad scrolling

set cursorline " highlight current line
set wildmenu " visual autocomplete for command menu

set directory=~/.vim/swp// " swap files in specific place

" diagnostics run by coc and sent to ale
let g:ale_disable_lsp = 1

" Install VimPlug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
" This is used to show the git branch on vim-airline
Plug 'tpope/vim-fugitive' " GBlame <3
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs' " ()
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-surround' " easier quoting or changing quotes
Plug 'tpope/vim-commentary' " gcc to comment, or gc in visual
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale' " async linting
Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocomplete
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'Vimjas/vim-python-pep8-indent' " proper python indentetion for funcs/ dicts..
Plug 'vim-python/python-syntax' " better python syntax highlighting
Plug 'preservim/tagbar'
Plug 'cespare/vim-toml' " toml syntax highlight

" Initialize plugin system
call plug#end()

" trying out better syntax highlighting for python with python-syntax
let g:python_highlight_all = 1

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

" Esc in terminal goes into normal mode
tnoremap <esc> <C-\><C-n>

" fzf bindings
nmap <leader>f :Files<cr>    " fuzzy find files in the working directory
nmap <leader>/ :BLines<cr>   " fuzzy find lines in the current buffer
nmap <leader>b :Buffers<cr>  " fuzzy find an open buffer
nmap <leader>r :Rg<cr>       " fuzzy find text in the working directory
nmap <leader>c :Commands<cr> " fuzzy find Vim commands
nmap <leader>h :History<cr>  " fuzzy find history

" special bindings to specify a path to fzf commands
" Using double leader because using double ff for example
" would slow the response time too much
nmap <leader><leader>f :Files ~/
nmap <leader><leader>r :DRg ~/

" Preview window when using Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Rg with preview from specified directory
command! -bang -nargs=* -complete=dir DRg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(''), 1,
  \   fzf#vim#with_preview({'dir': <q-args>}), <bang>0)

" fzf :Files shows also hidden files outside of .git/ and correctly ignores
" files in .gitignore
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'

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

" linting configuration
" Use ale for having linting without saving the buffer
let g:ale_linters = {
\   'python': ['flake8'],
\   'rust': [''],
\}

" run rustfmt on save
let g:ale_fixers = {
\   'rust': ['rustfmt'],
\}

let g:ale_fix_on_save = 1

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


" vim-go

" disable vim-go :GoDef short cut (gd)
" this will be handled by coc 
let g:go_def_mapping_enabled = 0

""""""""""""""""""""""""""
" Coc
""""""""""""""""""""""""""

" TextEdit might fail if hidden is not set.
"set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
"set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <F2> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Symbol renaming.
" not feeling the need for this and it is slowing the Rg search
" nmap <leader>rn <Plug>(coc-rename)


augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)


" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>

let g:coc_global_extensions = [
    \ 'coc-pyright',
    \ 'coc-rust-analyzer'
    \ ]

" use onedark colors for Error & Warning 
highlight link CocErrorSign Identifier 
highlight link CocWarningSign Boolean 


" toggle mouse support and lines number for easy clipboard copy
let g:is_mouse_enabled = 1
noremap <silent> <Leader>m :call ToggleMouse()<CR>
function ToggleMouse()
    if g:is_mouse_enabled == 1
        set mouse-=a
        set nonumber
        set signcolumn=no
        let g:is_mouse_enabled = 0
    else
        set mouse+=a
        set number
        set signcolumn=yes
        let g:is_mouse_enabled = 1
    endif
endfunction

" automatically remove trailing whitespaces for specified languages
autocmd FileType python,go autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" this function keeps state so that the cursor doesn't jump on the last
" changed line when saving and removing whitespaces
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""
"     WIP
" This would call rg on every change of letter, currently requires a path and
" an initial query, would be better if the first query could be optional
" NOTE: does not support fuzzy finding

function! RipgrepFzf(directory, query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'dir': a:directory, 'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang -complete=dir RG call RipgrepFzf(<f-args>, <bang>0)
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" let vim use terminal transparency
hi Normal guibg=NONE ctermbg=NONE

nmap <F8> :TagbarToggle<CR>
