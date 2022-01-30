" vim: foldlevel=0

function! my#note#open(name) abort "{{{
  let l:name = system(['note', '-S', a:name])[0:-2]
  if name ==# ''
    echo printf('%s not found', a:name)
  endif

  exec 'tabedit' l:name
endfunction "}}}

function! my#note#config() abort "{{{
  " defxがバグる
  " silent! lcd %:h
  " au myac BufReadPost * ++once silent! lcd %:h

  if vimrc#capture('verbose setl ft?') !~# 'modeline'
    setf markdown
    setl foldlevel=0
  endif
endfunction "}}}

function! my#note#file_completion(lead, line, pos) abort "{{{
  let l:name = a:lead
  let l:files = split(system(['note', '--list']))

  if l:name ==# ''
    return l:files
  endif

  " match filter
  let l:files = filter(files, 'v:val =~ l:name')
  let l:head_matched = filter(copy(files), 'v:val =~# "^" . l:name')
  if 0 != len(l:head_matched)
    let l:files = l:head_matched
  endif

  if 1 < len(l:files)
    return l:files
  endif

  let l:name = files[0]
  if l:name =~# '/$'
    let l:files = split(system(['note', '--list', l:name]))
    call map(l:files, 'l:name . v:val')
  endif

  return l:files
endfunction "}}}
