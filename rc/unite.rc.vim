" Unite:
let g:unite_enable_start_insert = 0
let g:unite_enable_auto_select  = 0
let g:unite_source_history_yank_enable = 1
let g:unite_enable_ignore_case  = 1
let g:unite_enable_smart_case   = 1

" grep
let g:unite_source_grep_max_candidates = 200
if executable('ag')
  " Use ag in unite grep source.
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
        \ '-i --vimgrep --hidden --ignore ' .
        \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
elseif executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
elseif executable('jvgrep')
  " For jvgrep.
  let g:unite_source_grep_command = 'jvgrep'
  let g:unite_source_grep_default_opts = '-i --exclude ''\.(git|svn|hg|bzr)'''
  let g:unite_source_grep_recursive_opt = '-R'
endif

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
let g:unite_source_alias_aliases.mes = {
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
let g:unite_source_alias_aliases.maps = {
      \ 'source' : 'output',
      \ 'args'   : 'map|map!|lmap',
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

" #headline unite-soure "{{{
let s:unite_source_headline = {
      \ 'name': 'headline',
      \ 'max_candidates': 100,
      \ }

function! s:unite_source_headline.gather_candidates(args, context)
  let outlines = []
  let num      = 0
  for line in getbufline('%', 1, '$')
    let num+=1
    let matched = matchlist(line, '\v^\s*#(#*)\s*(\w[^\{#]*)')[1:2]
    let oline   = substitute(join(matched, ''), '#', '  ', 'g')
    if empty(oline) | continue | endif

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

" on_post_sourceの中でやると起動直後に反映されてない
call unite#custom_source('quickfix,location_list', 'sorters', 'sorter_reverse')
call unite#custom_source('quickfix', 'converters', 'converter_quickfix_highlight')
