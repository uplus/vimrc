hi clear
set t_Co=256
let g:colors_name = expand('<sfile>:t:r')

" highlight Normal                    guifg=#E6E1DC guibg=#111111
" highlight rubyLocalVariableOrMethod guifg=#D0D0FF ctermfg=189

" hi link htmlTag                     xmlTag
" hi link htmlTagName                 xmlTagName
" hi link htmlEndTag                  xmlEndTag
" highlight xmlTag                    guifg=#E8BF6A ctermfg=179
" highlight xmlTagName                guifg=#E8BF6A ctermfg=179
" highlight xmlEndTag                 guifg=#E8BF6A ctermfg=179
" highlight mailSubject               guifg=#A5C261 ctermfg=107
" highlight mailHeaderKey             guifg=#FFC66D ctermfg=221
" highlight mailEmail                 guifg=#A5C261 ctermfg=107 gui=italic cterm=underline

" highlight SpellBad                  guifg=#D70000 ctermfg=160 ctermbg=NONE cterm=underline
" highlight SpellRare                 guifg=#D75F87 ctermfg=168 guibg=NONE ctermbg=NONE gui=underline cterm=underline
" highlight SpellCap                  guifg=#D0D0FF ctermfg=189 guibg=NONE ctermbg=NONE gui=underline cterm=underline

highlight MatchParen                guifg=#FFFFFF ctermfg=15 guibg=#005f5f ctermbg=23
highlight Pmenu	              ctermfg=214 ctermbg=236
highlight PmenuSel            ctermfg=235 ctermbg=214
highlight StatusLine          ctermfg=255 ctermbg=NONE cterm=NONE
highlight WildMenu            ctermfg=0   ctermbg=214

highlight Normal              ctermbg=NONE
highlight Folded              ctermfg=198 ctermbg=NONE cterm=reverse
highlight FoldColumn          ctermfg=99  ctermbg=232
highlight LineNr              ctermfg=252 ctermbg=237
highlight CursorLine          ctermbg=233 cterm=NONE
highlight CursorLineNr        ctermfg=196


highlight rubySharpBang           ctermfg=103
highlight rubyInclude             ctermfg=214
" highlight rubyComment             ctermfg=179
highlight rubyComment             ctermfg=247
highlight rubyTodo                ctermfg=16  ctermbg=220
highlight rubyError               ctermfg=255 ctermbg=161
highlight rubyFunction            ctermfg=226
highlight rubyDefine              ctermfg=208
highlight rubyClass               ctermfg=198
highlight rubyConstant            ctermfg=161
highlight rubyPreDefinedConstant  ctermfg=161
highlight rubyInstanceVariable    ctermfg=75
highlight rubyClassVariable       ctermfg=141
highlight rubyAttribute           ctermfg=172

highlight rubyInteger             ctermfg=38
highlight rubySymbol              ctermfg=141
highlight rubyString              ctermfg=111
highlight rubyStringDelimiter     ctermfg=74
" \n in string.
highlight rubyStringEscape        ctermfg=171

" $0 $! ...
highlight rubyIdentifier          ctermfg=73 cterm=NONE

" if else do end ...
highlight rubyConditional         ctermfg=214
highlight rubyControl             ctermfg=214

" 埋め込み文字の中身
highlight rubyInterpolation           ctermfg=250
" 埋め込み文字#{}
highlight rubyInterpolationDelimiter  ctermfg=39

" self, super
" highlight rubyPseudoVariable        ctermfg=220
" highlight Keyword                   ctermfg=220
highlight link rubyPseudoVariable  rubyInstanceVariable
highlight rubyBoolean             ctermfg=39
highlight rubyKeyword             ctermfg=190

" ブロック変数の宣言だけを色つけしてくれる
highlight rubyBlockParameter      ctermfg=111
