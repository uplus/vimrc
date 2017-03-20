
" call lexima#init() " Need first

" TODO smartinput時代の遺産を回収
" TODO 補完候補選択した場合のみ展開したい
" 順序?
" imap <expr><silent><cr> neosnippet#expandable()? "\<Plug>(neosnippet_expand)" : lexima#expand('<LT>CR>', 'i')

" 別行で閉じる
call lexima#add_rule({'at': '\%#\_s*)', 'char': ')', 'leave': ')'})
call lexima#add_rule({'at': '\%#\_s*}', 'char': '}', 'leave': '}'})
call lexima#add_rule({'at': '\%#\_s*]', 'char': ']', 'leave': ']'})

" vim
call lexima#add_rule({'at': '{\%#}', 'char': '<CR>', 'input': '<CR><Bslash> ', 'input_after': '<CR><Bslash> ', 'filetype': 'vim'})
call lexima#add_rule({'at': '\\\s.*\%#$', 'char': '<CR>', 'input': '<CR><Bslash> ', 'filetype': 'vim'})

" TODO  わざわざ<cr>で補完確定する必要ない
"       選択時   : 決定+snippet
"       非選択時 : 改行+lexima
" call lexima#insmode#map_hook('before', '<cr>', "\<C-r>=neocomplete#close_popup()\<cr>")
" imap <silent><expr><cr> neosnippet#expandable()? "\<Plug>(neosnippet_expand)" : pumvisible()? "\<c-y>" : lexima#expand('<cr>', 'i')
" \<Plug>(lexima#expand('<cr>', 'i'))<c-g>u"


inoremap <silent><expr><c-m> pumvisible()? "\<c-y>\<c-m>" : lexima#expand('<cr>', 'i')
" imap <silent><expr><cr> neosnippet#expandable()? "\<Plug>(neosnippet_expand)" : lexima#expand('<cr>', 'i')
