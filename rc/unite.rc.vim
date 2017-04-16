" Unite:
let g:unite_enable_start_insert = 0
let g:unite_enable_auto_select  = 0
let g:unite_source_history_yank_enable = 1
let g:unite_enable_ignore_case  = 1
let g:unite_enable_smart_case   = 1

" grep "{{{
let g:unite_source_grep_max_candidates = 200
if executable('hw')
  " Use hw(highway)
  " https://github.com/tkengo/highway
  let g:unite_source_grep_command = 'hw'
  let g:unite_source_grep_default_opts = '--no-group --no-color'
  let g:unite_source_grep_recursive_opt = ''
elseif executable('ag')
  " Use ag(the silver searcher)
  " https://github.com/ggreer/the_silver_searcher
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
        \ '-i --vimgrep --hidden --ignore ' .
        \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
elseif executable('pt')
  " Use pt(the platinum searcher)
  " https://github.com/monochromegane/the_platinum_searcher
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
elseif executable('jvgrep')
  " For jvgrep
  " https://github.com/mattn/jvgrep
  let g:unite_source_grep_command = 'jvgrep'
  let g:unite_source_grep_default_opts = '-i --exclude ''\.(git|svn|hg|bzr)'''
  let g:unite_source_grep_recursive_opt = '-R'
endif
"}}}

" aliases "{{{
let g:unite_source_alias_aliases = {}
let g:unite_source_alias_aliases.g = {
      \ 'source' : 'grep',
      \ 'args'   : '%',
      \ }
let g:unite_source_alias_aliases.vg = {
      \ 'source' : 'grep',
      \ 'args'   : '**'
      \ }
let g:unite_source_alias_aliases.l       = 'launcher'
let g:unite_source_alias_aliases.kill    = 'process'
let g:unite_source_alias_aliases.message = {
      \ 'source' : 'output',
      \ 'args'   : 'message',
      \ }
let g:unite_source_alias_aliases.function = {
      \ 'source' : 'output',
      \ 'args'   : 'function',
      \ }
let g:unite_source_alias_aliases.scriptnames = {
      \ 'source' : 'output',
      \ 'args'   : 'scriptnames',
      \ }
let g:unite_source_alias_aliases.prefix = {
      \ 'source' : 'output',
      \ 'args'   : "map \\ |map;|map,|map s|map gs",
      \ }
"}}}

" shougo "{{{
" function! s:unite_my_settings()
"   " Directory partial match.
"   call unite#custom#alias('file', 'h', 'left')
"   call unite#custom#default_action('directory', 'narrow')
"   call unite#custom#default_action('versions/git/status', 'commit')
"   " call unite#custom#default_action('file', 'my_tabopen')
"   " call unite#custom#default_action('directory', 'cd')
"
"   " Overwrite settings.
"   imap <buffer>  <Tab>     <Plug>(unite_complete)
"   imap <buffer> '          <Plug>(unite_quick_match_default_action)
"   nmap <buffer> '          <Plug>(unite_quick_match_default_action)
"   nmap <buffer> cd         <Plug>(unite_quick_match_default_action)
"   nmap <buffer> <C-z>      <Plug>(unite_toggle_transpose_window)
"   imap <buffer> <C-z>      <Plug>(unite_toggle_transpose_window)
"   imap <buffer> <C-w>      <Plug>(unite_delete_backward_path)
"   nmap <buffer> <C-j>      <Plug>(unite_toggle_auto_preview)
"   nnoremap <silent><buffer> <Tab>     <C-w>w
"
"   nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
"   nnoremap <silent><buffer><expr> !     unite#do_action('start')
"   nnoremap <buffer><expr> S      unite#mappings#set_current_sorters(
"         \ empty(unite#mappings#get_current_sorters()) ? ['sorter_reverse'] : [])
"   nmap <buffer> x     <Plug>(unite_quick_match_jump)
" endfunction
"}}}

" #headline unite soure "{{{
let s:unite_source_headline = {
      \ 'name': 'headline',
      \ 'max_candidates': 100,
      \ }

function! s:unite_source_headline.gather_candidates(args, context)
  let outlines = []
  let num      = 0
  let marker   = split(&l:foldmarker, ',')[0]
  let comment  = split(&l:commentstring, '%s')[0]
  let marker_pattern = printf('\V%s\?\s\*%s', comment, marker)
  echomsg marker_pattern

  for line in getbufline('%', 1, '$')
    let num+=1
    " &l:commentstring
    " let matched = matchlist(line, '\v%(^|\s+)#(#*)\s*(\w[^\{#]*)')[1:2]
    " TODO syntax info使って区別する
    let matched = matchlist(line, '\v%(^|\s+)\#+\s*(.*)$')
    " let matched = matchlist(line, '\v^[^\w\d\#]*\#+\s*(.*)$')
    if empty(matched)
      continue
    endif

    " let oline = substitute(matched[1], '#', '  ', 'g')
    let oline = matched[1]
    let oline = substitute(oline, marker_pattern, '', '')
    if empty(oline)
      continue
    endif

    call add(outlines,{
          \ "word"         : oline,
          \ "source"       : "headline",
          \ "kind"         : "jump_list",
          \ "action__path" : expand('%:p'),
          \ "action__line" : num
          \ })
  endfor

  return outlines
endfunction

call unite#define_source(s:unite_source_headline)
unlet s:unite_source_headline
"}}}

" search_jump
let s:action = { 'is_selectable' : 0 }
function! s:action.func(candidates)
  let @/ = unite#get_input()
  call feedkeys(a:candidates.action__line . 'gg')
endfunction
call unite#custom#action('jump_list', 'search_jump', s:action)
unlet s:action

" on_post_sourceの中でやると起動直後に反映されてない
let g:unite_quickfix_is_multiline	= 0
call unite#custom_source('quickfix,location_list', 'sorters', 'sorter_reverse')
call unite#custom_source('quickfix', 'converters', 'converter_quickfix_highlight')
call unite#custom_source('location_list', 'converters', 'converter_quickfix_highlight')

call unite#custom#profile('source/kill', 'context', { 'start_insert': 1})

call unite#custom#default_action('file', 'tabopen')
call unite#custom#default_action('neomru', 'tabopen')
call unite#custom#default_action('source/line/*', 'search_jump')

au myac FileType unite call s:unite_config()
" unite_config "{{{
function! s:unite_config()
  nmap <buffer>I 1gg<Plug>(unite_insert_head)
  nmap <buffer>A 1gg<Plug>(unite_append_end)
  nnoremap <buffer>cc ggcc
  inoremap <buffer><C-e> <C-o>$
  inoremap <buffer><C-d> <Del>
  inoremap <buffer><C-b> <Left>
  inoremap <buffer><C-f> <Right>
  nnoremap <silent><buffer>q  :call <SID>unite_smart_close()<CR>
  nnoremap <silent><buffer><expr>r unite#do_action('replace')
  " nnoremap <buffer> <c-p> :<c-p> " c-pは使う
  nmap <silent><buffer>R *r

  inoremap <silent><buffer><expr><c-g>t unite#do_action('tabopen')
  inoremap <silent><buffer><expr><c-g>s unite#do_action('split')
  inoremap <silent><buffer><expr><c-g>v unite#do_action('vsplit')


  " TODO unite#get_current_unite()を使うべき
  let context = unite#get_context()

  if context.buffer_name == 'quickrun-hook-unite-quickfix' || context.buffer_name == 'quickfix'
    au myac WinEnter <buffer> if !exists('b:win_entered') | 0 | let b:win_entered = 1 | endif
    au myac WinEnter <buffer> if winnr('$') == 1 | quit | endif
    nnoremap <silent><buffer>k :call <SID>unite_move_pos(1)<CR>
    nnoremap <silent><buffer>j :call <SID>unite_move_pos(0)<CR>

  elseif context.buffer_name == 'location_list'
    au myac WinEnter <buffer> if winnr('$') == 1 | quit | endif

  elseif context.buffer_name ==# 'buffer'
    nnoremap <silent><buffer><expr><nowait>s unite#do_action('split')
    nnoremap <silent><buffer><expr><nowait>v unite#do_action('vsplit')
    nnoremap <silent><buffer><expr><nowait>t unite#do_action('tabopen')
  endif
endfunction "}}}

" smart_close "{{{
" active bufferならquit
" auto_highlightを消す
function! s:unite_smart_close()
  let context = unite#get_context()

  if vimrc#buffer_count('a') == 0
    quit
  elseif context.auto_highlight == 1
    if context.quit == 0
      call feedkeys("\<Plug>(unite_exit)")
    endif
    call feedkeys("\<Plug>(unite_do_default_action)")
  else
    call feedkeys("\<Plug>(unite_exit)")
  endif
endfunction "}}}

" unie_move_pos unite-quickfixで賢く移動する "{{{
function! s:unite_move_pos(is_up)
  call cursor(0, a:is_up? 1 : col('$'))
  call search('|\d\+\D*\d*|', a:is_up? 'wb' : 'w')
  normal! ^
endfunction "}}}
