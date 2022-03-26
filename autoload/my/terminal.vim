" Terminal Helper:
" vim: foldlevel=0

function! my#terminal#new(cmd, open_cmd) abort "{{{
  execute a:open_cmd '+terminal\' a:cmd

  setl filetype= nobuflisted bufhidden=hide undolevels=-1
  call my#option#set_minimal_window()

  tnoremap <esc> <c-\><c-n><c-w>c
  nnoremap <buffer>q <c-w>c
endfunction "}}}

function! my#terminal#working_terminal(...) abort "{{{
  " arg1: command string
  " arg2: open command

  let l:cmd = a:0 == 0 ? $SHELL : $SHELL . ' -ic ' . a:1
  let l:cmd = substitute(l:cmd, ' ', '\\ ', 'g')

  let l:open_cmd = get(a:, 2, 'botright split')

  if bufexists(get(g:, 'my#terminal#working_terminal_nr', -1))
    " 既に存在するバッファを開く
    " bufnameを使うとnobuflistedが外れるので注意
    execute printf('%s +%dbuffer', l:open_cmd, g:my#terminal#working_terminal_nr)
  else
    call my#terminal#new(l:cmd, l:open_cmd)
    let g:my#terminal#working_terminal_nr = bufnr('%')
    au myac TermClose <buffer> unlet g:my#terminal#working_terminal_nr
  endif
endfunction "}}}
