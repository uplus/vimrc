function! my#buffer#count(...) abort "{{{
  if a:0 == 0
    let cmd = 'ls!'
  elseif a:1 ==# 'a'   " active
    let cmd = 'ls! a'
  elseif a:1 ==# 'l'   " listed
    let cmd = 'ls'
  else
    let cmd = 'ls!'
  endif

  return len(split(vimrc#capture(cmd), "\n"))
endfunction "}}}

" return list [bufnr, status, name]
function! my#buffer#info(...) abort "{{{
  return map(split(vimrc#capture('ls' . (a:0? a:1 : '!')), '\n'),
        \ 'matchlist(v:val, ''\v^\s*(\d*)\s*(.....)\s*"(.*)"\s*.*\s(\d*)$'')[1:4]')
endfunction "}}}

function! my#buffer#current_only() abort "{{{
  let l:old = &report
  set report=1000
  let l:count=0

  for l:buf in my#buffer#info()
    if -1 == stridx(l:buf[1], '%')
      execute 'bwipeout' l:buf[0]
      let l:count+=1
    endif
  endfor

  echo l:count 'buffer deleted'
  let &report=l:old
endfunction "}}}

function! my#buffer#active_only() abort "{{{
  let l:old = &report
  set report=1000
  let l:count=0

  for l:buf in my#buffer#info()
    if -1 == stridx(l:buf[1], 'a') && l:buf[2] !~# '^term'
      execute 'bwipeout' l:buf[0]
      let l:count+=1
    endif
  endfor

  echo l:count 'buffer deleted'
  let &report=l:old
endfunction "}}}

function! my#buffer#delete_trash_buffers() abort "{{{
  let l:count=0

  for l:buf in my#buffer#info(' u')
    if -1 == stridx(l:buf[1], 'a') && -1 == stridx(l:buf[1], 'h')
      silent execute 'bwipeout' l:buf[0]
      let l:count+=1
    endif
  endfor

  if l:count != 0
    echo l:count 'buffer deleted'
  endif
endfunction "}}}


