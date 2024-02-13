" filetypeでスキーマを切り替えていたときの名残
function! s:set_highlights() abort
  hi Pmenu        ctermfg=255  ctermbg=240 guifg=#eeeeee guibg=#3a3a3a cterm=NONE gui=NONE
  hi PmenuSel     ctermfg=255  ctermbg=250 guifg=#eaeaea guibg=#5a5a5a cterm=NONE gui=NONE
  hi! link WildMenu    Pmenu

  hi! link LineNr SrceryWhite
  hi! link SignColumn  LineNr
  hi! link FoldColumn  LineNr
  " hi FoldColumn   guifg=#616155 guibg=NONE
  hi! link Folded SrceryWhite

  hi DiagnosticUnderlineError guifg=NONE ctermfg=NONE gui=undercurl

  hi NormalFloat  ctermfg=254  ctermbg=0   guifg=#dedede guibg=#1c1b19 cterm=NONE gui=NONE
  hi Search       ctermfg=75   ctermbg=18  guifg=#eeefff guibg=#404050 cterm=NONE gui=NONE
  " hi IncSearch    ctermfg=56   ctermbg=39  guifg=#eeefff guibg=#4080b0 cterm=NONE gui=NONE
  hi IncSearch    ctermfg=56   ctermbg=39  guifg=#eeefff guibg=#447494 cterm=NONE gui=NONE
  hi VertSplit    guifg=#7C7863 guibg=NONE

  hi ErrorMsg   guifg=#fe90af guibg=none
  " hi Title      ctermfg=118               guifg=#87ff00
  hi Error      ctermfg=161  ctermbg=NONE guifg=#d7005f guibg=NONE
  hi QFError    ctermfg=198               guifg=#ff0087               cterm=NONE gui=NONE
  hi QFWarning  ctermfg=202               guifg=#ff5f00               cterm=NONE gui=NONE
  hi QuickFixLine ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
  hi! link qfFileName SrceryBrightGreen
  hi! link qfLineNr SrceryBrightBlue

  hi Normal guibg=#0c0b09
  " hi! link Comment SrceryBrightBlack
  hi! link Comment SrceryBrightCyan

  " Syntax:
  " :Inspect で確認できる
  hi! link Label SrceryCyan
  hi! link Identifier SrceryWhite
  hi! link Structure SrceryBrightBlue
  hi! link @variable.builtin SrceryYellow
  hi! link @variable.global SrceryCyan
  hi! link @parameter @variable
  hi! link @include @keyword
  hi! link @lsp.type.namespace SrceryWhite " Importのパス部分とか

  " Diff:
  hi DiffAdd     ctermfg=255 ctermbg=163 guifg=#eeeeee guibg=#c7008f
  hi DiffChange  ctermfg=252 ctermbg=22  guifg=#d0d0d0 guibg=#005f00
  hi DiffDelete  ctermfg=200 ctermbg=56  guifg=#3f30c7 guibg=#3f00c7
  hi DiffText    ctermfg=226 ctermbg=29  guifg=#ffff00 guibg=#00875f
  hi diffFile    ctermfg=227             guifg=#fed06e
  hi diffAdded   ctermfg=1               guifg=#c9ea5a
  hi diffRemoved ctermfg=2               guifg=#ff6666

  " treesitter-context
  hi TreesitterContextBottom gui=underline guisp=Grey

  " vim-illuminate
  hi! illuminatedWord guibg=#2f3b3f gui=italic
  hi! link IlluminatedWordText illuminatedWord
  hi! link IlluminatedWordRead illuminatedWord
  hi! link IlluminatedWordWrite illuminatedWord

  " Signify:
  hi SignifySignAdd    ctermfg=70  guifg=#41be30
  hi SignifySignChange ctermfg=226 guifg=#fbff00
  hi SignifySignDelete ctermfg=1   guifg=#ff2222
  hi! link SignifySignChangeDelete    SignifySignDelete
  hi! link SignifySignDeleteFirstLine SignifySignDelete

  " ALE:
  hi ALEVirtualTextError   guifg=#df5e80 guibg=NONE
  hi ALEVirtualTextWarning guifg=#efcb90 guibg=NONE
  hi ALEVirtualTextInfo    guifg=#80cfd0 guibg=NONE

  " Hop:
  hi HopNextKey   guifg=#00dfff gui=bold ctermfg=45 cterm=bold
  hi! link HopNextKey1 HopNextKey
  hi! link HopNextKey2 HopNextKey
  hi HopUnmatched guifg=#666666 ctermfg=242

  " StatusLine:
  hi StatusLine gui=NONE guibg=#20202f
  hi StatusLineNC gui=NONE guibg=#20202f

  " Fidget:
  hi! link FidgetTitle SrceryWhite
  hi! link FidgetTask SrceryWhite

  " gitcommit
  hi! link gitcommitSelectedFile SrceryWhite
  hi! link gitcommitBranch SrceryMagenta
  hi! link gitcommitSummary SrceryWhite
  hi! link gitcommitDiscardedFile gitcommitSelectedFile

  " vim-markdown
  " bgはsrceryで設定できないので直書き
  hi! mkdLineBreak       ctermbg=240 guibg=#585858

  hi! link @text.emphasis.markdown_inline SrceryWhiteItalic
  hi! link @text.strong.markdown_inline SrceryBrightWhiteBold

  hi! link @punctuation.special.markdown SrceryBrightBlue " block quote & list & other keywords
  hi! link @text.quote.markdown SrceryBrightBlue " block quote

  " TODO: after/plugin/srcery.vim に上書きされる
  hi! link TSURI SrceryBrightBlue " https://example.com
  hi! link @text.uri SrceryBrightBlue " https://example.com
  hi! link @text.literal.markdown_inline SrceryBrightYellow " `hoge`
  hi! link @punctuation.delimiter.markdown_inline @text.literal.markdown_inline " `hoge`

  " markdown headers
  hi! link @text.title.1.marker.markdown SrceryBrightMagentaBold
  hi! link @text.title.2.marker.markdown SrceryBrightBlueBold
  hi! link @text.title.3.marker.markdown SrceryBrightGreenBold
  hi! link @text.title.4.marker.markdown SrceryYellowBold
  hi! link @text.title.5.marker.markdown SrceryBrightRedBold
  hi! link @text.title.6.marker.markdown SrceryBrightCyanBold
  hi! link @text.title.1.markdown SrceryWhite
  hi! link @text.title.2.markdown SrceryWhite
  hi! link @text.title.3.markdown SrceryWhite
  hi! link @text.title.4.markdown SrceryWhite
  hi! link @text.title.5.markdown SrceryWhite
  hi! link @text.title.6.markdown SrceryWhite
