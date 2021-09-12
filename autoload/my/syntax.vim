" vim: foldlevel=0

function! my#syntax#get_syn_id(transparent) abort "{{{
  let synid = synID(line('.'), col('.'), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction "}}}

function! my#syntax#get_syn_attr(synid) abort "{{{
  let name    = synIDattr(a:synid, 'name')
  let ctermfg = synIDattr(a:synid, 'fg', 'cterm')
  let ctermbg = synIDattr(a:synid, 'bg', 'cterm')
  let guifg   = synIDattr(a:synid, 'fg', 'gui')
  let guibg   = synIDattr(a:synid, 'bg', 'gui')
  return {
        \ 'name'    : name,
        \ 'ctermfg' : ctermfg,
        \ 'ctermbg' : ctermbg,
        \ 'guifg'   : guifg,
        \ 'guibg'   : guibg }
endfunction "}}}

function! my#syntax#get_syn_info() abort "{{{
  let baseSyn = my#syntax#get_syn_attr(my#syntax#get_syn_id(0))
  let base = 'name: '  . baseSyn.name    .
        \ ' ctermfg: ' . baseSyn.ctermfg .
        \ ' ctermbg: ' . baseSyn.ctermbg .
        \ ' guifg: '   . baseSyn.guifg   .
        \ ' guibg: '   . baseSyn.guibg

  let linkedSyn = my#syntax#get_syn_attr(my#syntax#get_syn_id(1))
  let link = 'name: '  . linkedSyn.name    .
        \ ' ctermfg: ' . linkedSyn.ctermfg .
        \ ' ctermbg: ' . linkedSyn.ctermbg .
        \ ' guifg: '   . linkedSyn.guifg   .
        \ ' guibg: '   . linkedSyn.guibg

  echo base
  if base != link
    echo 'link to'
    echo link
  endif
endfunction "}}}
