call plug#begin('~/.vim/plugged')

Plug 'chrisbra/matchit'
Plug 'dhruvasagar/vim-zoom'
Plug 'junegunn/fzf'
Plug 'moll/vim-bbye'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'

" languages
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'hashivim/vim-terraform'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

call plug#end()

" STATUS LINE
set statusline=
set statusline+=%<\ %f%{zoom#statusline()}
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
set hlsearch
set ignorecase
set incsearch
set smartcase
set wrapscan

set number
set relativenumber

set textwidth=80
set colorcolumn=80,120

" For commands
set infercase
set wildcharm=<tab>
set wildignorecase
set wildmenu
set wildmode=list:longest,full

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

" rust.vim
let g:rustfmt_autosave = 1

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
map <Leader>gh :GBrowse<cr>

" vim-plug
map <Leader>pc :PlugClean<cr>
map <Leader>pi :PlugInstall<cr>
map <Leader>pu :PlugUpdate<cr>

" vim-terraform
let g:terraform_align=1

" zoomwintab.vim
nmap <C-w>z <Plug>(zoom-toggle)
nmap <C-w><C-z> <Plug>(zoom-toggle)
let g:zoom#statustext='Z'
function! MyCtrlW()
  let char = nr2char(getchar())

  if get(t:, 'zoomed', 0) == 1
    if char is# 'v' || char is# 's' || char is# '' || char is# ''
      return ""
    endif
  end
  return "\<C-w>".char
endfunction
nnoremap <expr> <C-w> MyCtrlW()
