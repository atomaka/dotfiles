" PLUGINS
call plug#begin('~/.vim/plugged')

" colors
Plug 'alessandroyorba/alduin'
Plug 'nanotech/jellybeans.vim'

" keepers
Plug 'airblade/vim-gitgutter'
Plug 'atomaka/renamefile.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ZoomWin'

" languages
Plug 'fatih/vim-go'
Plug 'posva/vim-vue'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

" maybe
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'

call plug#end()
filetype plugin indent on

" STATUS LINE
set statusline=%<\ %f\ %m%r%y%w%=%l\/%-6L\ %3c\ 

" OPTIONS
set fileformats=unix,mac,dos      " File format prefer unix endings
set endofline                     " Add newlien at end of file
set shellslash                    " Forward slashes
set nobackup                      " No backup files
set noswapfile                    " Hope for the best
set formatoptions=crq
set textwidth=80
set cpoptions+=$                  " delimit end of change text
set laststatus=2                  " Always show status line
set showmode                      " Show current mode
set history=100                   " History length
set cursorline                    " Highlight current line
set cursorcolumn                  " Highlight current column
set nowrap                        " Disable wrapping by default
set backspace=2                   " Backspace over indent, eol, start of insert
set hlsearch                      " Search highlights
set wrapscan                      " Wrapped search
set incsearch                     " Search as you type
set ignorecase                    " Ignore case with search
set smartcase                     " Search will not ignore uppercase
set showcmd                       " Show command as you type
set ruler                         " Show cursor position
set autoindent                    " autoindent AND be smart about it
set smartindent
set colorcolumn=80                " Ruler at line 80
set nomodeline
set relativenumber                " Relative line numbers
set number
set virtualedit=all               " Cursor can go anywhere
set scrolloff=3                   " Keep cursor from touching edges
set timeoutlen=500                " Don't wait too long (ambiguous leaders)
set showmatch                     " Show matching brackets
set hidden                        " Allow unsaved buffers to be hidden
set wildmenu                      " Command line completion
set wildmode=list:longest,full    " Better file completion
set infercase                     " Adjust completions to match case
set wildignorecase                " Ignore case on commandline
set autowrite                     " Save file when focus is lost
" Tabs are 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set shiftround                    " make >> go to next tab
" Show whitespace markers before cursor in insert mode
set list listchars=tab:\ \ ,trail:·
" Ignore stuff
set wildignore+=*/\.git/*
" Java
set wildignore+=*/build/*,*/grade/*,*\.class
" Frontend
set wildignore+=*/node_modules/*,*/bower_components/*,*/dist/*
" Persistent undo stuff
if has('persistent_undo')
  set undolevels=5000
  set undodir=$HOME/.vim/undo
  set undofile
endif

" KEYBINDS
" quick replaceement
nmap S :%s//g<LEFT><LEFT>

" consistency is key - Y should act like C, D
map Y y$

" Don't cancel visual mode while indenting
vnoremap > >gv
vnoremap < <gv

" ZoomWin
nmap <c-w>z <Plug>ZoomWin

" LEADERS
let mapleader = ","

" tab swaps
map <Leader>2 :set tabstop=2 softtabstop=2 shiftwidth=2 expandtab<cr>
map <Leader>4 :set tabstop=4 softtabstop=4 shiftwidth=4 expandtab<cr>
map <Leader>a :set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab<cr>

" plugin
map <Leader>pc :PlugClean<cr>
map <Leader>pi :PlugInstall<cr>
map <Leader>pu :PlugUpdate<cr>

" clear search
map <Leader>cs :let @/ = ""<cr>

" bclose
nnoremap <silent> <Leader>bd :Bclose<CR>
nnoremap <silent> <Leader>bD :Bclose!<CR>
nnoremap <silent> <Leader>BD :Bclose!<CR>

" other
map <Leader>fw :FixWhitespace<cr>
map <Leader>pm :set paste!<cr>
map <Leader>sa :RenameFile<cr>
map <Leader>se :e ~/.vimrc<cr>
map <Leader>sz :so ~/.vimrc<cr>

" PLUGIN CONFIGURATION
" style
colorscheme jellybeans
syntax enable

" go
let g:go_fmt_command = "goimports"
