" Plugins
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'airblade/vim-gitgutter'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'godlygeek/tabular'
Bundle 'kien/ctrlp.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'rodjek/vim-puppet'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/ruby-matchit'

" Options
set nocompatible          " Disable vi compatibility
set fileformats=unix,dos  " File format prefer unix endings
set endofline             " Add newlien at end of file
set shellslash            " Forward slashes
set nobackup              " No backup files
set formatoptions=crq
set textwidth=80
set cpoptions+=$          " delimit end of change text
set laststatus=2          " Always show status line
set showmode              " Show current mode
set history=100           " History length
set cursorline            " Highlight current line
set cursorcolumn          " Highlight current column
set nowrap                " Disable wrapping by default
set backspace=2           " Backspace over indent, eol, start of insert
set hlsearch              " Search highlights
set wrapscan              " Wraped search
set incsearch             " Search as yuo type
set ignorecase            " Ignore case with search
set smartcase             " Search will not ignore uppercase
set showcmd               " Show command as you type
set ruler                 " Show cursor position
set autoindent
set colorcolumn=80        " Ruler at line 80
set nomodeline
set relativenumber        " Relative line numbers
set noswapfile            " Hope for the best
" Tabs are 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
" Show whitespace markers before cursor in insert mode
set list listchars=tab:\ \ ,trail:·

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

" Still using arrow keys when in insert mode sometimes
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" Leaders (whatever that means)
let mapleader = ","

map <Leader>bi :BundleInstall<cr>
map <Leader>c "+
map <Leader>fw :FixWhitespace<cr>
map <Leader>lf :call LargeFileToggle()<cr>
map <Leader>p "+p
map <Leader>s :e ~/Source/<cr>
map <Leader>sa :call RenameFile()<cr>
map <Leader>se :e ~/.vimrc<cr>
map <Leader>sz :so ~/.vimrc<cr>
map <Leader>t :Tabularize /
map <Leader>ts :sp ~/tool-sharpener.txt<cr>

" Set style
set t_Co=256
set guifont=Ubuntu\ Mono\ 10
colorscheme vividchalk

hi CursorLine cterm=NONE ctermbg=234
hi CursorColumn cterm=NONE ctermbg=234
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
  set cursorcolumn!
endfunction

" Rename current file - from github/garybernhardt
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
