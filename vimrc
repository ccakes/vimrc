"" .vimrc
""
"" Generic config here, GUI- and package-specific
"" config must go in .gvimrc

set nocompatible                    " No Vi compatibility
let mapleader=","                   " Leader key
let maplocalleader="\\"

set clipboard=unnamed               " Some sane, modern(-ish) defaults
" set esckeys
set ttyfast
set gdefault
set encoding=utf-8 nobomb

set background=dark
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

set tags=./tags,/Users/cdaniel/.tags

set foldmethod=syntax
set foldlevelstart=1

"let g:perl_fold=1
let perl_fold=1
let javascript_fold=1
let javaScript_fold=1

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

set omnifunc=syntaxcomplete#Complete                      " Default select first item

let g:airline#extensions#tabline#enabled = 1                                " Buffer list at top of window
let g:airline_theme='papercolor'                                            " Colours similar to VIM theme
"let g:airline#extensions#tabline#left_alt_sep = '|'                         " No powerline chars
let g:airline_powerline_fonts = 1

let g:gitgutter_sign_column_always = 1                    " Always show the gutter

" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site|local)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

let g:perldoc_split_modifier = 'v'
let g:perldoc_split_position = 'rightbelow'

let g:autotagTagsFile = ".tags"
let g:autotagVerbosityLevel = 'DEBUG'

let g:deoplete#enable_at_startup = 1

if has('nvim')
  let g:python3_host_prog = '/Users/cdaniel/.pyenv/shims/python'
endif

nnoremap <silent> <leader>p :bp<cr>
nnoremap <silent> <leader>n :bn<cr>

noremap <leader>q q
noremap q <Nop>

" vimwiki config
let g:vimwiki_list = [{'path':'~/Library/Mobile\ Documents/com\~apple\~CloudDocs/vimwiki/', 'path_html':'~/Desktop/vimwiki/'}]

" Autocomplete HTML tags
iabbrev </ </<C-X><C-O>

" set modeline
" set modelines=4

set mouse=a
" set noerrorbells
" set nostartofline
" set ruler
" set showmode
" set title
" set showcmd
" set scrolloff=5
