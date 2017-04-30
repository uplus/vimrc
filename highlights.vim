if !exists('g:noplugin')
  au myac FileType    * nested call s:set_colors()
  au myac ColorScheme * call s:set_highlights()
endif

let g:colors_name = ''
let g:colors_seted = 0
hi CursorLine cterm=NONE gui=NONE
hi LineNr     cterm=NONE ctermfg=44 guifg=#00d7d7 gui=NONE
hi FoldColumn cterm=NONE ctermbg=NONE guibg=NONE gui=NONE
hi StatusLine cterm=NONE gui=NONE guibg=#000000
hi Visual     cterm=reverse gui=reverse
hi Pmenu      ctermfg=240  ctermbg=251 guifg=#585858 guibg=#c6c6c6
hi PmenuSel   ctermfg=0    ctermbg=255 guifg=#000000 guibg=#eeeeee
hi BadSpace   cterm=NONE
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

  if -1 != index(['', 'unite', 'quickrun', 'qf'], &filetype)
    return
  endif

  " set background=dark

  if &filetype == 'cpp' || &filetype == 'c'
    call s:colorscheme('lettuce')
    " call s:colorscheme('kalisi')
    hi LineNr ctermfg=245 guifg=#8a8a8a
    hi Pmenu ctermfg=36 ctermbg=235 guifg=#00af87 guibg=#262626
  elseif &filetype == 'ruby'
    call s:colorscheme('railscasts')
  elseif &filetype == 'gitcommit'
    call s:colorscheme('gitcommit')
  elseif g:colors_seted == 0
    call s:colorscheme('PaperColor')
  endif

  " Bug when using PaperColor(only when the zsh.snippets)
  " set background=dark
  let g:colors_seted = 1
endfunction "}}}

function! s:set_highlights() "{{{
  hi Title      ctermfg=118               guifg=#87ff00
  hi Todo       ctermfg=208  ctermbg=0    guifg=#ffb000 guibg=#000000 cterm=italic    gui=italic
  hi Error      ctermfg=255  ctermbg=161  guifg=#eeeeee guibg=#d7005f
  hi QFError    ctermfg=198               guifg=#ff0087               cterm=undercurl gui=undercurl
  hi QFWarning  ctermfg=202               guifg=#ff5f00               cterm=undercurl gui=undercurl
  hi DiffAdd    ctermfg=255  ctermbg=163  guifg=#eeeeee guibg=#d700af
  hi DiffDelete ctermfg=200  ctermbg=56   guifg=#ff00d7 guibg=#5f00d7
  hi DiffChange ctermfg=252  ctermbg=22   guifg=#d0d0d0 guibg=#005f00
  hi DiffText   ctermfg=226  ctermbg=29   guifg=#ffff00 guibg=#00875f
  hi htmlBold   ctermfg=255               guifg=#ffffff               cterm=bold      gui=bold

  colorscheme vimfiler_color

  if !has('vim_starting') && exists('g:airline_theme')
    execute 'AirlineTheme' g:airline_theme
  endif

  hi GitGutterAdd    ctermfg=70  guifg=#41be30
  hi GitGutterChange ctermfg=226 guifg=#fbff00
  hi link GitGutterChangeDelete GitGutterChange

  if &diff
    hi clear CursorLine
  endif

  if g:colors_name == 'PaperColor'
    hi PmenuSel          ctermfg=255  ctermbg=30   guifg=#ffffff guibg=#008787 cterm=NONE gui=NONE
    hi Normal                         ctermbg=234                guibg=#1c1c1c
    hi LineNr            ctermfg=244               guifg=#808080
    hi CursorColumn                   ctermbg=235                guibg=#262626
    hi SpecialKey        ctermfg=46                guifg=#00ff00
    hi Comment           ctermfg=111               guifg=#87afff
    hi Number            ctermfg=75                guifg=#5fafff
    hi Folded            ctermfg=84   ctermbg=0    guifg=#8fe801 guibg=#000000
    hi FoldColumn        ctermfg=190               guifg=#e6ff01
    hi StatusLine        ctermfg=118  ctermbg=234  guifg=#87ff00 guibg=#1c1c1c cterm=NONE gui=NONE
    hi WildMenu          ctermfg=16   ctermbg=118  guifg=#000000 guibg=#87ff00

    hi mkdLineBreak      ctermbg=240 guibg=#585858

    hi vimString         ctermfg=155 guifg=#afff5f
    hi vimVar            ctermfg=226 guifg=#ffff00
    hi vimFuncName       ctermfg=135 guifg=#af5fff
    hi vimLet            ctermfg=83  guifg=#5fff5f
    hi! link vimOperParen vimFuncVar

    hi pythonInclude     ctermfg=75  guifg=#5fafff
    hi pythonConditional ctermfg=69  guifg=#5f87ff
    hi pythonStatement   ctermfg=147 guifg=#afafff
    hi pythonString      ctermfg=220 guifg=#ffd700
    hi pythonEscape      ctermfg=202 guifg=#ff5f00
    hi pythonBuiltin     ctermfg=111 guifg=#87afff
    hi pythonComment     ctermfg=147 guifg=#afafff
    hi! link pythonRepeat pythonConditional

    hi! link goConditional goDeclaration
    hi goDirective       ctermfg=35 guifg=#20af40
  elseif g:colors_name == 'molokai'
    hi   Folded        ctermfg=63   guifg=#5f5fff
    hi   Comment       ctermfg=245  guifg=#8a8a8a
    hi   Pmenu         ctermfg=232  ctermbg=6    guifg=#080808 guibg=#008080
    hi   PmenuSel      ctermfg=232  ctermbg=32   guifg=#080808 guibg=#0087d7
    hi   NonText       ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE
  elseif g:colors_name == 'BusyBee'
    hi   Normal        ctermbg=233  guibg=#121212
    hi   Folded        ctermfg=0    ctermbg=4    guifg=#000000 guibg=#000080
    hi   FoldColumn    ctermfg=14   ctermbg=233  guifg=#00ffff guibg=#121212
    hi   Visual        ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE
    hi   NonText       ctermfg=NONE ctermbg=NONE guifg=NONE    guibg=NONE
    hi   CursorLine    ctermbg=234  cterm=NONE   guibg=#1c1c1c gui=NONE
    hi   vimFuncVar    ctermfg=198  guifg=#ff0087
  endif
endfunction "}}}
