colorscheme default
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

set t_Co=256
let g:colors_name = "railscasts-u10"

hi link htmlTag                     xmlTag
hi link htmlTagName                 xmlTagName
hi link htmlEndTag                  xmlEndTag

highlight Normal                    guifg=#E6E1DC guibg=#111111
highlight Cursor                    guifg=#000000 ctermfg=0 guibg=#FFFFFF ctermbg=15
" highlight CursorLine                guibg=#000000 ctermbg=233 cterm=NONE

highlight Comment                   guifg=#BC9458 ctermfg=180 gui=italic
highlight Constant                  guifg=#6D9CBE ctermfg=73
" highlight Define                    guifg=#CC7833 ctermfg=173
highlight Error                     guifg=#FFC66D ctermfg=221 guibg=#990000 ctermbg=88
" highlight Function                  guifg=#FFC66D ctermfg=221 gui=NONE cterm=NONE
highlight Identifier                guifg=#6D9CBE ctermfg=73 gui=NONE cterm=NONE
highlight Include                   guifg=#CC7833 ctermfg=173 gui=NONE cterm=NONE
highlight PreCondit                 guifg=#CC7833 ctermfg=173 gui=NONE cterm=NONE
" highlight Keyword                   guifg=#CC7833 ctermfg=173 cterm=NONE
" highlight LineNr                    guifg=#2B2B2B ctermfg=159 guibg=#C0C0FF
" highlight Number                    guifg=#A5C261 ctermfg=107
highlight PreProc                   guifg=#E6E1DC ctermfg=103
" highlight Search                    guifg=NONE ctermfg=NONE guibg=#2b2b2b ctermbg=235 gui=italic cterm=underline
" highlight Statement                 guifg=#CC7833 ctermfg=173 gui=NONE cterm=NONE
highlight String                    guifg=#A5C261 ctermfg=107
highlight Title                     guifg=#FFFFFF ctermfg=15
highlight Type                      guifg=#DA4939 ctermfg=167 gui=NONE cterm=NONE
" highlight Visual                    guibg=#5A647E ctermbg=60

highlight DiffAdd                   guifg=#E6E1DC ctermfg=7 guibg=#519F50 ctermbg=71
highlight DiffDelete                guifg=#E6E1DC ctermfg=7 guibg=#660000 ctermbg=52
" highlight Special                   guifg=#DA4939 ctermfg=167

highlight pythonBuiltin             guifg=#6D9CBE ctermfg=73 gui=NONE cterm=NONE

" highlight rubyBlockParameter        guifg=#FFFFFF ctermfg=15
" highlight rubyClass                 guifg=#CC7833 ctermfg=161
" highlight rubyConstant              guifg=#DA4939 ctermfg=167
" highlight rubyInstanceVariable      guifg=#D0D0FF ctermfg=189
" highlight rubyInterpolation         guifg=#519F50 ctermfg=107
highlight rubyLocalVariableOrMethod guifg=#D0D0FF ctermfg=189
" highlight rubyPredefinedConstant    guifg=#DA4939 ctermfg=167
" highlight rubyPseudoVariable        guifg=#FFC66D ctermfg=221
" highlight rubyStringDelimiter       guifg=#A5C261 ctermfg=143

highlight xmlTag                    guifg=#E8BF6A ctermfg=179
highlight xmlTagName                guifg=#E8BF6A ctermfg=179
highlight xmlEndTag                 guifg=#E8BF6A ctermfg=179

highlight mailSubject               guifg=#A5C261 ctermfg=107
highlight mailHeaderKey             guifg=#FFC66D ctermfg=221
highlight mailEmail                 guifg=#A5C261 ctermfg=107 gui=italic cterm=underline

highlight SpellBad                  guifg=#D70000 ctermfg=160 ctermbg=NONE cterm=underline
highlight SpellRare                 guifg=#D75F87 ctermfg=168 guibg=NONE ctermbg=NONE gui=underline cterm=underline
highlight SpellCap                  guifg=#D0D0FF ctermfg=189 guibg=NONE ctermbg=NONE gui=underline cterm=underline
highlight MatchParen                guifg=#FFFFFF ctermfg=15 guibg=#005f5f ctermbg=23


"added
highlight Pmenu	              ctermbg=243 ctermfg=17
highlight PmenuSel            ctermbg=6	  ctermfg=40
highlight PmenuSel            ctermbg=70  ctermfg=129

highlight Normal              ctermbg=233
highlight Folded              ctermfg=33  ctermbg=233
highlight FoldColumn          ctermfg=99  ctermbg=232
highlight LineNr              ctermfg=252 ctermbg=237
highlight CursorLine          ctermbg=236 cterm=NONE
highlight CursorLineNr        ctermfg=196
highlight Todo                ctermfg=16 ctermbg=220

highlight rubyFunction              ctermfg=226
highlight rubyDefine                ctermfg=208
highlight rubyClass                 ctermfg=198
highlight rubyConstant              ctermfg=161
highlight rubyPreDefinedConstant    ctermfg=161
highlight rubyInstanceVariable      ctermfg=75
highlight rubyClassVariable         ctermfg=43

highlight Number                    ctermfg=38
highlight rubySymbol                ctermfg=63
highlight rubyString                ctermfg=111
highlight rubyStringDelimiter       ctermfg=74

" if else do end exitなど
highlight Statement                 ctermfg=214

" require include
highlight rubyInclude               ctermfg=214

" 埋め込み文字列の#{}や\nなど
highlight Special                   ctermfg=171

" 埋め込み文字の中身
" highlight rubyInterpolation         ctermfg=254
highlight rubyInterpolation         ctermfg=251

" 埋め込み文字#{}
highlight rubyInterpolationDelimiter ctermfg=39

" self, super
" highlight rubyPseudoVariable        ctermfg=220
" highlight Keyword                   ctermfg=220
highlight rubyPseudoVariable        ctermfg=190
highlight Keyword                   ctermfg=190

" ブロック変数の宣言だけを色つけしてくれる
highlight rubyBlockParameter        ctermfg=111
