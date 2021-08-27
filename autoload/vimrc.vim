" TODO Vitalizeする?

" -- helpers

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

function! vimrc#is_file(path) abort "{{{
  return !isdirectory(a:path) && glob(a:path) !=# ''
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

" ---- terminal helper

function! vimrc#terminal(...) abort "{{{
  " arg1: command string
  " arg2: open command

  " arg1
  let l:cmd = empty(a:1) ? $SHELL : $SHELL . ' -ic ' . a:1
  let l:cmd = substitute(l:cmd, ' ', '\\ ', 'g')

  " arg2
  let l:open_cmd = get(a:, 2, 'botright split')

  execute l:open_cmd '+terminal\' l:cmd
  silent setl ft= nobuflisted bufhidden undolevels=-1 nofoldenable nonumber foldcolumn=0 signcolumn=no

  silent tnoremap <esc> <c-\><c-n><c-w>c
  silent nnoremap <buffer>q <c-w>c
  startinsert
endfunction "}}}

function! vimrc#working_terminal(...) abort "{{{
  let l:cmd = get(a:, 1, '')
  let l:open_cmd = get(a:, 2, 'botright split')

  if bufexists(get(g:, 'vimrc#working_terminal_nr', -1))
    " 既に存在するバッファを開く
    exec l:open_cmd bufname(g:vimrc#working_terminal_nr)
  else
    call vimrc#terminal(l:cmd, l:open_cmd)
    let g:vimrc#working_terminal_nr = bufnr('%')
    au myac TermClose <buffer> unlet g:vimrc#working_terminal_nr
  endif
endfunction "}}}

" ----

function! vimrc#goldendict(...) abort "{{{
  let word = a:0? a:1 : vimrc#get_cword()
  call jobstart(['goldendict', word], {'detach': 1})
endfunction "}}}

function! vimrc#pwgen() "{{{
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
  setl modifiable
  setl undolevels=-1
  setl nofoldenable
  setl nonumber
  setl foldcolumn=0

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

function! vimrc#zsh_file_completion(lead, line, pos) abort "{{{
  if a:lead ==# '#'
    return map(my#buffer#info(''), 'v:val[2]')
  elseif a:lead ==# ''
    let query = ''
  elseif a:lead =~# '\v^\~[^/]+'
    echo 'zsh file completion'
    " Slow
    let parts = split(a:lead, '/')
    let parts[0] = vimrc#expand_dir_alias(parts[0])
    if v:shell_error
      return []
    endif
    let query = join(parts, '/')
  elseif stridx(a:lead, '/') != -1
    let query = a:lead
  else
    let pre_glob = glob('*' . a:lead . '*', 1, 1)
    if len(pre_glob) == 1 && isdirectory(pre_glob[0])
      let query = vimrc#add_slash_tail(pre_glob[0])
    else
      let query = '*' . a:lead
    endif
  endif

  let cands = []
  for path in glob(query . '*', 1, 1)
    if isdirectory(path)
      let path  .= '/'
    endif
    let path = vimrc#home2tilde(path)
    let cands += [path]
  endfor

  return cands
endfunction "}}}
