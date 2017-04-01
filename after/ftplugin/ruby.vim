if exists("b:did_u10_ftplugin")
  " 標準が呼ばれまくるから無効に出来ない
  finish
endif
let b:did_u10_ftplugin = 1
" let b:did_ftplugin = 1

command! YardGen !yard doc %
nnoremap <f3> :YardGen<cr>

let b:match_ignorecase = 0
let b:match_words =
      \ '\<\%(if\|unless\|case\|while\|until\|for\|do\|class\|module\|def\|begin\)\>=\@!' .
      \ ':' .
      \ '\%(^\|[^.\:@$]\)\@<=\<end\:\@!\>' .
      \ ',{:},\[:\],(:)'

let b:match_skip =
      \ "synIDattr(synID(line('.'),col('.'),0),'name') =~ '" .
      \ "\\<ruby\\%(String\\|StringDelimiter\\|ASCIICode\\|Escape\\|" .
      \ "Regexp\\|RegexpDelimiter\\|" .
      \ "Interpolation\\|NoInterpolation\\|Comment\\|Documentation\\|" .
      \ "ConditionalModifier\\|RepeatModifier\\|OptionalDo\\|" .
      \ "Function\\|BlockArgument\\|KeywordAsMethod\\|ClassVariable\\|" .
      \ "InstanceVariable\\|GlobalVariable\\|Symbol\\)\\>'"

nnoremap <silent><buffer><Plug>(ruby_prev_def)     :<C-U>call <SID>searchsyn('\<def\>','rubyDefine','b','n')<CR>
nnoremap <silent><buffer><Plug>(ruby_next_def)     :<C-U>call <SID>searchsyn('\<def\>','rubyDefine','','n')<CR>
nnoremap <silent><buffer><Plug>(ruby_prev_def_end) :<C-U>call <SID>searchsyn('\<end\>','rubyDefine','b','n')<CR>
nnoremap <silent><buffer><Plug>(ruby_next_def_end) :<C-U>call <SID>searchsyn('\<end\>','rubyDefine','','n')<CR>
xnoremap <silent><buffer><Plug>(ruby_prev_def)     :<C-U>call <SID>searchsyn('\<def\>','rubyDefine','b','v')<CR>
xnoremap <silent><buffer><Plug>(ruby_next_def)     :<C-U>call <SID>searchsyn('\<def\>','rubyDefine','','v')<CR>
xnoremap <silent><buffer><Plug>(ruby_prev_def_end) :<C-U>call <SID>searchsyn('\<end\>','rubyDefine','b','v')<CR>
xnoremap <silent><buffer><Plug>(ruby_next_def_end) :<C-U>call <SID>searchsyn('\<end\>','rubyDefine','','v')<CR>
nmap <buffer>[m <Plug>(ruby_prev_def)
nmap <buffer>]m <Plug>(ruby_next_def_end)
nmap <buffer>[M <Plug>(ruby_prev_def_end)
nmap <buffer>]M <Plug>(ruby_next_def)
xmap <buffer>[m <Plug>(ruby_prev_def)
xmap <buffer>]m <Plug>(ruby_next_def_end)
xmap <buffer>[M <Plug>(ruby_prev_def_end)
xmap <buffer>]M <Plug>(ruby_next_def)

nnoremap <silent><buffer><Plug>(ruby_prev_cm)     :<C-U>call <SID>searchsyn('\<\%(class\<Bar>module\)\>','rubyModule\<Bar>rubyClass','b','n')<CR>
nnoremap <silent><buffer><Plug>(ruby_next_cm_end) :<C-U>call <SID>searchsyn('\<end\>','rubyModule\<Bar>rubyClass','','n')<CR>
nnoremap <silent><buffer><Plug>(ruby_next_cm)     :<C-U>call <SID>searchsyn('\<\%(class\<Bar>module\)\>','rubyModule\<Bar>rubyClass','','n')<CR>
nnoremap <silent><buffer><Plug>(ruby_prev_cm_end) :<C-U>call <SID>searchsyn('\<end\>','rubyModule\<Bar>rubyClass','b','n')<CR>
xnoremap <silent><buffer><Plug>(ruby_prev_cm)     :<C-U>call <SID>searchsyn('\<\%(class\<Bar>module\)\>','rubyModule\<Bar>rubyClass','b','v')<CR>
xnoremap <silent><buffer><Plug>(ruby_next_cm_end) :<C-U>call <SID>searchsyn('\<end\>','rubyModule\<Bar>rubyClass','','v')<CR>
xnoremap <silent><buffer><Plug>(ruby_next_cm)     :<C-U>call <SID>searchsyn('\<\%(class\<Bar>module\)\>','rubyModule\<Bar>rubyClass','','v')<CR>
xnoremap <silent><buffer><Plug>(ruby_prev_cm_end) :<C-U>call <SID>searchsyn('\<end\>','rubyModule\<Bar>rubyClass','b','v')<CR>

