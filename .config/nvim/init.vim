" Do not create swap, undo, and backup files.
set nobackup
set noswapfile
set noundofile

" Do not create .viminfo"
set viminfo=

" Do not display the splash screen on startup
set shortmess+=I

" Do not use mouse
set mouse=

" Show the line numbers
set number
" Show the cursor positions at the bottom of screen
set ruler
" Always show the status line
set laststatus=2
" Always show the message window with 2 lines in height
set cmdheight=2

" Highlight the current line
set cursorline
" Highlight the parenthesis
set showmatch matchtime=1

" Increase command history retention limit
set history=1000
" Enable auto-completion for command line
set wildmode=list:longest

" Replace TAB to whitespaces
set expandtab
" Enable backspace in insert mode
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" Enable paste mode
set paste

" Set locale to en_US
language en_US.UTF-8

" Enable syntax highlighting
syntax on
" Enable automatic file type detection
filetype on
filetype plugin indent on

" Enable case-insentive search
set ignorecase
set smartcase
" Enable incremental search
set incsearch
" Highlight search results
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" When the search reaches the end, search again from the beginning
set wrapscan

" Key bindings
let mapleader = "\<Space>"
nnoremap <Leader>r :source $MYVIMRC <CR>

nnoremap <Leader>v :vs<CR>
nnoremap <Leader>h :sp<CR>

map [b :bprev<CR>
map ]b :bnext<CR>

" Install: junegunn/vim-plug
let g:vimplug_path = expand('~/.cache/vim-plug/plug.vim')
let g:vimplug_data = expand('~/.cache/vim-plug/plugged')

if empty(glob(g:vimplug_path))
    execute 'silent !curl -sSfLo ' . g:vimplug_path . ' --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . g:vimplug_path
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
else
    execute 'source ' . g:vimplug_path
endif

" Plugin: junegunn/vim-plug
call plug#begin(g:vimplug_data)
    Plug 'junegunn/vim-plug'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'

    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'editorconfig/editorconfig-vim'
call plug#end()

" Set colorscheme 'dracula'
set termguicolors
let g:dracula_colorterm = 0
let g:dracula_italic = 0
silent! colorscheme dracula

" Plugin: vim-airline/vim-airline
" Plugin: vim-airline/vim-airline-theme
let g:airline_theme = 'dracula'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#default#layout = [[ 'a', 'b', 'c'], ['y', 'z']]
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab

" Plugin: junegunn/fzf
" Plugin: junegunn/fzf.tmux
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 1.0, 'height': 0.3,'yoffset':1.0,'xoffset': 0.0, 'border': 'sharp' } }
let g:fzf_preview_window = []
nnoremap <silent> <Leader>e :FzfFiles <CR>
