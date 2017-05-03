" Vim color file
"     Version:    1.2 2007.08.08
"     Author:     Valyaeff Valentin <hhyperr AT gmail DOT com>
"     License:    GPL
"
" Copyright 2007 Valyaeff Valentin
"
" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
"
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with this program.  If not, see <http://www.gnu.org/licenses/>.

set background=dark
hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = expand('<sfile>:t:r')

augroup lettuce_syntax_extensions
  au!
  au Syntax c,cpp syn match Operator "[*/%&|!=><^~,.;+-]\+" display contains=TOP
  au Syntax c,cpp syn region cParen matchgroup=Operator transparent start='(' end=')' contains=ALLBUT,@cParenGroup,cCppParen,cErrInBracket,cCppBracket,cCppString,@Spell
  au Syntax c,cpp syn region cCppParen matchgroup=Operator transparent start='(' skip='\\$' excludenl end=')' end='$' contained contains=ALLBUT,@cParenGroup,cErrInBracket,cParen,cBracket,cString,@Spell
  au Syntax c,cpp syn region cBracket matchgroup=Operator transparent start='\[\|<::\@!' end=']\|:>' contains=ALLBUT,@cParenGroup,cErrInParen,cCppParen,cCppBracket,cCppString,@Spell
  au Syntax c,cpp syn region cCppBracket matchgroup=Operator transparent start='\[\|<::\@!' skip='\\$' excludenl end=']\|:>' end='$' contained contains=ALLBUT,@cParenGroup,cErrInParen,cParen,cBracket,cString,@Spell
  au Syntax c,cpp syn region cBlock matchgroup=OperatorCurlyBrackets start="{" end="}" transparent fold
augroup END


hi Character             cterm=none      ctermbg=235 ctermfg=215   gui=none guibg=#262626 guifg=#ffaf5f
hi Constant              cterm=none      ctermfg=215 gui=none      guifg=#ffaf5f
hi CursorColumn          cterm=none      ctermbg=234 gui=none      guibg=#1c1c1c
hi CursorLine            cterm=none      ctermbg=234 gui=none      guibg=#1c1c1c
hi DiffAdd               cterm=none      ctermbg=18  gui=none      guibg=#000087
hi DiffChange            cterm=none      ctermbg=58  gui=none      guibg=#5f5f00
hi DiffDelete            cterm=none      ctermbg=52  ctermfg=58    gui=none guibg=#5f0000 guifg=#5f5f00
hi DiffText              cterm=none      ctermbg=53  gui=none      guibg=#5f005f
hi Directory             ctermfg=105     guifg=#8787ff
hi Error                 cterm=bold      ctermbg=52  ctermfg=231   gui=bold guibg=#5f0000 guifg=#ffffff
hi ErrorMsg              cterm=none      ctermbg=88  ctermfg=255   gui=none guibg=#870000 guifg=#eeeeee
hi Exception             cterm=bold      ctermfg=99  gui=bold      guifg=#875fff
hi FoldColumn            cterm=none      ctermbg=236 ctermfg=103   gui=none guibg=#303030 guifg=#8787af
hi Folded                cterm=none      ctermbg=234 ctermfg=136   gui=none guibg=#1c1c1c guifg=#af8700
hi Function              cterm=none      ctermfg=210 gui=none      guifg=#ff8787
hi Identifier            cterm=none      ctermfg=186 gui=none      guifg=#dfdf87
hi Ignore                cterm=bold      ctermfg=235 gui=bold      guifg=#262626
hi IncSearch             cterm=bold      ctermbg=63  ctermfg=232   gui=bold guibg=#5f5fff guifg=#080808
hi Label                 cterm=none      ctermfg=63  gui=none      guifg=#5f5fff
hi LineNr                cterm=none      ctermfg=238 gui=none      guifg=#444444
hi MatchParen            cterm=bold      ctermbg=24  gui=bold      guibg=#005f87
hi ModeMsg               cterm=bold      ctermfg=110 gui=bold      guifg=#87afdf
hi MoreMsg               cterm=bold      ctermfg=121 gui=bold      guifg=#87ffaf
hi NonText               cterm=bold      ctermbg=233 ctermfg=241   gui=bold guibg=#121212 guifg=#606060
hi Normal                cterm=none      ctermbg=232 ctermfg=189   gui=none guibg=#080808 guifg=#dfdfff
hi Operator              cterm=none      ctermfg=75  gui=none      guifg=#5fafff
hi OperatorCurlyBrackets cterm=bold      ctermfg=75  gui=bold      guifg=#5fafff
hi Pmenu                 cterm=none      ctermbg=17  ctermfg=121   gui=none guibg=#00005f guifg=#87ffaf
hi PmenuSbar             cterm=none      ctermbg=19  gui=none      guibg=#0000af
hi PmenuSel              cterm=none      ctermbg=24  ctermfg=121   gui=none guibg=#005f87 guifg=#87ffaf
hi PmenuThumb            cterm=none      ctermbg=37  gui=none      guibg=#00afaf
hi PreProc               cterm=bold      ctermfg=36  gui=bold      guifg=#00af87
hi Question              cterm=bold      ctermfg=121 gui=bold      guifg=#87ffaf
hi Search                cterm=none      ctermbg=36  ctermfg=232   gui=none guibg=#00af87 guifg=#080808
hi SignColumn            cterm=none      ctermbg=236 ctermfg=103   gui=none guibg=#303030 guifg=#8787af
hi SpecialKey            cterm=none      ctermfg=77  gui=none      guifg=#5fdf5f
hi SpellBad              cterm=none      ctermbg=88  gui=none      guibg=#870000
hi SpellCap              cterm=none      ctermbg=18  gui=none      guibg=#000087
hi SpellLocal            cterm=none      ctermbg=30  gui=none      guibg=#008787
hi SpellRare             cterm=none      ctermbg=90  gui=none      guibg=#870087
hi Statement             cterm=bold      ctermfg=63  gui=bold      guifg=#5f5fff
hi StatusLine            cterm=none      ctermbg=236 ctermfg=231   gui=none guibg=#303030 guifg=#ffffff
hi StatusLineNC          cterm=none      ctermbg=236 ctermfg=103   gui=none guibg=#303030 guifg=#8787af
hi String                cterm=none      ctermbg=235 ctermfg=215   gui=none guibg=#262626 guifg=#ffaf5f
hi TabLine               cterm=none      ctermbg=236 ctermfg=145   gui=none guibg=#303030 guifg=#afafaf
hi TabLineFill           cterm=none      ctermbg=236 gui=none      guibg=#303030
hi TabLineSel            cterm=none      ctermbg=240 ctermfg=253   gui=none guibg=#585858 guifg=#dadada
hi Title                 cterm=bold      ctermfg=147 gui=bold      guifg=#afafff
hi Todo                  cterm=bold      ctermbg=143 ctermfg=16    gui=bold guibg=#afaf5f guifg=#000000
hi Underlined            cterm=underline ctermfg=227 gui=underline guifg=#ffff5f
hi User1                 cterm=bold      ctermbg=236 ctermfg=223   gui=bold guibg=#303030 guifg=#ffdfaf
hi User2                 cterm=none      ctermbg=236 ctermfg=240   gui=none guibg=#303030 guifg=#585858
hi VertSplit             cterm=none      ctermbg=236 ctermfg=103   gui=none guibg=#303030 guifg=#8787af
hi Visual                cterm=none      ctermbg=24  gui=none      guibg=#005f87
hi WarningMsg            cterm=none      ctermbg=58  ctermfg=255   gui=none guibg=#5f5f00 guifg=#eeeeee
hi WildMenu              cterm=bold      ctermbg=35  ctermfg=232   gui=bold guibg=#00af5f guifg=#080808

