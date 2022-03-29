" Command Line Mode Helper:
" vim: foldlevel=0

let s:wordchars = '[[:upper:][:lower:][:digit:]]'

" <c-k> 末尾まで削除
function! my#cmdline#delete_to_end()
  return s:delete_to(strchars(getcmdline(), 1), u#getcmdpos())
endfunction

" <m-w> 次の単語の直前まで削除
function! my#cmdline#delete_to_next_word()
  let col = u#getcmdpos()
  return s:delete_to(s:next_word(col) - 1, col)
endfunction

" <m-f>
function! my#cmdline#move_to_next_word()
  let col = u#getcmdpos()
  return " \b" . s:move_to(s:next_word(col), col)
endfunction

" <m-b>
function! my#cmdline#move_to_prev_word()
  let col = u#getcmdpos()
  return " \b" . s:move_to(s:prev_word(col), col)
endfunction

function! s:delete_to(x, y)
  if a:y == a:x
    return ''
  elseif a:y < a:x
    return repeat("\<del>", a:x - a:y)
  else
    return repeat("\b", a:y - a:x)
  endif
endfunction

function! s:move_to(x, y)
  if a:y < a:x
    return repeat("\<right>", a:x - a:y)
  else
    return repeat("\<left>", a:y - a:x)
  endif
endfunction

function! s:next_word(x)
  let s = getcmdline()
  let n = strchars(s, 1)
  let x = a:x

  while x < n && strcharpart(s, x, 1) !~# s:wordchars
    let x += 1
  endwhile

  while x < n && strcharpart(s, x, 1) =~# s:wordchars
    let x += 1
  endwhile

  return x + 1
endfunction

function! s:prev_word(x)
  let s = getcmdline()
  let x = a:x

  while x > 0 && strcharpart(s, x - 1, 1) !~# s:wordchars
    let x -= 1
  endwhile

  while x > 0 && strcharpart(s, x - 1, 1) =~# s:wordchars
    let x -= 1
  endwhile

  return x
endfunction
