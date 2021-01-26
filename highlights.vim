if !exists('g:noplugin')
  au myac FileType    * nested call s:set_colors()
  au myac ColorScheme * call s:set_highlights()
endif

function! s:set_common_highlights() abort
  hi Pmenu        ctermfg=255  ctermbg=240 guifg=#eeeeee guibg=#3a3a3a cterm=NONE gui=NONE
  hi PmenuSel     ctermfg=255  ctermbg=250 guifg=#eaeaea guibg=#5a5a5a cterm=NONE gui=NONE
  hi NormalFloat  ctermfg=254  ctermbg=0   guifg=#eeeeee guibg=#131313 cterm=NONE gui=NONE
  hi Search       ctermfg=75   ctermbg=18  guifg=#eeefff guibg=#204080 cterm=NONE gui=NONE
  hi IncSearch    ctermfg=56   ctermbg=39  guifg=#331313 guibg=#40e0e0 cterm=NONE gui=NONE
  hi! link WildMenu Pmenu
endfunction

let g:colors_name = ''
let g:colors_seted = 0
hi Normal       ctermfg=252 ctermbg=233 guifg=#F8F8F2 guibg=#1B1D1E
hi Visual       cterm=reverse gui=reverse
hi CursorLine                ctermbg=234               guibg=#293739 cterm=NONE gui=NONE
call s:set_common_highlights()

hi! link Statement Visual
hi! link LineNr      Normal
hi! link FoldColumn  LineNr
hi! link SignColumn  LineNr
hi clear TabLineFill

" colorschemaの重複読み込みを避ける
function! s:colorscheme(name) abort "{{{
  if g:colors_name !=# a:name
    try
      execute 'colorscheme' a:name
    catch /Cannot find color scheme/
      echomsg printf("catch: Cannot find color scheme '%s'", a:name)
    endtry
  endif
endfunction "}}}

function! s:set_colors() "{{{
  if 0 != g:colors_seted
    return
  endif

  if -1 != index(['', 'denite', 'denite-filter', 'quickrun', 'qf'], &filetype)
    return
  endif

  if &filetype ==# 'ruby'
    call s:colorscheme('railscasts')
  elseif &filetype ==# 'gitcommit'
    call s:colorscheme('gitcommit')
  elseif &filetype =~# '\v(markdown)'
    call s:colorscheme('PaperColor')
  else
    call s:colorscheme('srcery')
  endif

  let g:colors_seted = 1
endfunction "}}}

function! s:set_highlights() "{{{
  call s:set_common_highlights()

  hi Title      ctermfg=118               guifg=#87ff00
  hi Error      ctermfg=161  ctermbg=NONE guifg=#d7005f guibg=NONE
  hi QFError    ctermfg=198               guifg=#ff0087               cterm=NONE gui=NONE
  hi QFWarning  ctermfg=202               guifg=#ff5f00               cterm=NONE gui=NONE
  hi QuickFixLine ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE

  hi DiffAdd    ctermfg=255  ctermbg=163  guifg=#eeeeee guibg=#d700af
  hi DiffDelete ctermfg=200  ctermbg=56   guifg=#ff00d7 guibg=#5f00d7
  hi DiffChange ctermfg=252  ctermbg=22   guifg=#d0d0d0 guibg=#005f00
  hi DiffText   ctermfg=226  ctermbg=29   guifg=#ffff00 guibg=#00875f

  hi htmlBold   ctermfg=255               guifg=#ffffff               cterm=bold      gui=bold
  hi! link reviewImage PreProc

  hi SignifySignAdd    ctermfg=70  guifg=#41be30
  hi SignifySignChange ctermfg=226 guifg=#fbff00
  hi SignifySignDelete ctermfg=1   guifg=#ff2222
  hi! link SignifySignChangeDelete    SignifySignDelete
  hi! link SignifySignDeleteFirstLine SignifySignDelete

  hi ALEVirtualTextError guifg=#f0fff0 guibg=#000000
  hi ALEVirtualTextWarning guifg=#f0fff0 guibg=#000000
  hi ALEVirtualTextInfo guifg=#f0fff0 guibg=#000000

  if &diff
    hi clear CursorLine
  endif

  if g:colors_name ==? 'papercolor'
    hi Normal                         ctermbg=234                guibg=#1c1c1c
    hi LineNr            ctermfg=244               guifg=#9494c0
    hi CursorLine        ctermfg=NONE ctermbg=238  guifg=NONE    guibg=#454545
    hi CursorColumn                   ctermbg=235                guibg=#363626
    hi SpecialKey        ctermfg=46                guifg=#00ff00
    hi Comment           ctermfg=111               guifg=#87afff
    hi Number            ctermfg=75                guifg=#5fafff
    hi Folded            ctermfg=84   ctermbg=0    guifg=#8fe801 guibg=#000000
    hi FoldColumn        ctermfg=190               guifg=#e6ff01
    hi StatusLine        ctermfg=118  ctermbg=234  guifg=#87ff00 guibg=#1c1c1c cterm=NONE gui=NONE
    hi WildMenu          ctermfg=16   ctermbg=118  guifg=#000000 guibg=#87ff00

    hi mkdLineBreak      ctermbg=240 guibg=#585858

    hi goDirective       ctermfg=35   guifg=#20af40
    hi goFormatSpecifier ctermfg=207  guifg=#ff50ff
    hi goSpecialString   ctermfg=226  guifg=#ffff00
    hi! link goConditional goDeclaration
  elseif g:colors_name ==? 'srcery'
    hi SrceryCyan guifg=#0cc8c3
    hi SrceryBlue guifg=#5ab6ef
    hi SrceryBrightBlack guifg=#b1a195
    hi! link Comment SrceryBrightBlack
  elseif g:colors_name ==? 'molokai'
    hi LineNr   ctermfg=250  ctermbg=236  guifg=#b6c4c7 guibg=#232526
    hi Folded   ctermfg=63                guifg=#6e9efe
    hi Comment  ctermfg=245               guifg=#aaaaaa
    hi NonText  ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE
  endif
endfunction "}}}
