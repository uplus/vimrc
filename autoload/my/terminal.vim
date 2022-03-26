" Terminal Helper:
" vim: foldlevel=0

function! my#terminal#new(cmd) abort "{{{
  execute 'terminal' a:cmd

  setl filetype= nobuflisted bufhidden=hide undolevels=-1
  call my#option#set_minimal_window()

  tnoremap <esc> <c-\><c-n><c-w>c
  nnoremap <buffer>q <c-w>c
endfunction "}}}

function! my#terminal#working_terminal(...) abort "{{{
  " arg1: command string

  let l:cmd = a:0 == 0 ? $SHELL : $SHELL . ' -ic ' . shellescape(a:1)

  if bufexists(get(g:, 'my#terminal#working_terminal_nr', -1))
    " 既存
    call my#terminal#float(g:my#terminal#working_terminal_nr, 0.4, 0.6)
  else
    " 新規
    call my#terminal#float(bufnr('%'), 0.4, 0.6)
    call my#terminal#new(l:cmd)

    let g:my#terminal#working_terminal_nr = bufnr('%')
    au myac TermClose <buffer> unlet g:my#terminal#working_terminal_nr
  endif
endfunction "}}}

function! my#terminal#float(bufnr, height_percent, width_percent) abort "{{{
  let denite_win_width = &columns * a:width_percent
  let denite_win_col_pos = (&columns - denite_win_width) / 2
  let denite_win_height = &lines * a:height_percent
  let denite_win_height = 60 < denite_win_height ? 60 : denite_win_height
  let denite_win_row_pos = (&lines - denite_win_height) / 2

  call nvim_open_win(a:bufnr, v:true, {
    \ 'relative': 'editor',
    \ 'col':    float2nr(denite_win_col_pos),
    \ 'row':    float2nr(denite_win_row_pos),
    \ 'width':  float2nr(denite_win_width),
    \ 'height': float2nr(denite_win_height),
    \ 'border': 'single',
    \ })
endfunction "}}}
