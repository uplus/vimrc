" Command Line Mode Helper:

let s:wordchars = '[[:upper:][:lower:][:digit:]]'

" <c-k> 末尾まで削除
function! my#cmdline#delete_to_end()
  return s:delete_to(strchars(getcmdline(), 1), vimrc#getcmdpos())
endfunction

" <m-f>
function! my#cmdline#forward_word()
  let col = vimrc#getcmdpos()
  return " \b" . s:move_to(s:next_word(col), col)
endfunction

" <m-b>
function! my#cmdline#back_word()
  let col = vimrc#getcmdpos()
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
  " setcmdpos
  if a:y < a:x
    return repeat("\<right>", a:x - a:y)
  else
    return repeat("\<left>", a:y - a:x)
  endif
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

  return x
endfunction

" function! my#cmdline#rubout_word()
"   let x = s:getcur()
"   return s:delete_to(s:prev_word(x), x)
" endfunction

" " get mapping to rubout space delimited word behind of cursor
" function! s:rubout_longword()
"   let x = s:getcur()
"   return s:delete_to(s:prev_longword(x), x)
" endfunction
"
" " Get start position of previous space delimited word.  Argument x is the
" " position to search from.
" function! s:prev_longword(x)
"   let s = getcmdline()
"   let x = a:x
"   while x > 0 && strcharpart(s, x - 1, 1) !~# '\S'
"     let x -= 1
"   endwhile
"   while x > 0 && strcharpart(s, x - 1, 1) =~# '\S'
"     let x -= 1
"   endwhile
"   return x
" endfunction
