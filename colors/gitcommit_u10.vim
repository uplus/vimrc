set t_Co=256
let g:colors_name = "gitcommit_u10"

highlight gitcommitSummary  ctermfg=190
highlight gitcommitBranch   ctermfg=199
highlight gitcommitWarning  ctermfg=200
highlight gitcommitComment  ctermfg=179
highlight link gitcommitOnBranch gitcommitComment
highlight link gitcommitHeader   gitcommitComment
highlight gitcommitType     ctermfg=45
highlight gitcommitFile     ctermfg=147
highlight link gitcommitUnmergedFile gitcommitWarning
highlight gitcommitDiff ctermfg=255

highlight CursorLine    term=NONE cterm=NONE
highlight diffFile      ctermfg=196
highlight link diffNewFile diffFile
highlight diffSubname   ctermfg=220
highlight diffLine      ctermfg=214
highlight diffAdded     ctermfg=36
highlight diffRemoved   ctermfg=105
