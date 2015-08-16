" #vimfiler
" https://github.com/Shougo/vimfiler.vim/blob/master/doc/vimfiler.txt

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_enable_clipboard = 0
let g:vimfiler_readonly_file_icon = '✗'
let g:vimfiler_marked_file_icon = '✓'
let g:vimfiler_quick_look_command = IsMac() ? 'qlmanage -p' : 'gloobus-preview'

call vimfiler#custom#profile('default', 'context', {
      \ 'safe' : 0,
      \ 'auto_expand' : 1,
      \ 'parent' : 0,
      \ })

let g:vimfiler_sendto = {
      \ 'unzip' : 'unzip %f',
      \ 'zip' : 'zip -r %F.zip %*',
      \ 'Inkscape' : 'inkspace',
      \ 'GIMP' : 'gimp %*',
      \ 'gedit' : 'gedit',
      \ }

"VimFilerを起動してからじゃないと関数が読み込まれない
function! s:set_vimfiler_unexpand_tree() "{{{
  if hasmapto("<Plug>(vimfiler_unexpand_tree)") | return | endif

  " 名前を取得
  Capture function /\d+*_unexpand_tree\(\)$
  let l:func_name = substitute(g:capture, '^function ', '', '')

  if empty(l:func_name) | return | endif

  execute 'nnoremap <buffer><silent> <Plug>(vimfiler_unexpand_tree) :<C-u>call' l:func_name '<CR>'
endfunction "}}}

au FileType vimfiler call s:vimfiler_settings()
function! s:vimfiler_settings() "{{{
  setlocal nobuflisted
  call s:set_vimfiler_unexpand_tree()

  nmap <buffer><CR> <Plug>(vimfiler_cd_or_edit)

  nmap <buffer>h <Plug>(vimfiler_unexpand_tree)
  nmap <buffer>l <Plug>(vimfiler_expand_tree)
  nmap <buffer><C-h> <Plug>(vimfiler_switch_to_parent_directory)
  nmap <buffer><C-l> <Plug>(vimfiler_cd_file)

  nmap <buffer>b <Plug>(vimfiler_close)
  nnoremap <buffer>q :call <SID>smart_quit()<CR>

  " vimfilerのsplitは開いた時のoptに影響する
  nnoremap <silent><buffer><nowait>s :call vimfiler#mappings#do_action('split_action')<CR>
  nnoremap <silent><buffer><nowait>v :call vimfiler#mappings#do_action('vsplit_action')<CR>
  nnoremap <silent><buffer><expr>t vimfiler#do_action('tabopen')
  nmap <buffer>e <Plug>(vimfiler_edit_file)

  nmap <buffer>R <Plug>(vimfiler_expand_tree_recursive)
  nmap <buffer>I <Plug>(vimfiler_set_current_mask)
  nmap <buffer>M <Plug>(vimfiler_cd_input_directory)

  nnoremap <buffer>\ \
  nmap <buffer>- <Plug>(vimfiler_switch_to_root_directory)

endfunction "}}}

function! s:smart_quit()
  if argc() == 0 || isdirectory(argv(0))
    quit
  else
    call vimfiler#util#hide_buffer()
  endif
endfunction

let s:split_action = { 'is_selectable' : 1 }
function! s:split_action.func(candidates)
  wincmd p
  exec 'botright split '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'split_action', s:split_action)

let s:vsplit_action = { 'is_selectable' : 1 }
function! s:vsplit_action.func(candidates)
  wincmd p
  exec 'vsplit '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'vsplit_action', s:vsplit_action)