endfunction

if &g:loadplugins
  hi Normal       ctermfg=252 ctermbg=233 guifg=#F8F8F2 guibg=#1B1D1E
  hi Normal       ctermfg=252 ctermbg=233 guifg=#F8F8F2 guibg=#1B1D1E gui=italic
  hi CursorLine               ctermbg=234               guibg=#293739 cterm=NONE gui=NONE
  hi Visual       cterm=reverse gui=reverse
  hi! link Statement   Visual
  hi! link LineNr      Normal

  colorscheme srcery
  hi SrceryWhiteItalic gui=italic ctermfg=15 guifg=#fce8c3


  " Neovim Terminal Color
  " Generated by
  "   :r !alacritty-color-to-nvim-term
  let g:terminal_color_0 = '#2c2c2c'
  let g:terminal_color_1 = '#ff6666'
  let g:terminal_color_2 = '#c9ea5a'
  let g:terminal_color_3 = '#ffd30a'
  let g:terminal_color_4 = '#5ab6ef'
  let g:terminal_color_5 = '#c397d8'
  let g:terminal_color_6 = '#1bb8b8'
  let g:terminal_color_7 = '#c0c0c0'
  let g:terminal_color_8 = '#666666'
  let g:terminal_color_9 = '#ff3334'
  let g:terminal_color_10 = '#9ec400'
  let g:terminal_color_11 = '#e7c547'
  let g:terminal_color_12 = '#6699ff'
  let g:terminal_color_13 = '#b77ee0'
  let g:terminal_color_14 = '#54ced6'
  let g:terminal_color_15 = '#ffffff'

  call s:set_highlights()
endif
