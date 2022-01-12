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

" STATUS LINE
set statusline=
set statusline+=%<\ %f%{ZoomState()}
set statusline+=\ %m%r%y%w%=
set statusline+=\ Line:\ %l\/%L\ [%p%%]
set statusline+=\ Col:\ %v
set statusline+=\ Buf:\ #%n
set statusline+=\                       " trailing space

" SETTINGS
filetype plugin indent on

set autowrite
set backspace=2                   " Backspace over indent, eol, start of insert
set cpoptions+=$                  " delimit end of change text
set endofline
set laststatus=2                  " always show status line
set nobackup
set noswapfile
set nowrap
set scrolloff=3
set showmatch
set showmode
set timeoutlen=500                " Don't wait too long (ambiguous leaders)
set virtualedit=all               " Cursor can go anywhere
set wildcharm=<tab>               " Allow use of tab in macros
set hlsearch
set ignorecase
set incsearch
set smartcase
set wrapscan

set number
set relativenumber

set textwidth=80
set colorcolumn=80,120

" Tabs are 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set shiftround                    " make >> go to next tab

if has('persistent_undo')
  set undolevels=5000
  set undodir=$HOME/.vim/undo
  set undofile
endif

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

" tabbing
map <Leader>2 :set tabstop=2 softtabstop=2 shiftwidth=2 expandtab<cr>
map <Leader>4 :set tabstop=4 softtabstop=4 shiftwidth=4 expandtab<cr>
map <Leader>a :set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab<cr>
map <Leader>st :let @/ = "\t"<cr>

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

" vim-fugitive
autocmd FileType fugitiveblame nmap <buffer> q gq
command! Gblame :G blame
map <Leader>gb :Git blame<cr>

" vim-plug
map <Leader>pc :PlugClean<cr>
map <Leader>pi :PlugInstall<cr>
map <Leader>pu :PlugUpdate<cr>

" vim-terraform
let g:terraform_align=1

" zoomwintab.vim
nnoremap <C-w>z :call MyZoomWinTabToggle()<CR>
nnoremap <C-w><C-z> :call MyZoomWinTabToggle()<CR>
function! MyZoomWinTabToggle()
  call zoomwintab#Toggle()
  if exists('t:zoomwintab')
    echo 'unmap'
    nnoremap <C-w>s <nop>
    nnoremap <C-w>v <nop>
    nnoremap <C-w><C-s> <nop>
    nnoremap <C-w><C-v> <nop>
  else
    echo 'remap'
    nnoremap <C-w>s :split<cr>
    nnoremap <C-w>v :vsplit<cr>
    nnoremap <C-w><C-s> :split<cr>
    nnoremap <C-w><C-v> :vsplit<cr>
  endif
endfunction
function! ZoomState()
  if exists('t:zoomwintab')
    return 'Z'
  else
    return ''
  endif
endfunction
