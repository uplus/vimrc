" Terminal Helper:
" vim: foldlevel=0

function! my#terminal#new(...) abort "{{{
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

  " 挿入モードになる前にfeedkeysのキューを空にする
  " 一部のプラグインが実行するfeedkeysがターミナルに入力されるのを防ぐ
  call feedkeys('', 'x')

  startinsert
endfunction "}}}

function! my#terminal#working_terminal(...) abort "{{{
  let l:cmd = get(a:, 1, '')
  let l:open_cmd = get(a:, 2, 'botright split')

  if bufexists(get(g:, 'my#terminal#working_terminal_nr', -1))
    " 既に存在するバッファを開く
    execute l:open_cmd bufname(g:my#terminal#working_terminal_nr)
  else
    call my#terminal#new(l:cmd, l:open_cmd)
    let g:my#terminal#working_terminal_nr = bufnr('%')
    au myac TermClose <buffer> unlet g:my#terminal#working_terminal_nr
  endif
endfunction "}}}
