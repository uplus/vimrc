" Input Mappings:

imap <c-l> <plug>(neosnippet_expand_or_jump)
smap <c-l> <plug>(neosnippet_jump)
xmap <c-l> <plug>(neosnippet_jump)

" 候補選択系
" insert_relative と select_relative がある
inoremap <silent><expr><tab> <sid>imap_tab()
inoremap <silent><expr><s-tab> pum#visible() ? "\<cmd>call pum#map#insert_relative(-1)\<cr>" : "\<c-h>"
inoremap <silent><expr><c-n>   pum#visible() ? "\<cmd>call pum#map#insert_relative(+1)\<cr>" : ddc#manual_complete()
inoremap <c-p>                 <cmd>call pum#map#select_relative(-1)<cr>

" 確定系
imap <expr><silent><cr> <sid>imap_cr()
" 補完後に改行ができなくなる
" imap <expr><c-y> neosnippet#expandable() ? "\<plug>(neosnippet_expand)" : "\<c-y>"
inoremap <c-y>   <cmd>call pum#map#confirm()<cr>
" inoremap <c-e>   <cmd>call pum#map#cancel()<cr>

" TODO: 設定してないソースは反応しない?
inoremap <silent><expr><c-x><c-f> ddc#map#manual_complete(["file"])
inoremap <silent><expr><c-x><c-a> ddc#map#manual_complete(["around"])
inoremap <silent><expr><c-x><c-r> ddc#map#manual_complete(["rg"])
inoremap <silent><expr><c-x><c-l> ddc#map#manual_complete(["line"])
inoremap <silent><expr><c-x><c-b> ddc#map#manual_complete(["buffer"])

" inoremap <silent><expr> <c-l>   ddc#map#extend()
" inoremap <silent><expr> <c-l>   ddc#complete_common_string()
" inoremap <expr><bs> deoplete#mappings#smart_close_popup()."\<C-h>"

function! SnippetExpandable() abort
  return neosnippet#helpers#get_cursor_snippet(neosnippet#helpers#get_snippets('i'), neosnippet#util#get_cur_text()) !=# ''
endfunction

function! s:imap_tab() abort
  if pum#visible()
    return "\<cmd>call pum#map#insert_relative(+1)\<cr>"
  endif

  if col('.') <= 1 || getline('.')[col('.') - 2] =~# '\s'
    return "\<tab>"
  else
    return ddc#manual_complete()
  endif
endfunction

function! s:imap_cr() abort
  " いろいろ試したが、<cr>でスニペット展開が発動するのは微妙に使いづらい

  " leximaは<CR>と<cr>を区別する
  if pum#visible()
    if SnippetExpandable()
      echo 'snippet expandable'
      call pum#map#confirm()
      return lexima#expand('<CR>', 'i')
    else
      call pum#map#confirm()
      return lexima#expand('<CR>', 'i')
    endif
  else
    return lexima#expand('<CR>', 'i')
  endif
endfunction

" NOTE: 諸々の残骸
" call lexima#insmode#map_hook('before', '<lt>CR>', "\<c-r>=deoplete#close_popup()\<CR>")
" imap <silent><expr><CR> lexima#expand('<lt>CR>', 'i')
" pum#visible() ? "\<C-Y>" : lexima#expand('<CR>', 'i')
" https://github.com/cohama/lexima.vim/issues/65
" call lexima#insmode#map_hook('before', '<lt>CR>', '')
" inoremap <expr><CR> deoplete#close_popup() . lexima#expand('<CR>', 'i')

" TODO: 補完候補選択した場合のみ展開したい
"       選択時   : 決定+snippet
"       非選択時 : 改行+lexima
