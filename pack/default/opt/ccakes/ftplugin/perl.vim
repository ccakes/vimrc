if exists('g:loaded_ccakes')
  finish
endif
let g:loaded_ccakes = 1

function! s:is_carton_project(current_dir)
  if a:current_dir ==# '/'
    return 0
  endif

  if glob(a:current_dir . 'cpanfile.snapshot') !=# ''
    return 1
  endif

  return s:is_carton_project(simplify(a:current_dir.'/../'))  " go up directory
endfunction

let s:cmd_perl = 'perl'
let s:cmd_perldoc = 'perldoc'
let s:cmd_prove = 'prove'

let s:current_file_dir = expand("%:p:h")
let s:carton = s:is_carton_project(s:current_file_dir . '/')

if s:carton
  let s:cmd_perl = 'carton exec -- perl'
  let s:cmd_perldoc = 'carton exec -- perldoc'
  let s:cmd_prove = 'carton exec -- prove'
endif

fun! s:RunProve()
  execute ':!' . s:cmd_prove . ' -blv %'
endfun

setlocal errorformat=%f:%l:%m
setlocal errorformat+=%m\ at\ %f\ line\ %l.
let &keywordprg=s:cmd_perldoc . '\ -T\ -f'
let &makeprg=s:cmd_perl . '\ -c\ -Iblib\ -Ilib\ %'

" : in package names
setlocal iskeyword+=:
let perl_fold=1

" perltidy bindings
nnoremap <silent> <leader>pt :%!perltidy -q<Enter>
vnoremap <silent> <leader>pt :!perltidy -q<Enter>

" perlcritic
nnoremap <silent> <leader>pc :!perlcritic %<cr>

" prove
nnoremap <leader>pp <SID>GetProve()<cr>
