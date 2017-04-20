"" .vimrc
""
"" Generic config here, GUI- and package-specific
"" config must go in .gvimrc

set nocompatible                    " No Vi compatibility
let mapleader=","                   " Leader key

set clipboard=unnamed               " Some sane, modern(-ish) defaults
set esckeys
set ttyfast
set gdefault
set encoding=utf-8 nobomb

colorscheme cakes                   " Colours

filetype on                         " Filetype detection
filetype plugin on
filetype indent on

set number                          " These are obvious
syntax on
set cursorline
set tabstop=2
set expandtab
set nowrap

set laststatus=2                    " Show statusline

set autoread                        " Load changes to file by external sources
set showmatch                       " Highlight matching bracket
set ignorecase                      " ignore + smart case makes case sensitivity matching smart
set smartcase

set hlsearch                                        " Highlight search matches
set incsearch                                       " Start searching immediately
" Cancel search with escape
" nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

set ai                              " Auto and smart indenting
set si

"set colorcolumn=72                  " Highlight the column to help with writing POD

set hidden                          " Something something buffers?
set history=500                     " Command history

set backspace=indent,eol,start      " Fix backspace
set wildmenu                        " Make command autocomplete work like shell
set wildmode=full                   " Allow tab completion for buffers

let g:bufferline_echo = 0           " Stop bufferline repeating below airline
                                    " For some reason this must be in .vimrc

autocmd BufWritePre * :%s/\s\+$//e                                      " Auto clean up trailing whitespace on save
autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript    " JSON handling


" set modeline
" set modelines=4

" set mouse=a
" set noerrorbells
" set nostartofline
" set ruler
" set showmode
" set title
" set showcmd
" set scrolloff=5
