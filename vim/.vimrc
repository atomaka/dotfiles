call plug#begin('~/.vim/plugged')

Plug 'chrisbra/matchit'
Plug 'junegunn/fzf'
Plug 'moll/vim-bbye'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'troydm/zoomwintab.vim'

" languages
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'hashivim/vim-terraform'

call plug#end()

" SETTINGS
filetype plugin indent on

set backspace=2                   " Backspace over indent, eol, start of insert
set cpoptions+=$                  " delimit end of change text
set endofline                     " Add newline to end of file
set nobackup
set noswapfile
set nowrap                        " Disable wrapping by default
set scrolloff=3                   " Keep cursor from touching edges
set showmode                      " Show current mode
set timeoutlen=500                " Don't wait too long (ambiguous leaders)
set virtualedit=all               " Cursor can go anywhere

set hlsearch                      " Search highlights
set ignorecase                    " Ignore case with search
set incsearch                     " Search as you type
set smartcase                     " Search will not ignore uppercase
set wrapscan                      " Wrapped search

set number
set relativenumber                " Relative line numbers

set textwidth=80
set colorcolumn=80,120            " Ruler at line 80, 120

" Tabs are 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set shiftround                    " make >> go to next tab

" consistency is key - Y should act like C, D
map Y y$

" Don't cancel visual mode while indenting
vnoremap > >gv
vnoremap < <gv

" typo-city
:command W w
:command Wq wq

" quick replaceement
nmap S :%s//g<LEFT><LEFT>

" LEADERS
let mapleader = ","

map <Leader>sz :so ~/.vimrc<cr>

" copy/paste (system buffer)
map <Leader>cp "+y
map <Leader>pa "+p

" clear search
map <Leader>cs :let @/ = ""<cr>

" github
map <Leader>gg :exe "!hub gist create -o %:p"<cr><cr>

" PLUGIN CONFIGURATION
" fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
noremap <C-p> :FZF<CR>

" vim-bbye
nnoremap <silent> <Leader>bd :Bdelete<CR>

" vim-better-whitespace
highlight ExtraWhitespace ctermbg=red
map <Leader>fw :StripWhitespace<cr>

" vim-eunuch
map <Leader>sa :Move %<tab>

" Fugitive
autocmd FileType fugitiveblame nmap <buffer> q gq
command! Gblame :G blame
map <Leader>gb :Git blame<cr>

" vim-plug
map <Leader>pc :PlugClean<cr>
map <Leader>pi :PlugInstall<cr>
map <Leader>pu :PlugUpdate<cr>

" zoomwintab
nnoremap <C-w>z :ZoomWinTabToggle<CR>
nnoremap <C-w><C-z> :ZoomWinTabToggle<CR>
function! ZoomState()
  if exists('t:zoomwintab')
    return 'Z'
  else
    return ''
  endif
endfunction
