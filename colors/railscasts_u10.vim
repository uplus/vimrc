hi clear
set t_Co=256
let g:colors_name = expand('<sfile>:t:r')

" highlight Normal                    guifg=#E6E1DC guibg=#111111
" highlight rubyLocalVariableOrMethod guifg=#D0D0FF ctermfg=189 guifg=#d7d7ff

" hi link htmlTag                     xmlTag
" hi link htmlTagName                 xmlTagName
" hi link htmlEndTag                  xmlEndTag
" highlight xmlTag                    guifg=#E8BF6A ctermfg=179 guifg=#d7af5f
" highlight xmlTagName                guifg=#E8BF6A ctermfg=179 guifg=#d7af5f
" highlight xmlEndTag                 guifg=#E8BF6A ctermfg=179 guifg=#d7af5f
" highlight mailSubject               guifg=#A5C261 ctermfg=107 guifg=#87af5f
" highlight mailHeaderKey             guifg=#FFC66D ctermfg=221 guifg=#ffd75f
" highlight mailEmail                 guifg=#A5C261 ctermfg=107 gui=italic cterm=underline guifg=#87af5f gui=underline

" highlight SpellBad                  guifg=#D70000 ctermfg=160 ctermbg=NONE cterm=underline guifg=#d70000 guibg=NONE gui=underline
" highlight SpellRare                 guifg=#D75F87 ctermfg=168 guibg=NONE ctermbg=NONE gui=underline cterm=underline guifg=#d75f87 guibg=NONE gui=underline
" highlight SpellCap                  guifg=#D0D0FF ctermfg=189 guibg=NONE ctermbg=NONE gui=underline cterm=underline guifg=#d7d7ff guibg=NONE gui=underline

highlight MatchParen          ctermfg=15  ctermbg=23 guifg=#ffffff guibg=#005f5f
highlight Pmenu	              ctermfg=214 ctermbg=236 guifg=#ffaf00 guibg=#303030
highlight PmenuSel            ctermfg=235 ctermbg=214 guifg=#262626 guibg=#ffaf00
highlight StatusLine          ctermfg=255 ctermbg=NONE cterm=NONE guifg=#eeeeee guibg=NONE gui=NONE
highlight WildMenu            ctermfg=0   ctermbg=214 guifg=#000000 guibg=#ffaf00
highlight Normal              ctermbg=NONE
" highlight Folded              ctermfg=198 ctermbg=NONE cterm=reverse   guifg=#ff0087 guibg=NONE gui=reverse
" highlight Folded              ctermfg=250 ctermbg=NONE cterm=NONE guifg=#bcbcbc guibg=NONE gui=NONE
highlight Folded              ctermfg=133 ctermbg=NONE cterm=NONE guifg=#af5faf guibg=NONE gui=NONE
highlight FoldColumn          ctermfg=99  ctermbg=232 guifg=#875fff guibg=#080808
highlight LineNr              ctermfg=252 ctermbg=237 guifg=#d0d0d0 guibg=#3a3a3a
highlight CursorLine          ctermbg=233 cterm=NONE guibg=#121212 gui=NONE
highlight CursorLineNr        ctermfg=196 guifg=#ff0000
highlight Visual              ctermfg=219 ctermbg=NONE cterm=NONE guifg=#ffafff guibg=NONE gui=NONE


highlight rubySharpBang           ctermfg=103 guifg=#8787af
highlight rubyInclude             ctermfg=214 guifg=#ffaf00
" highlight rubyComment             ctermfg=179 guifg=#d7af5f
highlight rubyComment             ctermfg=247 guifg=#9e9e9e
highlight! link rubyData rubyComment
highlight rubyTodo                ctermfg=16  ctermbg=220 guifg=#000000 guibg=#ffd700
highlight rubyDataDirective       ctermfg=111 guifg=#87afff
highlight rubyError               ctermfg=255 ctermbg=161 guifg=#eeeeee guibg=#d7005f
highlight rubyFunction            ctermfg=226 guifg=#ffff00
highlight rubyDefine              ctermfg=208 guifg=#ff8700
highlight rubyClass               ctermfg=198 guifg=#ff0087
highlight rubyConstant            ctermfg=161 guifg=#d7005f
highlight rubyPreDefinedConstant  ctermfg=161 guifg=#d7005f
highlight rubyInstanceVariable    ctermfg=75 guifg=#5fafff
highlight rubyClassVariable       ctermfg=141 guifg=#af87ff
highlight rubyAttribute           ctermfg=172 guifg=#d78700

highlight rubyInteger             ctermfg=38 guifg=#00afd7
highlight rubySymbol              ctermfg=141 guifg=#af87ff
highlight rubyString              ctermfg=111 guifg=#87afff
highlight rubyStringDelimiter     ctermfg=74 guifg=#5fafd7
" \n in string.
highlight rubyStringEscape        ctermfg=171 guifg=#d75fff

" $0 $! ...
highlight rubyIdentifier          ctermfg=73 cterm=NONE guifg=#5fafaf gui=NONE

" if else do end ...
highlight rubyConditional         ctermfg=214 guifg=#ffaf00
highlight rubyControl             ctermfg=214 guifg=#ffaf00

" 埋め込み文字の中身
highlight rubyInterpolation           ctermfg=250 guifg=#bcbcbc
" 埋め込み文字#{}
highlight rubyInterpolationDelimiter  ctermfg=39 guifg=#00afff

" self, super
" highlight rubyPseudoVariable        ctermfg=220 guifg=#ffd700
" highlight Keyword                   ctermfg=220 guifg=#ffd700
highlight link rubyPseudoVariable  rubyInstanceVariable
highlight rubyBoolean             ctermfg=39 guifg=#00afff
highlight rubyKeyword             ctermfg=190 guifg=#d7ff00

" ブロック変数の宣言だけを色つけしてくれる
highlight rubyBlockParameter      ctermfg=111 guifg=#87afff
