" vim: foldlevel=0

function! my#syntax#get_syn_attr_dict(syn_id) abort "{{{
  let name    = synIDattr(a:syn_id, 'name')
  let ctermfg = synIDattr(a:syn_id, 'fg', 'cterm')
  let ctermbg = synIDattr(a:syn_id, 'bg', 'cterm')
  let guifg   = synIDattr(a:syn_id, 'fg', 'gui')
  let guibg   = synIDattr(a:syn_id, 'bg', 'gui')
  return {
        \ 'name'    : name,
        \ 'ctermfg' : ctermfg,
        \ 'ctermbg' : ctermbg,
        \ 'guifg'   : guifg,
        \ 'guibg'   : guibg }
endfunction "}}}

function! my#syntax#get_syn_attr_pretty(syn_attr) abort "{{{
  let str = 'name: '  . a:syn_attr.name    .
        \ ' ctermfg: ' . a:syn_attr.ctermfg .
        \ ' ctermbg: ' . a:syn_attr.ctermbg .
        \ ' guifg: '   . a:syn_attr.guifg   .
        \ ' guibg: '   . a:syn_attr.guibg

  return str
endfunction "}}}

function! my#syntax#get_syn_name() abort
  " TODO: ハイライト情報を出力する
  echo ddc#syntax#get()
endfunction

function! my#syntax#get_syn_info() abort "{{{
  for id in synstack(line('.'), col('.'))
    while 1
      echo my#syntax#get_syn_attr_pretty(my#syntax#get_syn_attr_dict(id))

      let new_id = synIDtrans(id)
      if id == new_id
        break
      else
        let id = new_id
        echo 'link to'
      endif
    endwhile
  endfor
endfunction "}}}
