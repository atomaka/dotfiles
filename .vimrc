" Plugins
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'airblade/vim-gitgutter'
Bundle 'godlygeek/tabular'
Bundle 'kien/ctrlp.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'rodjek/vim-puppet'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/ruby-matchit'

" Options
set nocompatible         " Disable vi compatibility
set fileformats=unix,dos " File format prefer unix endings
set endofline            " Add newlien at end of file
set shellslash           " Forward slashes
set nobackup             " No backup files
set formatoptions=crq
set textwidth=80
set laststatus=2        " Always show status line
set showmode            " Show current mode
set history=100         " History length
set cursorline          " Highlight current line
set nowrap              " Disable wrapping by default
set backspace=2         " Backspace over indent, eol, start of insert
set hlsearch            " Search highlights
set wrapscan            " Wraped search
set incsearch           " Search as yuo type
set ignorecase          " Ignore case with search
set smartcase           " Search will not ignore uppercase
set showcmd             " Show command as you type
set ruler               " Show cursor position
set autoindent
set colorcolumn=80      " Ruler at line 80
set nomodeline
set relativenumber      " Relative line numbers
" Tabs are 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Other settings
let g:indent_guides_guide_size=1
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors=0

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

map <Leader>bi :BundleInstall<cr>
map <Leader>lf :call LargeFileToggle()<cr>
map <Leader>s :e ~/Source/<cr>
map <Leader>se :e ~/.vimrc<cr>
map <Leader>sz :so ~/.vimrc<cr>
map <Leader>t :Tabularize /
map <Leader>ts :sp ~/tool-sharpener.txt<cr>

" Set style
set guifont=Ubuntu\ Mono\ 10
colorscheme vividchalk

hi CursorLine cterm=NONE ctermbg=234
hi StatusLine ctermfg=white ctermbg=236
hi SignColumn ctermbg=black
hi ColorColumn ctermbg=234
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=234

" Functions
" Toggle relative line numbers and cursorline; useful for long line files
function! LargeFileToggle()
  if &relativenumber
    set number
  else
    set relativenumber
  endif
  set cursorline!
endfunction
