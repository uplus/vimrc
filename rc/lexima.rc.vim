" call lexima#init() " Need first
" call lexima#set_default_rules()

" 別行で閉じる
call lexima#add_rule({'at': '\%#\_s*)', 'char': ')', 'leave': ')'})
call lexima#add_rule({'at': '\%#\_s*}', 'char': '}', 'leave': '}'})
call lexima#add_rule({'at': '\%#\_s*]', 'char': ']', 'leave': ']'})

" 文字の途中では無効
call lexima#add_rule({'at': '\%#[0-9a-zA-Z-_,:]', 'char': '(', 'input': '('})
call lexima#add_rule({'at': '\%#[0-9a-zA-Z-_,:]', 'char': '{', 'input': '{'})
call lexima#add_rule({'at': '\%#[0-9a-zA-Z-_,:]', 'char': '[', 'input': '['})
call lexima#add_rule({'at': '\%#[0-9a-zA-Z-_,:]', 'char': "'", 'input': "'"})
call lexima#add_rule({'at': '\%#[0-9a-zA-Z-_,:]', 'char': '"', 'input': '"'})

" jj <esc>
call lexima#add_rule({'at': 'j\%#', 'char': 'j', 'input': '<bs><esc>'})


" remove tail space when enter
call lexima#add_rule({'at': '\s\+\%#', 'char': '<cr>', 'input': '<cr>', 'filetype': ['markdown', 'gitcommit', 'help']})
call lexima#add_rule({'at': '\s\+\%#', 'char': '<cr>', 'input': '<bs><cr>'})

function! s:make_rule(at, end, filetype, syntax)
  return {
    \ 'char': '<CR>',
    \ 'input':  '<CR>',
    \ 'input_after': '<CR>' . a:end,
    \ 'at': a:at,
    \ 'except': '\C\v^(\s*)\S.*%#\n%(%(\s*|\1\s.+)\n)*\1' . a:end,
    \ 'filetype': a:filetype,
    \ 'syntax': a:syntax,
    \ }
endfunction
" call add(rules, s:make_rule('^\s*\%(module\|def\|class\|if\|unless\|for\|while\|until\|case\)\>\%(.*[^.:@$]\<end\>\)\@!.*\%#', 'end', 'ruby', []))
" call add(rules, s:make_rule('^\s*\%(begin\)\s*\%#', 'end', 'ruby', []))
" call add(rules, s:make_rule('\%(^\s*#.*\)\@<!do\%(\s*|.*|\)\?\s*\%#', 'end', 'ruby', []))
" call add(rules, s:make_rule('\<\%(if\|unless\)\>.*\%#', 'end', 'ruby', 'rubyConditionalExpression'))


" vim {{{
call lexima#add_rule({
  \ 'at': '\v(\{%#\}|\[%#\])',
  \ 'char': '<CR>',
  \ 'input': '<CR><Bslash> ',
  \ 'input_after': '<CR><Bslash> ',
  \ 'filetype': 'vim',
  \ })

" 既に括弧がある時
call lexima#add_rule({
  \ 'at': '[{\[]\s*\%#',
  \ 'char': '<CR>',
  \ 'input': '<CR><Bslash> ',
  \ 'filetype': 'vim',
  \ })

call lexima#add_rule({
  \ 'at': '[}\]]\s*\%#',
  \ 'char': '<CR>',
  \ 'input': '<CR><Bslash> ',
  \ 'filetype': 'vim'
  \ })

call lexima#add_rule({
  \ 'at': '\\.*\%#',
  \ 'char': '<CR>',
  \ 'input': '<CR><Bslash> ',
  \ 'filetype': 'vim',
  \ })

call lexima#add_rule({
  \ 'at': '\\\s.*\%#$',
  \ 'char': '<CR>',
  \ 'input': '<CR><Bslash> ',
  \ 'filetype': 'vim',
  \ })

call lexima#add_rule({
  \ 'at': '^\%#',
  \ 'char': '<Bslash>',
  \ 'input': '<Bslash><space>',
  \ 'filetype': 'vim'
  \ })

call lexima#add_rule(
  \ {'at': "'''\\%#'''",
  \ 'char': '<CR>',
  \ 'input': '<CR><CR><Up><tab>',
  \ 'filetype': ['vim', 'toml']
  \ })
"}}}

