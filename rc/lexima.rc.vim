
" call lexima#init() " Need first
" call lexima#set_default_rules()

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


" 別行で閉じる
call lexima#add_rule({'at': '\%#\_s*)', 'char': ')', 'leave': ')'})
call lexima#add_rule({'at': '\%#\_s*}', 'char': '}', 'leave': '}'})
call lexima#add_rule({'at': '\%#\_s*]', 'char': ']', 'leave': ']'})

" 文字の途中では無効
call lexima#add_rule({'at': '\%#[0-9a-zA-Z-_,:]', 'char': '(', 'input': '('})
call lexima#add_rule({'at': '\%#[0-9a-zA-Z-_,:]', 'char': '{', 'input': '{'})
call lexima#add_rule({'at': '\%#[0-9a-zA-Z-_,:]', 'char': '[', 'input': '['})

" jj <esc>
call lexima#add_rule({'at': 'j\%#', 'char': 'j', 'input': '<bs><esc>'})

" vim {{{
call lexima#add_rule(
      \ {'at': '\v(\{%#\}|\[%#\])',
      \ 'char': '<CR>',
      \ 'input': '<CR><Bslash> ',
      \ 'input_after': '<CR><Bslash> ',
      \ 'filetype': 'vim'})

" 既に括弧がある時
call lexima#add_rule(
      \ {'at': '[{\[]\s*\%#',
      \ 'char': '<CR>',
      \ 'input': '<CR><Bslash> ',
      \ 'filetype': 'vim'})

call lexima#add_rule(
      \ {'at': '[}\]]\s*\%#',
      \ 'char': '<CR>',
      \ 'input': '<CR><Bslash> ',
      \ 'filetype': 'vim'})

call lexima#add_rule(
      \ {'at': '\\.*\%#',
      \ 'char': '<CR>',
      \ 'input': '<CR><Bslash> ',
      \ 'filetype': 'vim'})

call lexima#add_rule({
      \ 'at': '\\\s.*\%#$',
      \ 'char': '<CR>',
      \ 'input': '<CR><Bslash> ',
      \ 'filetype': 'vim'})

call lexima#add_rule({
      \ 'at': '^\%#',
      \ 'char': '<Bslash>',
      \ 'input': '<Bslash><space>',
      \ 'filetype': 'vim'})

call lexima#add_rule(
      \ {'at': "'''\\%#'''",
      \ 'char': '<CR>',
      \ 'input': '<CR><CR><Up><tab>',
      \ 'filetype': ['vim', 'toml']})
"}}}

" c cpp {{{
" struct {  };
call lexima#add_rule({
      \   'at'       : '\%(\<struct\>\|\<class\>\|\<enum\>\)\s*\w\+.*\%#',
      \   'char'     : '{',
      \   'input'    : '{};<Left><Left>',
      \   'filetype' : ['c','cpp'],
      \   })

" #include <>
call lexima#add_rule({
      \   'at'       : '^#i\%#',
      \   'char'     : 'n',
      \   'input'    : 'nclude <><Left>',
      \   'filetype' : ['c','cpp'],
      \   })

" /* */
call lexima#add_rule({
      \   'at'       : '/\*\%#',
      \   'char'     : '<cr>',
      \   'input'    : '*/<left><left><cr><up><end><cr>',
      \   'filetype' : ['c','cpp'],
      \   })
"}}}

" ruby "{{{
call lexima#add_rule({
  \   'at': '\v(\{|<do>)\s*%#',
  \   'char': '<Bar>',
  \   'input': '<Bar><Bar><Left>',
  \   'filetype': ['ruby'],
  \ })

call lexima#add_rule({
  \   'at': '\({\|\<do\>\)\s*|.*\%#|',
  \   'char': '<Bar>',
  \   'input': '<Right>',
  \   'filetype': ['ruby'],
  \ })

call lexima#add_rule({
  \   'at': '\({\|\<do\>\)\s*|\%#|',
  \   'char': '<BS>',
  \   'input': '<Del><BS>',
  \   'filetype': ['ruby'],
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

" html

" 開始タグの閉じカッコを入力したら終了タグを挿入する
" /> <! </ は無視する
call lexima#add_rule({
      \   'at': '\v\<[^/!].*[^/]%#',
      \   'char': '>',
      \   'input': '><c-r>=Lexima_HtmlCloseTag()<cr>',
      \   'filetype': ['html', 'eruby', 'vue', 'handlebars.html'],
      \ })

call lexima#add_rule({
      \   'at': '\v\<%#',
      \   'char': '!',
      \   'input': '!--  --><left><left><left><left>',
      \   'filetype': ['html', 'eruby', 'vue', 'handlebars.html'],
      \ })

function! Lexima_HtmlCloseTag() abort
  let str = printf('</%s>', matchstr(getline('.'), '\v^\s*\<\zs([^ >]+)\ze[ >]'))
  return str . repeat("\<left>", len(str))
endfunction

" eruby
call lexima#add_rule({
      \   'at': '\v\<%#',
      \   'char': '%',
      \   'input': '%%><LEFT><LEFT>',
      \   'filetype': ['eruby'],
      \ })

" " casl2
" RET NOP START END POP DS DC LD ST ADDA SUBA ADDL SUBL AND OR XOR CPA CPL JUMP JPL JMI JNZ JZE JOV CALL SVC LAD SLA SRA SLL SRL PUSH
" let s:casl_pattern = '\v(ret|nop|start|end|pop|ds|dc|ld|st|adda|suba|addl|subl|and|or|xor|cpa|cpl|jump|jpl|jmi|jnz|jze|jov|call|svc|lad|sla|sra|sll|srl|push)'
" " echo substitute('ret', l:casl_pattern, '\U\1', '')
" call lexima#add_rule({
"       \   'at': '\%#',
"       \   'char': 'ret|nop',
"       \   'input': 'RET',
"       \   'filetype': ['casl2'],
"       \ })
" call lexima#add_rule({
"       \   'at': '\%#',
"       \   'char': s:casl_pattern,
"       \   'input': '\U\1',
"       \   'filetype': ['casl2'],
"       \ })
" unlet s:casl_pattern

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
