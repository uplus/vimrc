
" function! s:make_rule(at, end, filetype, syntax)
"   return {
"   \ 'char': '<CR>',
"   \ 'input':  '<CR>',
"   \ 'input_after': '<CR>' . a:end,
"   \ 'at': a:at,
"   \ 'except': '\C\v^(\s*)\S.*%#\n%(%(\s*|\1\s.+)\n)*\1' . a:end,
"   \ 'filetype': a:filetype,
"   \ 'syntax': a:syntax,
"   \ }
" endfunction

" ruby以外のendwiseを追加する
" for rule in filter(lexima#endwise_rule#make(), { idx, rule -> !(type(rule.filetype) == v:t_string && rule.filetype == 'ruby') })
" endwise系に変更あったっぽいので一旦カスタマイズ無効
" for rule in lexima#endwise_rule#make()
"   call lexima#add_rule(rule)
" endfor

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
" call lexima#add_rule({'at': '\s\+\%#', 'char': '<cr>', 'input': '<cr>', 'filetype': ['markdown', 'gitcommit', 'help']})
" call lexima#add_rule({'at': '\s\+\%#', 'char': '<cr>', 'input': '<bs><cr>'})

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

call lexima#add_rule({
  \ 'at': "'''\\%#'''",
  \ 'char': '<cr>',
  \ 'input_after': '<cr>',
  \ 'filetype': ['vim', 'toml', 'python']
  \ })
"}}}

" markdown: {{{
call lexima#add_rule({
  \ 'at': '```.*\%#```',
  \ 'char': '<cr>',
  \ 'input_after': '<cr>',
  \ 'filetype': ['markdown']
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

" 標準と同じ
" call lexima#add_rule(s:make_rule('^\s*\%(begin\)\s*\%#', 'end', 'ruby', []))
" call lexima#add_rule(s:make_rule('\%(^\s*#.*\)\@<!do\%(\s*|.*|\)\?\s*\%#', 'end', 'ruby', []))
" call lexima#add_rule(s:make_rule('\<\%(if\|unless\)\>.*\%#', 'end', 'ruby', 'rubyConditionalExpression'))

" def以外を登録
" call lexima#add_rule(s:make_rule('^\s*\%(module\|class\|if\|unless\|for\|while\|until\|case\)\>\%(.*[^.:@$]\<end\>\)\@!.*\%#', 'end', 'ruby', []))

" defだけ括弧対応
" call lexima#add_rule(s:make_rule('^\s*\%(def\)\>\%(.*[^.:@$]\<end\>\)\@!.*\%#\s*$', 'end', 'ruby', []))

" " input_afterでEndが使えない
" call lexima#add_rule({
"  \ 'char': '<CR>',
"  \ 'input':  '<CR><End><CR>' . 'end' . '<Up><Left>',
"  \ 'at': '\%(^\s*#.*\)\@<!do\%(\s*|.*|\)\?\s*\%#.\+',
"  \ 'except': '\C\v^(\s*)\S.*%#\n%(%(\s*|\1\s.+)\n)*\1' . 'end',
"  \ 'filetype': ['ruby'],
"  \ })

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

let s:html_filetypes = ['html', 'eruby', 'vue', 'handlebars.html', 'jsx', 'typescriptreact', 'php', 'tsx']
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
