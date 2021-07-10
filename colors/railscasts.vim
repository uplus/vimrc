" ちらつくことがあるので無効
" hi clear
let g:colors_name = expand('<sfile>:t:r')

" hi Normal                    guifg=#E6E1DC guibg=#111111
" hi rubyLocalVariableOrMethod guifg=#D0D0FF ctermfg=189 guifg=#d7d7ff

" hi link htmlTag                     xmlTag
" hi link htmlTagName                 xmlTagName
" hi link htmlEndTag                  xmlEndTag
" hi xmlTag                    guifg=#E8BF6A ctermfg=179 guifg=#d7af5f
" hi xmlTagName                guifg=#E8BF6A ctermfg=179 guifg=#d7af5f
" hi xmlEndTag                 guifg=#E8BF6A ctermfg=179 guifg=#d7af5f
" hi mailSubject               guifg=#A5C261 ctermfg=107 guifg=#87af5f
" hi mailHeaderKey             guifg=#FFC66D ctermfg=221 guifg=#ffd75f
" hi mailEmail                 guifg=#A5C261 ctermfg=107 gui=italic cterm=underline guifg=#87af5f gui=underline

hi NonText      ctermfg=248 guifg=Gray
hi Normal       ctermfg=252 ctermbg=0    guifg=#F8F8F2 guibg=#101818

" hi! link Visual NonText

hi MatchParen         ctermfg=15  ctermbg=23   guifg=#ffffff guibg=#005f5f
hi StatusLine         ctermfg=255 ctermbg=NONE guifg=#eeeeee guibg=NONE     cterm=NONE gui=NONE

" hi Folded             ctermfg=198 ctermbg=NONE cterm=reverse   guifg=#ff0087 guibg=NONE gui=reverse
" hi Folded             ctermfg=250 ctermbg=NONE cterm=NONE guifg=#bcbcbc guibg=NONE gui=NONE
hi Folded             ctermfg=139 ctermbg=NONE cterm=NONE guifg=#aaccff guibg=NONE gui=NONE
hi FoldColumn         ctermfg=99  ctermbg=232 guifg=#875fff guibg=#080808
hi LineNr             ctermfg=252 ctermbg=237 guifg=#d0d0d0 guibg=#3a3a3a
hi SignColumn         ctermfg=244 guifg=#808080 guibg=#1c1c1c
hi CursorLine         ctermbg=238 guibg=#343434 cterm=NONE gui=NONE
hi CursorLineNr       ctermfg=196 guifg=#ff0000

hi rubySharpBang           ctermfg=103 guifg=#8787af
hi rubyInclude             ctermfg=214 guifg=#ffaf00
hi rubyComment             ctermfg=247 guifg=#d8d4ee
hi rubyDataDirective       ctermfg=111 guifg=#87afff
hi rubyError               ctermfg=255 ctermbg=161 guifg=#eeeeee guibg=#e7005f
hi rubyFunction            ctermfg=226 guifg=#f8ff03
hi rubyDefine              ctermfg=208 guifg=#ffa020
hi rubyClass               ctermfg=198 guifg=#ff0087
hi rubyConstant            ctermfg=161 guifg=#fb2767
hi rubyInstanceVariable    ctermfg=75 guifg=#4fbffe
hi rubyAccess ctermfg=81 guifg=#fe70ff

hi! link rubyClassVariable rubySymbol
hi! link rubyData rubyComment
hi! link rubyDocumentation rubyComment
hi! link rubyPreDefinedConstant rubyConstant
hi! link rubyAttribute rubyDefine
hi! link rubyException rubyFunction
hi! link rubyOperator rubyFunction
hi! link rubyEval rubyFunction

" if else do end ...
hi! link rubyConditional rubyDefine
hi! link rubyControl rubyDefine

hi rubyBoolean             ctermfg=39 guifg=#00afff
hi rubyInteger             ctermfg=38 guifg=#00afd7
hi rubySymbol              ctermfg=141 guifg=#bf97ff
hi rubyString              ctermfg=111 guifg=#87afff
hi rubyStringDelimiter     ctermfg=74 guifg=#5fafd7
" \n in string.
hi rubyStringEscape        ctermfg=171 guifg=#d75fff
" $0 $! ...
hi rubyIdentifier          ctermfg=73 cterm=NONE guifg=#5fafaf gui=NONE
" 埋め込み文字の中身
hi rubyInterpolation           ctermfg=250 guifg=#bcbcbc
hi clear rubyInterpolation
" 埋め込み文字#{}
hi rubyInterpolationDelimiter ctermfg=66 guifg=#21afff

" self, super
" hi rubyPseudoVariable        ctermfg=220 guifg=#ffd700
" hi Keyword                   ctermfg=220 guifg=#ffd700
hi! link rubyPseudoVariable  rubyInstanceVariable
hi rubyKeyword             ctermfg=190 guifg=#d7ff00

" ブロック変数の宣言だけを色つけしてくれる
hi rubyBlockParameter      ctermfg=111 guifg=#87afff

hi rubyRailsMethod ctermfg=109 guifg=#90a0b0
