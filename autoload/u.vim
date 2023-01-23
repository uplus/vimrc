" Utils: utility functions
" vim: foldlevel=0

" Path:

function u#replace_home_to_tilde(str) abort "{{{
  return substitute(a:str, '^' . expand('~'), '~', '')
endfunction "}}}

function u#expand_bash_env(str) abort "{{{
  " ${HOGE:-text} → $HOGE
  let replaced = substitute(a:str, '\${\([A-Za-z_][A-Za-z0-9_]*\)\(:[-=+?][^}]*\)\?}', '$\1', 'g')
  return expand(replaced)
endfunction "}}}

function! u#add_tail_slash(str) abort "{{{
  return substitute(a:str, '/*$', '/', '')
endfunction "}}}

" File_Buffer:

function! u#is_writable_buf() abort "{{{
  return &modifiable && (&buftype ==# '' || &buftype ==# 'acwrite')
endfunction "}}}

function! u#is_file(path) abort "{{{
  return !isdirectory(a:path) && glob(a:path) !=# ''
endfunction "}}}

" String:

" 文字列から特定の文字を削除する
function! u#delete_chars(str, chars) abort "{{{
  return substitute(a:str, '[' . a:chars . ']', '', 'g')
endfunction "}}}

function! u#delete_pat(str, pattern, ...) abort "{{{
  return substitute(a:str, a:pattern, '', get(a:000, 0, ''))
endfunction "}}}

" List_Dict:

function! u#is_include(list, value) abort "{{{
  return index(a:list, a:value) != -1
endfunction "}}}

" Function:

function! u#clamp(value, min, max) abort "{{{
  if a:value < a:min
    return a:min
  elseif a:max < a:value
    return a:max
  else
    return a:value
  endif
endfunction " }}}

" fold関数
function! u#fold(list, expr) abort "{{{
  if type(a:expr) ==# v:t_string
    let Func = { memo, v -> eval(printf("%s %s %s", memo, a:expr, v)) }
  else
    let Func = a:expr
  endif

  let result = a:list[0]
  unlet a:list[0]

  for v in a:list
    let result = Func(result, v)
  endfor
  return result
endfunction "}}}

" Misc:

" マルチバイト対応のgetcmdpos
function! u#getcmdpos() "{{{
  let str = (getcmdline() . ' ')[:getcmdpos() - 1]
  return strchars(str, 1) - 1
endfunction "}}}

" cursolがlastlineにあるかどうか
function! u#is_lastline(is_visual) abort "{{{
  let last = line('$')
  return line('.') == last || foldclosedend(line('.')) == last || (a:is_visual && line("'>") == last)
endfunction "}}}

function! u#capture(cmd_str) abort "{{{
  redir => g:capture
  silent execute a:cmd_str
  redir END
  return substitute(g:capture, '\%^\n', '', '')
endfunction "}}}

function! u#capture_win(cmd) abort "{{{
  redir => result
  silent execute a:cmd
  redir END

  let bufname = 'Capture: ' . a:cmd
  new
  setlocal bufhidden=unload
  setlocal nobuflisted
  setlocal buftype=nofile
  setlocal noswapfile
  silent file `=bufname`
  silent put =result
  1,2delete _
endfunction "}}}

function! u#substitute_lines(pattern, string, flag) abort range "{{{
  let n = 1
  for line in getline(a:firstline, a:lastline)
    call setline(n, substitute(line, a:pattern, a:string, a:flag))
    let n = n + 1
  endfor
endfunction "}}}

" filetypeに依存せずiskeyword固定でcwordを取得する
function u#cword() abort "{{{
  let save_iskeyword = &l:iskeyword
  setl iskeyword=@
  try
    return expand('<cword>')
  finally
    let &l:iskeyword = save_iskeyword
  endtry
endfunction "}}}

" ${HOME:-text} などの環境変数も展開するcfile
function u#cfile_bash_env() abort "{{{
  let save_isfname = &l:isfname
  set isfname& isfname+={,}
  try
    return u#expand_bash_env(expand('<cfile>'))
  finally
    let &l:isfname = save_isfname
  endtry
endfunction "}}}
