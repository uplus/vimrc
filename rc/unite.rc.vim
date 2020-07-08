" #headline unite soure
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
    let matched = matchlist(line, '\v%(^|\s+)\#+(\S.*)$')
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
          \ 'word'         : oline,
          \ 'source'       : 'headline',
          \ 'kind'         : 'jump_list',
          \ 'action__path' : expand('%:p'),
          \ 'action__line' : num
          \ })
  endfor

  return outlines
endfunction

call unite#define_source(s:unite_source_headline)
unlet s:unite_source_headline
