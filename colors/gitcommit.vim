set t_Co=256
let g:colors_name = expand('<sfile>:t:r')

highlight gitcommitSummary  ctermfg=190 guifg=#d7ff00
highlight gitcommitBranch   ctermfg=199 guifg=#ff00af
highlight gitcommitWarning  ctermfg=200 guifg=#ff00d7
highlight gitcommitComment  ctermfg=179 guifg=#d7af5f
highlight link gitcommitOnBranch gitcommitComment 
highlight link gitcommitHeader   gitcommitComment 
highlight gitcommitType     ctermfg=45 guifg=#00d7ff
highlight gitcommitFile     ctermfg=147 guifg=#afafff
highlight link gitcommitUnmergedFile gitcommitWarning 
highlight gitcommitDiff ctermfg=255 guifg=#eeeeee

highlight CursorLine    term=NONE cterm=NONE gui=NONE
highlight diffFile      ctermfg=196 guifg=#ff0000
highlight link diffNewFile diffFile 
highlight diffSubname   ctermfg=220 guifg=#ffd700
highlight diffLine      ctermfg=214 guifg=#ffaf00
highlight diffAdded     ctermfg=36 guifg=#00af87
highlight diffRemoved   ctermfg=105 guifg=#8787ff
