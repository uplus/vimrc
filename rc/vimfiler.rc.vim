" #vimfiler
" https://github.com/Shougo/vimfiler.vim/blob/master/doc/vimfiler.txt

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_enable_clipboard = 0
let g:vimfiler_readonly_file_icon = '✗'
let g:vimfiler_marked_file_icon = '✓'
let g:vimfiler_quick_look_command = 'xdg-open'

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


au u10ac FileType vimfiler call s:vimfiler_settings()
function! s:vimfiler_settings() "{{{
  setlocal nobuflisted

  nmap <buffer><CR> <Plug>(vimfiler_cd_or_edit)

  nmap <buffer>h <Plug>(vimfiler_expand_tree)
  nmap <buffer>l <Plug>(vimfiler_expand_tree)
  nmap <buffer><C-h> <Plug>(vimfiler_switch_to_parent_directory)
  nmap <buffer><C-l> <Plug>(vimfiler_cd_file)

  nmap <buffer>b <Plug>(vimfiler_close)
  nnoremap <buffer>q :call <SID>smart_quit()<CR>

  " vimfilerのsplitは開いた時のoptに影響する
  nnoremap <silent><buffer><expr><nowait>s vimfiler#do_action('split_action')
  nnoremap <silent><buffer><expr><nowait>v vimfiler#do_action('vsplit_action')
  nnoremap <silent><buffer><expr><nowait>t vimfiler#do_action('tabopen')
  " nmap <buffer>e <Plug>(vimfiler_edit_file)
  " TODO lazyredrawすればちらつかない
  " commitiaみたいなスクロールマッピングがしたい
  nmap <buffer>e <Plug>(vimfiler_edit_file)<c-w>p

  nmap <buffer>R <Plug>(vimfiler_expand_tree_recursive)
  nmap <buffer>I <Plug>(vimfiler_set_current_mask)
  nmap <buffer>M <Plug>(vimfiler_cd_input_directory)

  nnoremap <buffer>\ \
  nmap <buffer>- <Plug>(vimfiler_switch_to_root_directory)
  nmap ? <Plug>(vimfiler_help)
endfunction "}}}

function! s:smart_quit()
  if argc() == 0 || isdirectory(argv(0)) || u10#buffer_count('l') == 0
    quit
  else
    call vimfiler#util#hide_buffer()
  endif
endfunction

let s:split_action = { 'is_selectable' : 1 }
function! s:split_action.func(candidates)
  wincmd p
  exec 'rightbelow split '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'split_action', s:split_action)

let s:vsplit_action = { 'is_selectable' : 1 }
function! s:vsplit_action.func(candidates)
  wincmd p
  exec 'vsplit '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'vsplit_action', s:vsplit_action)

