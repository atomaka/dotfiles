" Fix for CSE servers
scriptencoding utf-8
set encoding=utf-8

" Plugins
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'airblade/vim-gitgutter'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'godlygeek/tabular'
Bundle 'itchyny/lightline.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'rodjek/vim-puppet'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'

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
set number
set noswapfile            " Hope for the best
set virtualedit=all       " Cursor can go anywhere
set scrolloff=3           " Keep cursor from touching edges
" Tabs are 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
" Show whitespace markers before cursor in insert mode
set list listchars=tab:\ \ ,trail:·

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

" Don't cancel visual mode while indenting
vnoremap > >gv
vnoremap < <gv

" Leaders (whatever that means)
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

" others
" clear search - do not put this comment to the right of ,cs
map <Leader>cs :let @/ = ""<cr>
map <Leader>fw :FixWhitespace<cr>
" indent and return
map <Leader>i mmgg=G`m<cr>
map <Leader>lf :call LargeFileToggle()<cr>
" reload all buffers
map <Leader>ra :bufdo e!<cr>
map <Leader>s :e ~/Source/<cr>
map <Leader>sa :call RenameFile()<cr>
map <Leader>se :e ~/.vimrc<cr>
map <Leader>st :call SyntaxToggle()<cr>
map <Leader>sz :so ~/.vimrc<cr>
map <Leader>ts :sp ~/tool-sharpener.txt<cr>

" Set style
set t_Co=256
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

" Set special case colors
function! SetColors()
  hi CursorLine cterm=NONE ctermbg=234
  hi CursorColumn cterm=NONE ctermbg=234
  hi StatusLine ctermfg=white ctermbg=236
  hi SignColumn ctermbg=black
  hi ColorColumn ctermbg=234
  hi IndentGuidesOdd  ctermbg=black
  hi IndentGuidesEven ctermbg=234
endfunction

" Needs to come after SetColors definition
call SetColors()
