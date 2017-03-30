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
