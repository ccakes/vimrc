"" .gvimrc
""
"" GUI and package config here

set background=dark
colorscheme cakes

set guifont=Hack:h12
set tabstop=2
set expandtab

set lines=55 columns=135

set omnifunc=syntaxcomplete#Complete                      " Default select first item

let g:airline#extensions#tabline#enabled = 0                                " Buffer list at top of window
let g:airline_theme='papercolor'                                            " Colours similar to VIM theme
let g:airline#extensions#tabline#left_alt_sep = '|'                         " No powerline chars
let g:airline_section_b = airline#section#create_left(['branch', 'hunks'])  " Reverse default order for section B

let g:gitgutter_sign_column_always = 1                    " Always show the gutter

" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site|local)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}
