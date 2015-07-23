" Unite:

" grep
let g:unite_source_grep_max_candidates = 200
if executable('ag')
    " Use ag in unite grep source.
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
          \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
          \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
endif


" alias
" aliasは入力値などを固定化出来るだけ
let g:unite_source_alias_aliases = {}
let g:unite_source_alias_aliases.g = {
      \ 'source' : 'grep',
      \ 'args' : '%',
      \ }
let g:unite_source_alias_aliases.calc    = 'kawaii-calc'
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
let g:unite_source_alias_aliases.scriptnames = {
      \ 'source' : 'output',
      \ 'args'   : 'scriptnames',
      \ }


" Todo: custom-filterやる
