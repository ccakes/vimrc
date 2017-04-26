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

" command! -nargs=* CDroot call s:find_root_directory(current_file_dir . '/')

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

set errorformat=%f:%l:%m
let &keywordprg=s:cmd_perldoc . '\ -T\ -f'    " let K call perldoc instead of man
let &makeprg=s:cmd_perl . '\ -c\ %'

set iskeyword+=:                              " : in package names

" perltidy bindings
nnoremap <silent> <leader>t :%!perltidy -q<Enter>
vnoremap <silent> <leader>t :!perltidy -q<Enter>
