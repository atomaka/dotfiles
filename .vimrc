" --- Options ---------------------------------------------------------------{{{
set nocompatible        " Disable vi compatability
set ffs=unix,dos        " File format prefer unix endings
set eol                 " Add newline at end of file
set shellslash          " Use forward slashes for file names
set nobk                " Do not use backup files
set formatoptions=crq   " Format options: wrap (c)omments at textwidth, insert comment leade(r), and unknown
set textwidth=80        " 80 characters wide
set laststatus=2        " Always use status line
set ch=2                " Command line two lines high
set wildmenu            " Command line completion helper
set showmode            " Display current mode
if exists("&wildignorecase") " Windows gvim does not have this (it's automatic)
  set wildignorecase    " Ignore case when tab-completing files
endif
set scrolloff=8         " Always keep cursor 8 lines from edge
set backspace=2         " Allow backspace over indent, eol, and start of insert
set hlsearch            " Search highlights
set incsearch           " Search as you type
set ignorecase          " Search will ignore case
set smartcase           " Search will respect case if any letter is uppercase
set hls                 " Highlight search
syntax on               " Turn on syntax highlighting

" Tabstops are 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Set the status line
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]

" Filetype specific stuff
filetype on
filetype plugin on
filetype indent on
" --- }}}

" --- Style and font --------------------------------------------------------{{{
colorscheme vividchalk

if has("gui_gtk2")
    set guifont=Ubuntu\ Mono\ 10
else
    set guifont=Ubuntu\ Mono:h10
endif
" --- }}}

" --- Plugin config ---------------------------------------------------------{{{

" --- }}}
