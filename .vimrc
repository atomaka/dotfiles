" --- Options ---------------------------------------------------------------{{{
set nocompatible        " Disable vi compatability
set ffs=unix,dos        " File format prefer unix endings
set eol                 " Add newline at end of file
set shellslash          " Use forward slashes for file names
" set vb                  " Visual bell instead of beep
set nobk                " Do not use backup files
set formatoptions=crq   " Format options: wrap (c)omments at textwidth, insert comment leade(r), and unknown
set textwidth=80        " 80 characters wide
set hidden              " Allow unsaved buffers to be hidden
set laststatus=2        " Always use status line
set showmode            " Display current mode
set ch=2                " Command line two lines high
set wildmenu            " Command line completion helper
if exists("&wildignorecase") " Windows gvim does not have this (it's automatic)
  set wildignorecase    " Ignore case when tab-completing files
endif
set timeoutlen=500      " Timeout for remaps
set history=100         " Keep some stuff in the history
set mousehide           " Hide the mouse pointer while typing
set scrolloff=8         " Always keep cursor 8 lines from edge
set virtualedit=all     " Allow the cursor to go to invalid places
set synmaxcol=1024      " Disable coloring on long lines (helps with large files)
set cul                 " Highlight current line
set nowrap              " Disable wrapping by default
set backspace=2         " Allow backspace over indent, eol, and start of insert
set cpoptions+=$        " Change commands will display a $ to mark end of changed text
set hlsearch            " Search highlights
set wrapscan            " Search will continue past end of document
set incsearch           " Search as you type
set ignorecase          " Search will ignore case
set smartcase           " Search will respect case if any letter is uppercase
set showcmd             " Show command in bottom-right as you type it
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

