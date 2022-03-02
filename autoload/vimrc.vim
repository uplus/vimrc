" Helpers:
" vim: foldlevel=0

" マルチバイト対応のgetcmdpos
function! vimrc#getcmdpos() "{{{
  let str = (getcmdline() . ' ')[:getcmdpos() - 1]
  return strchars(str, 1) - 1
endfunction "}}}

function! vimrc#filename() abort "{{{
  return expand('%:t:r')
endfunction "}}}

function! vimrc#filename_mixedcase() abort "{{{
  return g:Abolish['mixedcase'](vimrc#filename())
endfunction "}}}

" 文字列から特定の文字を削除する
function! vimrc#delete_chars(str, chars) abort "{{{
  return substitute(a:str, '[' . a:chars . ']', '', 'g')
endfunction "}}}

function! vimrc#delete_pat(str, pattern, ...) abort "{{{
  return substitute(a:str, a:pattern, '', get(a:000, 0, ''))
endfunction "}}}

" filetypeに依存せずiskeyword固定でcwordを取得する
function vimrc#get_cword() abort "{{{
  let save_iskeyword = &l:iskeyword
  setl iskeyword=@
  try
    return expand('<cword>')
  finally
    let &l:iskeyword = save_iskeyword
  endtry
endfunction "}}}

" cursolがlastlineにあるかどうか
function! vimrc#is_lastline(is_visual) abort "{{{
  let last = line('$')
  return line('.') == last || foldclosedend(line('.')) == last || (a:is_visual && line("'>") == last)
endfunction "}}}

function! vimrc#is_writable_buf() abort "{{{
  return &modifiable && (&buftype ==# '' || &buftype ==# 'acwrite')
endfunction "}}}

function! vimrc#is_file(path) abort "{{{
  return !isdirectory(a:path) && glob(a:path) !=# ''
endfunction "}}}

function! vimrc#is_include(list, value) abort "{{{
  return index(a:list, a:value) != -1
endfunction "}}}

function vimrc#home2tilde(str) abort "{{{
  return substitute(a:str, '^' . expand('~'), '~', '')
endfunction "}}}

function! vimrc#add_slash_tail(str) abort "{{{
  return substitute(a:str, '/*$', '/', '')
endfunction "}}}

function vimrc#expand_dir_alias(str) abort "{{{
    let path = system(printf("zsh -ic 'echo -n %s'", a:str))
    return vimrc#home2tilde(path)
endfunction "}}}

function vimrc#remove_opt_val(optname, chars) abort "{{{
  for c in  split(a:chars, '.\zs')
    execute printf('setl %s-=%s', a:optname, c)
  endfor
endfunction "}}}

" fold関数
function! vimrc#fold(list, expr) abort "{{{
  if type(a:expr) ==# v:t_string
    let Func = {memo, v -> eval(printf("%s %s %s", memo, a:expr, v))}
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

function! vimrc#capture(cmd_str) abort "{{{
  redir => g:capture
  silent execute a:cmd_str
  redir END
  return substitute(g:capture, '\%^\n', '', '')
endfunction "}}}

function! vimrc#capture_win(cmd) abort "{{{
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

function! vimrc#is_floating_win(bufnr) abort "{{{
  return nvim_win_get_config(a:bufnr)['relative'] !=# ''
endfunction "}}}

" 指定したファイルタイプのフローティングウィンドウを閉じる
function! vimrc#close_floating_win(filetype_pattern) abort "{{{
  let floating_windows = filter(nvim_list_wins(), 'vimrc#is_floating_win(v:val)')
  let close_windows = filter(floating_windows, "getbufvar(nvim_win_get_buf(v:val), '&filetype') =~# a:filetype_pattern")
  call map(close_windows, 'nvim_win_close(v:val, v:false)')
endfunction "}}}

" ----

function! vimrc#goldendict(...) abort "{{{
  let word = a:0? a:1 : vimrc#get_cword()
  call jobstart(['goldendict', word], {'detach': 1})
endfunction "}}}

function! vimrc#pwgen() abort "{{{
  return vimrc#delete_pat(system('pwgen -1 -B -s -n 20'), "\n$")
endfunction "}}}

function! vimrc#open_git_diff(type) abort "{{{
  silent! update
  let s:prev_winnr = winnr()
  let cmdname = 'git diff ' .  expand('%:t')
  let filedir = expand('%:h')

  if exists('s:git_diff_bufnr')
    silent! execute 'bwipeout' s:git_diff_bufnr
  endif

  execute 'silent!' ((a:type ==# 't')? 'tabnew' : printf('botright vsplit git-diff-%s', escape(cmdname, ' ')))
  let s:git_diff_bufnr = bufnr('%')

  " diff_config()で設定しようとするとnofileのタイミングが遅い
  setl buftype=nofile
  setl bufhidden=wipe
  setl nobuflisted
  setl noswapfile
  setl undolevels=-1
  setl nonumber
  setl nofoldenable
  setl foldcolumn=0
  setl modifiable

  " ファイルタイプをセットするとのが早いとバグる
  setfiletype diff

  execute 'lcd' filedir
  silent put! =system(cmdname)
  $delete
  nnoremap <silent><buffer>q :call <sid>bwipeout_and_back()<cr>

  function! s:bwipeout_and_back()
    bwipeout!
    execute 'normal!' s:prev_winnr ."\<C-w>w"
  endfunction

  wincmd p
endfunction "}}}

function! vimrc#undo_clear() abort "{{{
  let old = &undolevels
  set undolevels=-1
  exe "normal a \<BS>\<Esc>"
  let &undolevels = old
  write
endfunction "}}}

function! vimrc#git_top() abort "{{{
  return system('git rev-parse --show-toplevel')
endfunction "}}}
