if !exists('g:noplugin')
  au myac FileType    * nested call s:set_colors()
  au myac ColorScheme * call s:set_highlights()
  au myac WinEnter,BufRead,BufNew,Syntax * :silent! call matchadd('Todo', '\v(TODO|NOTE|INFO|XXX|TEMP)\ze:?')
endif

let g:colors_name = ''
let g:colors_seted = 0
hi Normal       ctermfg=252 ctermbg=233 guifg=#F8F8F2 guibg=#1B1D1E
hi CursorLine               ctermbg=234               guibg=#293739 cterm=NONE gui=NONE
hi Visual       cterm=reverse gui=reverse
hi Pmenu        ctermfg=240  ctermbg=251 guifg=#585858 guibg=#c6c6c6
hi PmenuSel     ctermfg=0    ctermbg=255 guifg=#000000 guibg=#eeeeee
hi BadSpace     cterm=NONE

hi! link Statement Visual
hi! link NormalFloat Normal
hi! link LineNr      Normal
hi! link FoldColumn  LineNr
hi! link SignColumn  LineNr
hi clear TabLineFill

function! s:colorscheme(name) abort
  if g:colors_name !=# a:name
    try
      execute 'colorscheme' a:name
    catch /Cannot find color scheme/
      echomsg printf("catch: Cannot find color scheme '%s'", a:name)
    endtry
  endif
endfunction

function! s:set_colors() "{{{
  if 0 != g:colors_seted
    return
  endif

  if -1 != index(['', 'denite', 'denite-filter', 'quickrun', 'qf'], &filetype)
    return
  endif

  " Bug when using PaperColor(only when the zsh.snippets)
  set background=dark

  if &filetype ==# 'ruby'
    call s:colorscheme('railscasts')
  elseif &filetype ==# 'gitcommit'
    call s:colorscheme('gitcommit')
  elseif &filetype =~# '\v(markdown|python|go)'
    call s:colorscheme('PaperColor')
  else
    call s:colorscheme('molokai')
  endif

  let g:colors_seted = 1
endfunction "}}}

function! s:set_highlights() "{{{
  hi Search     ctermfg=75   ctermbg=18   guifg=#efefef guibg=#204060 cterm=italic    gui=italic
  hi IncSearch  ctermbg=39   ctermfg=56   guibg=#00afff guifg=#5f00d7 cterm=italic    gui=italic
  hi Title      ctermfg=118               guifg=#87ff00
  hi Todo       ctermfg=208  ctermbg=0    guifg=#ffb000 guibg=#000000 cterm=italic    gui=italic
  hi Error      ctermfg=255  ctermbg=161  guifg=#eeeeee guibg=#d7005f
  hi QFError    ctermfg=198               guifg=#ff0087               cterm=undercurl gui=undercurl
  hi QFWarning  ctermfg=202               guifg=#ff5f00               cterm=undercurl gui=undercurl
  hi QuickFixLine ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE

  hi DiffAdd    ctermfg=255  ctermbg=163  guifg=#eeeeee guibg=#d700af
  hi DiffDelete ctermfg=200  ctermbg=56   guifg=#ff00d7 guibg=#5f00d7
  hi DiffChange ctermfg=252  ctermbg=22   guifg=#d0d0d0 guibg=#005f00
  hi DiffText   ctermfg=226  ctermbg=29   guifg=#ffff00 guibg=#00875f

  hi htmlBold   ctermfg=255               guifg=#ffffff               cterm=bold      gui=bold
  hi! link reviewImage PreProc

  colorscheme vimfiler_color

  hi SignifySignAdd    ctermfg=70  guifg=#41be30
  hi SignifySignChange ctermfg=226 guifg=#fbff00
  hi SignifySignDelete ctermfg=1   guifg=#ff2222
  hi! link SignifySignChangeDelete    SignifySignDelete
  hi! link SignifySignDeleteFirstLine SignifySignDelete

  if &diff
    hi clear CursorLine
  endif

  if g:colors_name ==? 'papercolor'
    hi Normal                         ctermbg=234                guibg=#1c1c1c
    hi LineNr            ctermfg=244               guifg=#808080
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

    " hi vimString         ctermfg=155 guifg=#afff5f
    " hi vimVar            ctermfg=226 guifg=#ffff00
    " hi vimFuncName       ctermfg=135 guifg=#af5fff
    " hi vimLet            ctermfg=77  guifg=#50df3f
    " hi vimCommand        ctermfg=37  guifg=#00b0a0
    " hi clear vimFunction
    " hi! link vimNotFunc vimCommand
    " hi! link vimOperParen vimFuncVar

    hi goDirective       ctermfg=35 guifg=#20af40
    hi goFormatSpecifier ctermfg=207 guifg=#ff50ff
    hi goSpecialString   ctermfg=226 guifg=#ffff00
    hi! link goConditional goDeclaration
  elseif g:colors_name ==? 'molokai'
    hi   Folded        ctermfg=63   guifg=#5f5fff
    hi   Comment       ctermfg=245  guifg=#8a8a8a
    hi   NonText       ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE
  endif
endfunction "}}}
