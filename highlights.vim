if !exists('g:noplugin')
  au u10ac FileType    * nested call s:set_colors()
  au u10ac ColorScheme * call s:set_highlights()
endif

let g:colors_name = ''
let g:colors_seted = 0
hi CursorLine term=NONE cterm=NONE
hi LineNr     term=NONE ctermfg=44
hi FoldColumn term=NONE ctermbg=NONE
hi StatusLine cterm=NONE
hi Visual     cterm=reverse
hi Pmenu      ctermfg=240  ctermbg=251
hi PmenuSel   ctermfg=0    ctermbg=255
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
    hi LineNr ctermfg=245
    hi Pmenu ctermfg=36 ctermbg=235
  elseif &filetype == 'ruby'
    call s:colorscheme('railscasts_u10')
  elseif &filetype == 'gitcommit'
    call s:colorscheme('gitcommit_u10')
  elseif g:colors_seted == 0
    call s:colorscheme('PaperColor')
  endif

  " Bug when using PaperColor(only when the zsh.snippets)
  " set background=dark
  let g:colors_seted = 1
endfunction "}}}

function! s:set_highlights() "{{{
  hi Title      ctermfg=118
  hi Todo       cterm=italic    ctermfg=226 ctermbg=0
  hi Error      ctermfg=255     ctermbg=161
  hi QFError    cterm=undercurl ctermfg=198
  hi QFWarning  cterm=undercurl ctermfg=202
  hi DiffAdd    ctermfg=255     ctermbg=163
  hi DiffDelete ctermfg=200     ctermbg=56
  hi DiffChange ctermfg=252     ctermbg=22
  hi DiffText   ctermfg=226     ctermbg=29

  colorscheme vimfiler_color

  if !has('vim_starting')
    execute 'AirlineTheme' g:airline_theme
  endif

  if &diff
    hi clear CursorLine
  endif

  if g:colors_name == 'PaperColor'
    hi PmenuSel     ctermfg=232   ctermbg=30    cterm=NONE
    hi Normal                     ctermbg=234
    hi LineNr       ctermfg=244
    hi CursorColumn               ctermbg=235
    hi SpecialKey   ctermfg=46
    hi Comment      ctermfg=111
    hi Number       ctermfg=75
    " hi Folded       ctermfg=0     ctermbg=38
    hi Folded       ctermfg=75     ctermbg=NONE
    hi StatusLine   ctermfg=118   ctermbg=234 cterm=NONE
    hi WildMenu     ctermfg=16    ctermbg=118

    hi mkdLineBreak ctermbg=240

    hi vimString    ctermfg=155
    hi vimVar       ctermfg=226
    hi vimFuncName  ctermfg=135
    hi vimLet       ctermfg=83

    hi pythonInclude     ctermfg=75
    hi pythonConditional ctermfg=69
    hi pythonStatement   ctermfg=147
    hi pythonString      ctermfg=220
    hi pythonEscape      ctermfg=202
    hi pythonBuiltin     ctermfg=111
    hi pythonComment     ctermfg=147

    hi! link pythonRepeat pythonConditional
    hi! link vimOperParen vimFuncVar
  elseif g:colors_name == 'molokai'
    hi Folded       ctermfg=63
    hi Comment      ctermfg=245
    hi Pmenu        ctermfg=232   ctermbg=6
    hi PmenuSel     ctermfg=232   ctermbg=32
    hi NonText      ctermfg=NONE  ctermbg=NONE
  elseif g:colors_name == 'BusyBee'
    hi Normal                     ctermbg=233
    hi Folded       ctermfg=0     ctermbg=4
    hi FoldColumn   ctermfg=14    ctermbg=233
    hi Visual       ctermfg=NONE  ctermbg=NONE
    hi NonText      ctermfg=NONE  ctermbg=NONE
    hi CursorLine                 ctermbg=234   cterm=NONE
    hi vimFuncVar   ctermfg=198
  endif
endfunction "}}}
