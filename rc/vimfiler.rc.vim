" #vimfiler
" https://github.com/Shougo/vimfiler.vim/blob/master/doc/vimfiler.txt
let g:vimfiler_as_default_explorer = 1
" let g:vimfiler_safe_mode_by_default = 0
" let g:vimfiler_edit_action = 'edit'

" -no-quit ファイルを開いても終了しない カレントバッファと入れ替える
" command! Vf VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit
command! Vfe VimFiler -split -simple -find -winwidth=26 -no-quit
command! Vfs VimFiler -split -simple
command! Vfn VimFiler
command! Vf Vfe

"VimFilerを起動してからじゃないと関数が読み込まれない
function! s:set_vimfiler_unexpand_tree() "{{{
  if hasmapto("<Plug>(vimfiler_unexpand_tree)")
    return
  endif

  " 名前を取得
  Capture function /\d+*_unexpand_tree\(\)$
  let l:func_name = substitute(g:capture, '^function ', '', '')

  if empty(l:func_name)
    return
  endif

  execute 'nnoremap <buffer><silent> <Plug>(vimfiler_unexpand_tree) :<C-u>call' l:func_name '<CR>'
endfunction "}}}

au FileType vimfiler call s:vimfiler_settings()
function! s:vimfiler_settings() "{{{
  setlocal nobuflisted
  call s:set_vimfiler_unexpand_tree()

  nmap <silent><buffer>h <Plug>(vimfiler_unexpand_tree)
  nmap <silent><buffer>l <Plug>(vimfiler_expand_tree)
  nmap <silent><buffer><CR> <Plug>(vimfiler_cd_or_edit)
  " nmap <silent><buffer><CR> <Plug>(vimfiler_expand_or_edit)

  " vimfilerのsplitは水平じゃなくて垂直 時々VimFilerWindがリサイズされる
  " nmap <buffer>v <Plug>(vimfiler_split_edit_file)
  nnoremap <buffer>s :call vimfiler#mappings#do_action('my_split')<CR>
  nnoremap <buffer>v :call vimfiler#mappings#do_action('my_vsplit')<CR>

  nnoremap <buffer><Tab> :call vimfiler#mappings#do_action('tabopen')<CR>
  nnoremap <buffer>\ \
  nmap <buffer>- <Plug>(vimfiler_switch_to_root_directory)

  " 最後のバッファでも終了
  " nnoremap <buffer><nowait>q :quit<CR>
endfunction "}}}

let s:my_action = { 'is_selectable' : 1 }
function! s:my_action.func(candidates)
  wincmd p
  exec 'split '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_split', s:my_action)

let s:my_action = { 'is_selectable' : 1 }
function! s:my_action.func(candidates)
  wincmd p
  exec 'vsplit '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_vsplit', s:my_action)

