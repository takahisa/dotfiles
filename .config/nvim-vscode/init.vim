" Do not create swap, undo, and backup files.
set nobackup
set noswapfile
set noundofile

" Do not create .viminfo"
set viminfo=

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
call plug#end()


" Key bindings
let mapleader = "\<Space>"
nnoremap <Leader>r <Cmd>source $MYVIMRC <CR>

command! VSCodeSaveCommand :call VSCodeNotify('workbench.action.files.save')
command! VSCodeQuitCommand :call VSCodeNotify('workbench.action.closeActiveEditor')

cnoreabbrev w VSCodeSaveCommand
cnoreabbrev q VSCodeQuitCommand

nnoremap <Leader>e <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>

map [b <Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>
map ]b <Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>

nnoremap <Esc><Esc> :nohlsearch<CR>