" c cpp {{{
" struct {  };
call lexima#add_rule({
  \ 'at'       : '\%(\<struct\>\|\<class\>\|\<enum\>\)\s*\w\+.*\%#',
  \ 'char'     : '{',
  \ 'input'    : '{};<Left><Left>',
  \ 'filetype' : ['c','cpp'],
  \ })

" #include <>
call lexima#add_rule({
  \ 'at'       : '^#i\%#',
  \ 'char'     : 'n',
  \ 'input'    : 'nclude <><Left>',
  \ 'filetype' : ['c','cpp'],
  \ })

" /* */
call lexima#add_rule({
  \ 'at'       : '/\*\%#',
  \ 'char'     : '<cr>',
  \ 'input'    : '*/<left><left><cr><up><end><cr>',
  \ 'filetype' : ['c','cpp'],
  \ })
"}}}

" ruby "{{{
call lexima#add_rule({
  \ 'at': '\v(\{|<do>)\s*%#',
  \ 'char': '<Bar>',
  \ 'input': '<Bar><Bar><Left>',
  \ 'filetype': ['ruby'],
  \ })

call lexima#add_rule({
  \ 'at': '\({\|\<do\>\)\s*|.*\%#|',
  \ 'char': '<Bar>',
  \ 'input': '<Right>',
  \ 'filetype': ['ruby'],
  \ })

call lexima#add_rule({
  \ 'at': '\({\|\<do\>\)\s*|\%#|',
  \ 'char': '<BS>',
  \ 'input': '<Del><BS>',
  \ 'filetype': ['ruby'],
  \ })

" input_afterでEndが使えない
call lexima#add_rule({
  \ 'char': '<CR>',
  \ 'input':  '<CR><End><CR>' . 'end' . '<Up><Left>',
  \ 'at': '\%(^\s*#.*\)\@<!do\%(\s*|.*|\)\?\s*\%#.\+',
  \ 'except': '\C\v^(\s*)\S.*%#\n%(%(\s*|\1\s.+)\n)*\1' . 'end',
  \ 'filetype': ['ruby'],
  \ })

"}}}

" eruby {{{
call lexima#add_rule({
  \ 'at': '\v\<%#',
  \ 'char': '%',
  \ 'input': '%%><LEFT><LEFT>',
  \ 'filetype': ['eruby'],
  \ })

"}}}

" html {{{

function! Lexima_HtmlCloseTag() abort
  let str = printf('</%s>', matchstr(getline('.'), '\v^\s*\<\zs([^ >]+)\ze[ >]'))
  return str . repeat("\<left>", len(str))
endfunction

let s:html_filetypes = ['html', 'eruby', 'vue', 'handlebars.html', 'jsx', 'typescriptreact']
let s:html_syntaxes = ['jsxTagName', 'jsxComponentName', 'jsxOpenPunct', 'htmlTagName', 'htmlSpecialTagName']

" 開始タグの閉じカッコを入力したら終了タグを挿入する
" /> <! </ は無視する
call lexima#add_rule({
  \ 'at': '\v\<[^/!].*[^/]%#',
  \ 'char': '>',
  \ 'input': '><c-r>=Lexima_HtmlCloseTag()<cr>',
  \ 'syntax': s:html_syntaxes,
  \ 'filetype': s:html_filetypes,
  \ })

call lexima#add_rule({
  \ 'at': '\v\<%#',
  \ 'char': '!',
  \ 'input': '!--  --><left><left><left><left>',
  \ 'syntax': s:html_syntaxes,
  \ 'filetype': s:html_filetypes,
  \ })

"}}}

" ------------------------------------------------------------------------------------------

" cgn ドットリピートに必要らしい <c-l>はneosnippet
" inoremap <C-l> <C-r>=lexima#insmode#leave(1, '<LT>C-G>U<LT>RIGHT>')<CR>

" TODO: 補完候補選択した場合のみ展開したい
"       選択時   : 決定+snippet
"       非選択時 : 改行+lexima

" NOTE: 諸々の残骸
" call lexima#insmode#map_hook('before', '<lt>cr>', "\<c-r>=deoplete#close_popup()\<cr>")
" imap <silent><expr><cr> lexima#expand('<lt>cr>', 'i')
" pumvisible() ? "\<C-Y>" : lexima#expand('<CR>', 'i')
" https://github.com/cohama/lexima.vim/issues/65
" call lexima#insmode#map_hook('before', '<lt>cr>', '')
" inoremap <expr><cr> deoplete#close_popup() . lexima#expand('<CR>', 'i')
