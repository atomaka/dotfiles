" Fix for CSE servers
scriptencoding utf-8
set encoding=utf-8


" vundle bundle; not for changing
set nocompatible          " Disable vi compatibility
filetype off

set runtimepath+=~/.vim/bundle/vundle/
call vundle#begin()

Bundle 'gmarik/vundle'

Bundle 'airblade/vim-gitgutter'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'godlygeek/tabular'
Bundle 'itchyny/lightline.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'rodjek/vim-puppet'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-vividchalk'

call vundle#end()
filetype plugin indent on
" end vundle

" Options
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
set number
set noswapfile            " Hope for the best
set virtualedit=all       " Cursor can go anywhere
set scrolloff=3           " Keep cursor from touching edges
set timeoutlen=500        " Don't wait too long (ambiguous leaders)
set showmatch             " Show matching brackets
set hidden                " Allow unsaved buffers to be hidden
set wildmenu              " Command line completion
" Make syntax highlighting faster
syntax sync minlines=256
set ttyfast
set lazyredraw
" Tabs are 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set shiftround            " if at odd number spaces, make >> go to next even
" Show whitespace markers before cursor in insert mode
set list listchars=tab:\ \ ,trail:·
" Ignore stuff
set wildignore+=*/\.git/*
" Java
set wildignore+=*/build/*,*/grade/*,*\.class
" Frontend
set wildignore+=*/node_modules/*,*/bower_components/*,*/dist/*

" Filetype stuff
syntax on

" Keybinds
" ctrl+s for save spam
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" most common typo ever
command! Q q

" Still using arrow keys when in insert mode sometimes
map <Left> <NOP>
map <Right> <NOP>
map <Up> <NOP>
map <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>

" Don't cancel visual mode while indenting
vnoremap > >gv
vnoremap < <gv

" Use better search highlighting
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>

" i don't even know what semi-colon does so steal it
noremap ; :

" Leaders (shortcuts)
let mapleader = ","

" tab swaps
map <Leader>2 :set tabstop=2 softtabstop=2 shiftwidth=2 expandtab<cr>
map <Leader>4 :set tabstop=4 softtabstop=4 shiftwidth=4 expandtab<cr>
map <Leader>a :set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab<cr>

" buffer movement
map <Leader>h :wincmd h<cr>
map <Leader>j :wincmd j<cr>
map <Leader>k :wincmd k<cr>
map <Leader>l :wincmd l<cr>

" auto character alignment
map <Leader>t :Tabularize /
map <Leader>t> :Tabularize /=><cr>
map <Leader>te :Tabularize /=<cr>

" vundle
map <Leader>bi :BundleInstall<cr>
map <Leader>bu :BundleInstall!<cr>

" copy and paste - for Linux
map <Leader>c "+
map <Leader>p "+p
map <Leader>pm :set paste!<cr>

" clear search
map <Leader>cs :let @/ = ""<cr>
" indent and return
map <Leader>i mmgg=G`m<cr>
" reload all buffers
map <Leader>ra :bufdo e!<cr>
" this was better when it was :Sexplore...
map <Leader>s :Vexplore ~/Source/<cr>

map <Leader>fw :FixWhitespace<cr>
map <Leader>lf :call LargeFileToggle()<cr>
map <Leader>sa :call RenameFile()<cr>
map <Leader>se :e ~/.vimrc<cr>
map <Leader>st :call SyntaxToggle()<cr>
map <Leader>sz :so ~/.vimrc<cr>
map <Leader>ts :sp ~/tool-sharpener.txt<cr>

" Set style
colorscheme vividchalk
" special case colors set at end of file via function

" Indentation
let g:indent_guides_guide_size=1
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors=0

" lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component': {
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ }
      \ }

" Functions
" Toggle relative line numbers and cursorline; useful for long line files
function! LargeFileToggle()
  set relativenumber!
  set cursorline!
  set cursorcolumn!
  call SyntaxToggle()
endfunction

" Toggle syntax highlighting
function! SyntaxToggle()
  if exists("g:syntax_on")
    :syntax off
  else
    syntax enable
  endif
  call SetColors()
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

" Blink current search item - from Damian Conway 'More Instantly Better Vim'
function! HLNext (blinktime)
  let [bufnum, lnum, col, off] = getpos('.')
  let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
  let target_pat = '\c\%#'.@/
  let ring = matchadd('ErrorMsg', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(ring)
  redraw
endfunction

" Set special case colors
function! SetColors()
  highlight CursorLine cterm=NONE ctermbg=234
  highlight CursorColumn cterm=NONE ctermbg=234
  highlight StatusLine ctermfg=white ctermbg=236
  highlight ColorColumn ctermbg=234
  highlight IndentGuidesOdd  ctermbg=black
  highlight IndentGuidesEven ctermbg=234
  " fix for vimgutter
  highlight clear SignColumn
  highlight GitGutterAdd ctermfg=green
  highlight GitGutterChange ctermfg=yellow
  highlight GitGutterDelete ctermfg=red
  highlight GitGutterChangeDelete ctermfg=yellow
endfunction

" Needs to come after SetColors definition
call SetColors()
