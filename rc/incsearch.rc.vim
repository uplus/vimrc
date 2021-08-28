" Incsearch:

let g:incsearch#no_inc_hlsearch        = 0    " 他のwindowではハイライトしない
let g:incsearch#auto_nohlsearch        = 1    " 自動でハイライトを消す
let g:incsearch#consistent_n_direction = 1    " 1:nで常にforwardに移動
let g:incsearch#magic                  = '\v' " very magic

map / <Plug>(incsearch-index-/)
map ? <Plug>(incsearch-index-?)
map z/ <Plug>(incsearch-index-stay)

map * <Plug>(incsearch-nohl-*)<Plug>(anzu-update-search-status-with-echo)
map # <Plug>(incsearch-nohl-#)<Plug>(anzu-update-search-status-with-echo)
map z* <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)<Plug>(anzu-update-search-status-with-echo)
map z# <Plug>(incsearch-nohl0)<Plug>(asterisk-z#)<Plug>(anzu-update-search-status-with-echo)

xmap * <Plug>(incsearch-nohl)<Plug>(asterisk-g*)<Plug>(anzu-update-search-status-with-echo)
xmap # <Plug>(incsearch-nohl)<Plug>(asterisk-g#)<Plug>(anzu-update-search-status-with-echo)
xmap z* <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)<Plug>(anzu-update-search-status-with-echo)
xmap z# <Plug>(incsearch-nohl0)<Plug>(asterisk-gz#)<Plug>(anzu-update-search-status-with-echo)

" nnoremap <expr> n anzu#mode#mapexpr('n', '', 'zzzv')
" nnoremap <expr> N anzu#mode#mapexpr('N', '', 'zzzv')
map  n <Plug>(incsearch-nohl-n)
map  N <Plug>(incsearch-nohl-N)
nmap n <Plug>(incsearch-nohl)<Plug>(anzu-n)zzzv
nmap N <Plug>(incsearch-nohl)<Plug>(anzu-N)zzzv
