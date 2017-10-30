"" .vimrc
""
"" Generic config here, GUI- and package-specific
"" config must go in .gvimrc

set listchars=tab:>.,trail:.,extends:#,nbsp:.

set nocompatible                    " No Vi compatibility
let mapleader=","                   " Leader key
let maplocalleader="\\"

set clipboard=unnamed               " Some sane, modern(-ish) defaults
" set esckeys
set mouse=a
set ttyfast
set gdefault
set encoding=utf-8 nobomb

set background=dark
colorscheme bubblegum-256-dark      " Colours

filetype on                         " Filetype detection
filetype plugin on
filetype indent on

"" PERFORMANCE SENSITIVE
set cursorline
set lazyredraw
"" /perf

set number                          " These are obvious
syntax on
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nowrap

set laststatus=2                    " Show statusline

set autoread                        " Load changes to file by external sources
set showmatch                       " Highlight matching bracket
set ignorecase                      " ignore + smart case makes case sensitivity matching smart
set smartcase

set tags=./tags,/Users/cdaniel/.tags

" set foldmethod=syntax
" set foldlevelstart=1

" let javascript_fold=1
" let javaScript_fold=1

set hlsearch                                        " Highlight search matches
set incsearch                                       " Start searching immediately
" Cancel search with escape
" nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

set ai                              " Auto and smart indenting
set si

" set colorcolumn=72                  " Highlight the column to help with writing POD

set hidden                          " Something something buffers?
set history=500                     " Command history

set backspace=indent,eol,start      " Fix backspace
set wildmenu                        " Make command autocomplete work like shell
set wildmode=full                   " Allow tab completion for buffers

autocmd BufWritePre * :%s/\s\+$//e                                      " Auto clean up trailing whitespace on save
autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript    " JSON handling


"""""""""""""""""""""""
"" netrw config
"""""""""""""""""""""""
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20


"""""""""""""""""""""""
"" BINDINGS
"""""""""""""""""""""""

nnoremap <silent> <leader>p :bp<cr>
nnoremap <silent> <leader>n :bn<cr>

noremap <leader>q q
noremap q <Nop>

noremap ; :Buffers<CR>
noremap <C-p> :Files<CR>

nnoremap <leader>tb :TagbarToggle<CR>
nnoremap <leader>ls :Vexplore<CR>

" Autocomplete HTML tags
iabbrev </ </<C-X><C-O>

" Debug - show highlight group under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"""""""""""""""""""""""
"" FILETYPES
"""""""""""""""""""""""
autocmd FileType markdown set wrap linebreak

"""""""""""""""""""""""
"" PLUGINS
"""""""""""""""""""""""

"" AIRLINE
let g:bufferline_echo = 0           " Stop bufferline repeating below airline
                                    " For some reason this must be in .vimrc

let g:airline#extensions#tabline#enabled = 1                                " Buffer list at top of window
let g:airline_theme='bubblegum'                                            " Colours similar to VIM theme
"let g:airline#extensions#tabline#left_alt_sep = '|'                         " No powerline chars
let g:airline_powerline_fonts = 1


if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

"" GITGUTTER
let g:gitgutter_sign_added = '•'
let g:gitgutter_sign_modified = '•'
let g:gitgutter_sign_removed = '•'
let g:gitgutter_sign_removed_first_line = '•'
let g:gitgutter_sign_modified_removed = '•'

"" AUTOTAGS
let g:autotagTagsFile = ".tags"
let g:autotagVerbosityLevel = 'DEBUG'

if has('nvim')
  let g:python3_host_prog = 'python3'
endif

"" TERN
" let g:deoplete#sources#ternjs#tern_bin = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/ternjs/node_modules/.bin/tern'
let g:deoplete#sources#ternjs#tern_bin = $HOME . '/.local/ternjs/node_modules/tern/bin/tern'
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#enable_at_startup = 1

"" ALE
let g:airline#extensions#ale#enabled = 1

let g:ale_lint_delay = 800
let g:ale_sign_error = '⋙'
let g:ale_sign_warning = '⋙'
let g:ale_sign_info = '⋙'

let g:ale_perl_perl_options = '-c -Mwarnings -Ilib -Ilocal/lib/perl5'
let g:ale_perl_perlcritic_showrules = 1

" show P::C violations as warnings, not errors
let g:ale_type_map = {'perlcritic': {'ES': 'WS', 'E': 'W'},}

hi link ALEErrorSign GitGutterDelete
hi link ALEWarningSign GitGutterChange
hi link ALEInfoSign GitGutterAdd

"" GITSESSIONS
let g:gitsessions_dir = $HOME . '/.local/share/nvim/sessions/'
let g:gitsessions_use_cache = 0

