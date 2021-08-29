" incsearchとの対応
" <tab>     <c-g>
" <s-tab>   <c-t>

let g:is#do_default_mappings = 0

" :nohlsearchはautocmdでは上手く動かないのでオプションを無効にする
au myac BufLeave,InsertEnter,CmdlineLeave * silent set nohlsearch
" CursorMoved  " * 移動で無効になってしまう
" CmdlineEnter " z* でハイライトが効かない

nnoremap / <cmd>set hlsearch<cr>/
nnoremap ? <cmd>set hlsearch<cr>?

map * <cmd>set hlsearch<cr><Plug>(is-*)
map # <cmd>set hlsearch<cr><Plug>(is-#)
map z* <cmd>set hlsearch<cr>*N<Plug>(is-nohl)
map z# <cmd>set hlsearch<cr>#N<Plug>(is-nohl)

map n <cmd>set hlsearch<cr><Plug>(is-n)
map N <cmd>set hlsearch<cr><Plug>(is-N)

" NOTE: hlsearchが有効かどうかで分岐できそう
cmap <m-j> <Plug>(is-scroll-f)
cmap <m-k> <Plug>(is-scroll-b)
map <m-j> <cmd>set hlsearch<cr><Plug>(is-scroll-f)<Plug>(is-nohl)
map <m-k> <cmd>set hlsearch<cr><Plug>(is-scroll-b)<Plug>(is-nohl)

" TODO: asteriskだとハイライトが自動で消えなくなる
" NOTE: 検索時のみタブの挙動を変えるのはだいぶ面倒
" deniteとかで別のバッファー開くとハイライトを消せない
" NOTE: / ? * # n N でset hlsearchすれば良さそう
