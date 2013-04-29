" Plugins
execute pathogen#incubate()
execute pathogen#infect()

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'airblade/vim-gitgutter'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/ruby-matchit'

" Options
set nocompatible        " Disable vi compatibility
set ffs=unix,dos        " File format prefer unix endings
set eol                 " Add newlien at end of file
set shellslash          " Forward slashes
set nobk                " No backup files
set textwidth=80
set laststatus=2        " Always show status line
set showmode            " Show current mode
set history=100         " History length
set cul                 " Highlight current line
set nowrap              " Disable wrapping by default
set backspace=2         " Backspace over indent, eol, start of insert
set hlsearch            " Search highlights
set wrapscan            " Wraped search
set incsearch           " Search as yuo type
set ignorecase          " Ignore case with search
set smartcase           " Search will not ignore uppercase
set showcmd             " Show command as you type
set hls                 " Highlight search (hlsearch?)
set ruler               " Show cursor position
set autoindent
set number              " Show line numbers
" Tabs are 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Filetype stuff
syntax on
filetype on
filetype plugin on
filetype indent on

" Keybinds
" ctrl+s for save spam
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" Leaders (whatever that means)
let mapleader = ","

map <Leader>s :e ~/Source/
map <Leader>nc :Nyancat<cr>

" Set style
set guifont=Ubuntu\ Mono\ 10
colorscheme vividchalk

set t_Co=256            " 256 terminal colors
set cursorline
hi CursorLine cterm=NONE ctermbg=234
highlight StatusLine ctermfg=white ctermbg=236
hi SignColumn ctermbg=black

