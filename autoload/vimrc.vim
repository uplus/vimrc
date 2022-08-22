" Helpers:
" vim: foldlevel=0

function! vimrc#filename() abort "{{{
  return expand('%:t:r')
endfunction "}}}

function! vimrc#filename_mixedcase() abort "{{{
  return g:Abolish['mixedcase'](vimrc#filename())
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

function! vimrc#is_floating_win(win_handle) abort "{{{
  return nvim_win_get_config(a:win_handle)['relative'] !=# ''
endfunction "}}}

" 指定したファイルタイプのフローティングウィンドウを閉じる
" TODO: 不要になったらしい？
function! vimrc#close_floating_win(filetype_pattern) abort "{{{
  let floating_windows = filter(nvim_list_wins(), 'vimrc#is_floating_win(v:val)')
  let close_windows = filter(floating_windows, "getbufvar(nvim_win_get_buf(v:val), '&filetype') =~# a:filetype_pattern")
  call map(close_windows, 'nvim_win_close(v:val, v:false)')
endfunction "}}}

function! vimrc#pwgen() abort "{{{
  return u#delete_pat(system('pwgen -1 -B -s -n 20'), "\n$")
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
  call my#option#set_minimal_window()
  call my#option#set_scrach_buffer()
  setl undolevels=-1 modifiable

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

function! vimrc#lsp_execute_command(command, arguments) abort
  echo luaeval('vim.lsp.buf_request(0, "workspace/executeCommand", { command = _A[1], arguments = _A[2] })', [a:command, a:arguments])
endfunction