nmap <buffer>[[ <Plug>(ruby_prev_cm)
nmap <buffer>]] <Plug>(ruby_next_cm_end)
nmap <buffer>][ <Plug>(ruby_next_cm)
nmap <buffer>[] <Plug>(ruby_prev_cm_end)
xmap <buffer>[[ <Plug>(ruby_prev_cm)
xmap <buffer>]] <Plug>(ruby_next_cm_end)
xmap <buffer>][ <Plug>(ruby_next_cm)
xmap <buffer>[] <Plug>(ruby_prev_cm_end)

onoremap <silent><buffer>im :<C-U>call <SID>ruby_wrap_i("\<Plug>(ruby_prev_def)", "\<Plug>(ruby_next_def_end)")<CR>
onoremap <silent><buffer>am :<C-U>call <SID>ruby_wrap_a("\<Plug>(ruby_prev_def)", "\<Plug>(ruby_next_def_end)")<CR>
xnoremap <silent><buffer>im :<C-U>call <SID>ruby_wrap_i("\<Plug>(ruby_prev_def)", "\<Plug>(ruby_next_def_end)")<CR>
xnoremap <silent><buffer>am :<C-U>call <SID>ruby_wrap_a("\<Plug>(ruby_prev_def)", "\<Plug>(ruby_next_def_end)")<CR>
onoremap <silent><buffer>iM :<C-U>call <SID>ruby_wrap_i("\<Plug>(ruby_prev_cm)", "\<Plug>(ruby_next_cm_end)")<CR>
onoremap <silent><buffer>aM :<C-U>call <SID>ruby_wrap_a("\<Plug>(ruby_prev_cm)", "\<Plug>(ruby_next_cm_end)")<CR>
xnoremap <silent><buffer>iM :<C-U>call <SID>ruby_wrap_i("\<Plug>(ruby_prev_cm)", "\<Plug>(ruby_next_cm_end)")<CR>
xnoremap <silent><buffer>aM :<C-U>call <SID>ruby_wrap_a("\<Plug>(ruby_prev_cm)", "\<Plug>(ruby_next_cm_end)")<CR>

function! s:ruby_wrap_i(begin, end) abort "{{{
  norm! k
  exec 'norm' a:end
  let last = line('.')
  exec 'norm' a:begin

  if line('.') == last-1
    return
  endif

  norm! jV
  exe 'norm' a:end
  norm! k
endfunction "}}}

function! s:ruby_wrap_a(begin, end) abort "{{{
  exec 'norm' a:end
  if line('.') < line('$') && '' ==# getline(line('.')+1)
    let after = 1
  endif
  exec 'norm' a:begin

  while getline(line('.')-1) =~# '^\s*#' && line('.')
    -
  endwhile

  if exists('after')
    norm! V
    exec 'norm' a:end
    norm! j
  elseif 1 < line('.') && getline(line('.')-1) =~# '^\s*$'
    norm! kV
    exec 'norm' a:end
  else
    norm! V
    exec 'norm' a:end
  endif
endfunction "}}}

function! s:searchsyn(pattern, syn, flags, mode) abort "{{{
  let cnt = v:count1
  norm! m'

  if a:mode ==# 'v'
    norm! gv
  endif

  let i = 0
  while i < cnt
    let i += 1

    let line = line('.')
    let col  = col('.')
    let pos = search(a:pattern, 'W' . a:flags)

    while pos != 0 && s:synname() !~# a:syn
      let pos = search(a:pattern, 'W' . a:flags)
    endwhile

    if pos == 0
      call cursor(line, col)
      return
    endif
  endwhile
endfunction "}}}

function! s:synname() abort "{{{
  return synIDattr(synID(line('.'), col('.'), 0), 'name')
endfunction "}}}
