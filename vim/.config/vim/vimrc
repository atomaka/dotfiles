call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf'

call plug#end()

" SETTINGS
set nobackup
set noswapfile
set timeoutlen=500                " Don't wait too long (ambiguous leaders)

" LEADERS
let mapleader = ","

map <Leader>sz :so ~/.config/vim/vimrc<cr>

" PLUGIN CONFIGURATION
" fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
noremap <C-p> :FZF<CR>