hi cType                 cterm=bold      ctermfg=71  gui=bold     guifg=#2681df
hi link cStructure cType
hi link cConditional cType

hi cPreProc ctermfg=76  guifg=#5ace01
hi link cInclude cPreProc
hi link cDefine cPreProc
hi link cPreCondit cPreProc
hi link cPreConditMatch cPreProc
hi link cOctalZero cPreProc

hi cNumber ctermfg=79 guifg=#40dfaf
hi link cOctal cNumber
hi cFloat  ctermfg=81 guifg=#40cfff

hi cString ctermfg=214 guifg=#f0ab05
hi link cIncluded cString
hi link cCommentString cString
hi link cComment2String cString

hi cSpecial ctermfg=154 guifg=#abff01
hi link cFormat cSpecial

hi cComment ctermfg=103 guifg=#8888a0
hi link cCommentL cComment
hi link cCommentStart cComment
hi link cCommentSkip cComment
hi link cCommentError cComment


" highlight modes
augroup lettuce
  autocmd!
  autocmd CmdwinLeave * hi User1      ctermbg=236 guibg=#303030
  autocmd CmdwinEnter * hi User1      ctermbg=22  guibg=#005f00
  autocmd InsertLeave * hi User1      ctermbg=236 guibg=#303030
  autocmd InsertEnter * hi User1      ctermbg=52  guibg=#5f0000
  autocmd CmdwinEnter * hi User2      ctermbg=22  guibg=#005f00
  autocmd CmdwinLeave * hi User2      ctermbg=236 guibg=#303030
  autocmd InsertLeave * hi User2      ctermbg=236 guibg=#303030
  autocmd InsertEnter * hi User2      ctermbg=52  guibg=#5f0000
  autocmd CmdwinEnter * hi StatusLine ctermbg=22  guibg=#005f00
  autocmd CmdwinLeave * hi StatusLine ctermbg=236 guibg=#303030
  autocmd InsertLeave * hi StatusLine ctermbg=236 guibg=#303030
  autocmd InsertEnter * hi StatusLine ctermbg=52  guibg=#5f0000
augroup END

" cBlock
" cBracket                            cOperator
" cCharacter                          cParen
" cParenError
" cPreCondit
" cPreConditMatch
" cCurlyError
" cRepeat
" cErrInBracket            cSpaceError
" cErrInParen
" CompletePlaceHolder      cError
" CompletePlaceHolderEnds
" cConstant                cStatement
" cStorageClass
" ConflictMarker
" cLabel
" cMulti
" cTodo
" cUserCont
" cBadBlock
" cUserLabel
" cBadContinuation

" cCppOutIf
" cCppBracket
" cCppInElse
" cCppInElse2
" cCppInIf
" cCppInSkip
" cCppInWrapper
" cCppOut
" cCppOutElse
" cCppParen
" cCppSkip
" cCppString
" cCppOutIf2
" cCppOutSkip
" cCppOutWrapper
"
" cBitField
" cNumbers
" cNumbersCom
