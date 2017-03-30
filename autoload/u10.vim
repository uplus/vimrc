let s:V = vital#of('vital')
let s:Vuri = s:V.import('Web.URI')

" gf create new file
function! u10#gf_ask()
  let path = expand('<cfile>')
  if !filereadable(path)
    echo path
    echo 'Create it?(y/N)'
    if nr2char(getchar()) !=? 'y'
      return 0
    end
  endif
  return {'path': path, 'line': 0, 'col': 0,}
endfunction

function! u10#add_repo() abort
  let str = @+
  try
    let uri = s:Vuri.new(str)
    call append(line('.'), '')
    call append(line('.'), printf("repo = '%s'", join(split(uri.path(), '/')[:1], '/')))
    call append(line('.'), '[[plugins]]')
    normal! jjj
  catch 'vital'
    echo str
    echo 'This string is not uri'
  endtry
endfunction
