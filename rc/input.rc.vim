inoremap <expr><tab>   pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"
" inoremap <expr><silent><c-x><c-e> deoplete#manual_complete(['emoji'])
inoremap <expr><silent><c-x><c-l> deoplete#manual_complete()

" TODO: backspace時の補完の挙動が微妙

imap <c-l> <plug>(neosnippet_expand_or_jump)
smap <c-l> <plug>(neosnippet_jump)
xmap <c-l> <plug>(neosnippet_jump)
" 補完後に開業ができなくなる
" imap <expr><c-y> neosnippet#expandable() ? "\<plug>(neosnippet_expand)" : "\<c-y>"
imap <expr><silent><cr> <sid>imap_cr()
" inoremap <expr><bs> deoplete#mappings#smart_close_popup()."\<C-h>"
" inoremap <expr> '  pumvisible() ? deoplete#mappings#close_popup() : "'"
" inoremap <expr><silent> <c-t> deoplete#mappings#manual_complete('file')

function! SnippetExpandable() abort
  return neosnippet#helpers#get_cursor_snippet(neosnippet#helpers#get_snippets('i'), neosnippet#util#get_cur_text()) !=# ''
endfunction

function! s:imap_cr() abort
  " いろいろ試したが、<cr>でスニペット展開が発動するのは微妙に使いづらい

  if pumvisible()
    if SnippetExpandable()
      call deoplete#close_popup()
      return lexima#expand('<CR>', 'i')
    else
      call deoplete#close_popup()
      return lexima#expand('<CR>', 'i')
    endif
  else
    return lexima#expand('<CR>', 'i')
  endif
endfunction


" NOTE: 諸々の残骸
" call lexima#insmode#map_hook('before', '<lt>cr>', "\<c-r>=deoplete#close_popup()\<cr>")
" imap <silent><expr><cr> lexima#expand('<lt>cr>', 'i')
" pumvisible() ? "\<C-Y>" : lexima#expand('<CR>', 'i')
" https://github.com/cohama/lexima.vim/issues/65
" call lexima#insmode#map_hook('before', '<lt>cr>', '')
" inoremap <expr><cr> deoplete#close_popup() . lexima#expand('<CR>', 'i')

" TODO: 補完候補選択した場合のみ展開したい
"       選択時   : 決定+snippet
"       非選択時 : 改行+lexima

" call deoplete#custom#option('candidate_marks',
"      \ ['A', 'S', 'D', 'F', 'G'])
" inoremap <expr>A       pumvisible() ?
"\ deoplete#insert_candidate(0) : 'A'
" inoremap <expr>S       pumvisible() ?
"\ deoplete#insert_candidate(1) : 'S'
" inoremap <expr>D       pumvisible() ?
"\ deoplete#insert_candidate(2) : 'D'
" inoremap <expr>F       pumvisible() ?
"\ deoplete#insert_candidate(3) : 'F'
" inoremap <expr>G       pumvisible() ?
"\ deoplete#insert_candidate(4) : 'G'
