" Keymaps:

" Vim Original Keymaps: "{{{
noremap <Plug>(vim-original-visual) v
noremap <Plug>(vim-original-visualline) V
noremap <Plug>(vim-original-visualblock) <c-v>
noremap <Plug>(vim-original-start) 0
noremap <Plug>(vim-original-last) $
noremap <Plug>(vim-original-front) ^
noremap <Plug>(vim-original-tail) g_

inoremap <Plug>(vim-original-insert-lasttext) <c-a>
"}}}

" Vim Basic Command Keymaps: "{{{
nnoremap <silent><Plug>(u10-botright) <cmd>botright split<cr>
nnoremap <silent><Plug>(u10-vertical) <cmd>vertical split<cr>
nnoremap <silent><Plug>(u10-undojoin) <cmd>undojoin<cr>
"}}}

" NeoVim Terminal: "{{{
if has('nvim')
  tnoremap <esc> <c-\><c-n>
  " tmap jj <esc>
  " tnoremap <c-h> <c-\><c-n><c-w>h
  " tnoremap <c-j> <c-\><c-n><c-w>j
  " tnoremap <c-k> <c-\><c-n><c-w>k
  " tnoremap <c-l> <c-\><c-n><c-w>l
  " <c-w>tはマップが存在する

  nnoremap <silent>,s <cmd>call my#terminal#working_terminal()<cr>

  tnoremap <c-t>h <c-\><c-n><c-w>h
  tnoremap <c-t>j <c-\><c-n><c-w>j
  tnoremap <c-t>k <c-\><c-n><c-w>k
  tnoremap <c-t>l <c-\><c-n><c-w>l

  nnoremap <c-t>h <c-w>hI
  nnoremap <c-t>j <c-w>jI
  nnoremap <c-t>k <c-w>kI
  nnoremap <c-t>l <c-w>lI
endif "}}}

" Toggle Options: "{{{
nnoremap \toc :set cursorcolumn!<CR>
nnoremap \ton :set number!<CR>
nnoremap \tor :set relativenumber!<CR>
nnoremap \tow :set wrap!<CR>
nnoremap \tol :set list!<CR>
"}}}

" Text Move: "{{{
" <cmd> だと複数行選択時の挙動が変わる
nnoremap <silent><Plug>(MoveUp)   :<c-u>call my#ot#text_move(v:count1, 1, 0)<cr>
nnoremap <silent><Plug>(MoveDown) :<c-u>call my#ot#text_move(v:count1, 0, 0)<cr>
xnoremap <silent><Plug>(MoveUp)   :<c-u>call my#ot#text_move(v:count1, 1, 1)<cr>
xnoremap <silent><Plug>(MoveDown) :<c-u>call my#ot#text_move(v:count1, 0, 1)<cr>
"}}}

" BlankUp: "{{{
nnoremap <silent><Plug>(BlankUp)   <cmd>call my#ot#blank_up(v:count1)<cr>
nnoremap <silent><Plug>(BlankDown) <cmd>call my#ot#blank_down(v:count1)<cr>
"}}}

" Substitute: {{{
nnoremap ss :%s/
nnoremap sw :%s/<c-r><c-w>
nnoremap sW :%s/<c-r><c-a>

xnoremap ss :s/
xnoremap sw :s/<c-r><c-w>
xnoremap sW :s/<c-r><c-a>
"}}}

nmap <plug>(delete_for_match) <Plug>(vim-original-visualline)^%d
nnoremap <silent>=<cr> <cmd>call Format()<cr>

nnoremap <silent>,gd :OpenGitDiffWin<cr>
nnoremap <silent>,gt :Tig<cr>
nnoremap <silent>gst :WordTranslate<cr>
" nnoremap <silent>gsg <cmd>call vimrc#goldendict()<cr>
nnoremap <silent><space>n :call ResetHighlights()<cr>:nohlsearch<cr>

" inoremap <silent><expr><c-j> pumvisible()? "\<c-y>" : "\<cr>"
imap <c-j> <cr>
" inoremap jj <esc>
xnoremap <space>n :normal<space>

nnoremap ,,,,,,,,,,,,, <cmd>set titlestring=Hello<cr>

" Ctrl /
" Use <c-r>.
" imap  <plug>(vim-original-insert-lasttext)

" ファイル再読込
nnoremap <silent>,ee :e!<cr>
nnoremap <silent>,ea :bufdo e!<cr>

if &clipboard ==# 'unnamedplus'
  noremap! <c-r><c-r> <c-r>+
else
  noremap! <c-r><c-r> <c-r>*
endif
nnoremap g?? Vg?
map mp %
map mmp ^%
nnoremap ,i ".p
nnoremap ,p "0p
nnoremap <Plug>(select-pasted) '[<S-v>']
nmap ,v <Plug>(select-pasted)
nmap dmp <Plug>(delete_for_match)
nmap <Space>J <Plug>(MoveDown)kJ
nnoremap <silent>( {<cmd>exec ('' ==# getline('.')? 'normal! j' : '')<cr>
nnoremap <silent>) }<cmd>exec ('' ==# getline('.')? 'normal! k' : '')<cr>
xnoremap <silent>( {<cmd>exec 'normal! gv' . ('' ==# getline("'<")? 'j' : '')<cr>
xnoremap <silent>) }<cmd>exec 'normal! gv' . ('' ==# getline("'>")? 'k' : '')<cr>
nmap >p p:'[,']><CR>
nmap <p p:'[,']<<CR>
nmap =p p=']
" nnoremap <space>o {o
" nnoremap <space>O }O

nnoremap <c-p> :<c-p>
vnoremap <c-p> :<c-p>
vnoremap <c-n> :<c-n>

" #overwrite
inoremap <c-c> <esc>
xmap u <esc>u
nmap Y yg_
nnoremap <c-]> g<c-]>
nnoremap g<c-]> <c-]>
nnoremap <c-w><c-]> <c-w>g<c-]>
nnoremap <c-w>g<c-]> <c-w><c-]>
nnoremap <c-w>] <c-w>g]
nnoremap <c-w>g] <c-w>]
nnoremap v V
nnoremap V v
xnoremap <c-a> <c-a>gv
xnoremap <c-x> <c-x>gv
nnoremap <c-y> 4<c-y>
xnoremap <c-y> 4<c-y>
nnoremap <c-e> 4<c-e>
xnoremap <c-e> 4<c-e>
nnoremap zl 4zl
nnoremap zh 4zh
" nnoremap 0 ^
" nnoremap ^ 0
" nnoremap - $
" xnoremap 0 ^
" xnoremap ^ 0
" xnoremap - $

" #save "{{{
if has('nvim')
  inoremap <m-s> <esc>ZZ
  nnoremap <m-s> ZZ
else
  inoremap s <esc>ZZ
  nnoremap s ZZ
end

" いろんなイベント発生させるからupdateよりwriteのほうがいい
inoremap <silent><c-s> <esc>:write!<cr>
nnoremap <silent><c-s> :write!<cr>
nnoremap Zz ZZ
nnoremap Zq ZQ
" inoremap <c-z>eq <esc>:qall!<cr>
"}}}

" #undo "{{{
nnoremap <silent>,uf :earlier 1f<CR>
nnoremap <silent>,ud :earlier 1d<CR>
nnoremap <silent>,uc :UndoClear<CR>
nnoremap <silent>,uw :e!<CR>
nnoremap <silent>,u <Nop>
"}}}

" #buffer close "{{{
nnoremap <silent>,dd :bd<CR>
nnoremap <silent>,dq :q<CR>
nnoremap <silent>,da :qall<CR>
nnoremap <silent>,dw :wqall<CR>
"}}}

" #fold "{{{
" こういうマッピングは良くない
" nnoremap zr zR
" nnoremap zR zr
" nnoremap zm zM
" nnoremap zM zm
"}}}

" #buffer "{{{
nnoremap <silent>,ba <cmd>call my#buffer#active_only()<CR>
nnoremap <silent>,bo :only<CR>
nnoremap <silent>,bt :tabonly<CR>
nnoremap <silent>,bl :ls<CR>
nnoremap <silent>,bh :ls!<CR>
nnoremap <silent>,bb :b#<CR>
nnoremap <silent>,bd :bd<CR>
nnoremap <silent>,bq :q<CR>
"}}}

" #gf open file "{{{
" auto remap to <Plug> is difficult
if !hasmapto('gf')
  nnoremap gfb gf
  nnoremap <silent>gft <c-w>gf
  nnoremap <silent>gfv :vertical wincmd f<cr>
  nnoremap <silent>gfs :botright wincmd f<cr>
  nnoremap gf<esc> <nop>
endif
"}}}

" #input "{{{
imap <c-x>] <c-x><c-]>
imap <c-x>a <c-x><c-a>
imap <c-x>b <c-x><c-b>
imap <c-x>d <c-x><c-d>
imap <c-x>f <c-x><c-f>
imap <c-x>g <c-x><c-g>
imap <c-x>i <c-x><c-i>
imap <c-x>k <c-x><c-k>
imap <c-x>l <c-x><c-l>
imap <c-x>n <c-x><c-n>
imap <c-x>o <c-x><c-o>
imap <c-x>p <c-x><c-p>
imap <c-x>r <c-x><c-r>
imap <c-x>s <c-x><c-s>
imap <c-x>u <c-x><c-u>
imap <c-x>v <c-x><c-v>
imap <c-x>z <c-x><c-z>
" inoremap <c-x> <nop> " cannot execute <c-x><c-u>

" cursor move
imap <c-x>e <c-x><c-e>
imap <c-x>y <c-x><c-y>
"}}}

" #move "{{{
" imap <up> <c-o>gk
" imap <down> <c-o>gj
nmap <up> k
nmap <down> j
nmap <left> h
nmap <right> l
vmap <up> k
vmap <down> j
vmap <left> h
vmap <right> l

" nnoremap k gk
" nnoremap j gj
" nnoremap gk k
" nnoremap gj j
" vnoremap k gk
" vnoremap j gj
" vnoremap gk k
" vnoremap gj j

nnoremap <silent><expr>h foldclosed('.') != -1? "zo" : "h"
nnoremap <silent><expr>l foldclosed('.') != -1? "zO" : "l"

"}}}

" Readline Bind: "{{{
inoremap <c-a> <c-o>^
inoremap <c-e> <c-o>$
imap <c-d> <del>
imap <c-h> <bs>

inoremap <c-w> <c-g>u<c-w>
inoremap <c-u> <c-g>u<c-u>
inoremap <c-k> <c-o>"_D

cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-d> <del>

cnoremap <expr><c-k> my#cmdline#delete_to_end()
cnoremap <expr><m-d> my#cmdline#delete_to_next_word()
cnoremap <expr><m-w> my#cmdline#delete_to_next_word()
cnoremap <expr><m-f> my#cmdline#move_to_next_word()
cnoremap <expr><m-b> my#cmdline#move_to_prev_word()

" swap: upは現在の入力を元に履歴を辿る
cnoremap <c-p> <up>
cnoremap <c-n> <down>
cnoremap <up> <c-p>
cnoremap <down> <c-n>

" noremap! is insert+command
noremap! <c-b> <left>
noremap! <c-f> <right>
"}}}

" #alt keybind "{{{
inoremap <m-w> <c-o>dw
inoremap <m-f> <c-o>w
inoremap <m-b> <c-o>b
" inoremap <nowait><esc> <esc>
"}}}

" #non register delete "{{{
nnoremap _c "_c
vnoremap _c "_c
nnoremap _d "_d
vnoremap _d "_d
nnoremap _C "_C
vnoremap _C "_C
nnoremap _D "_D
vnoremap _D "_D
nnoremap _x "_x
vnoremap _x "_x
nnoremap _X "_X
vnoremap _X "_X
"}}}

" Pair Map: "{{{
nnoremap <silent>[c :cbefore<cr>
nnoremap <silent>]c :cafter<cr>
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap <silent><expr><Plug>(smart_gt) tabpagenr('$') == 1 ? ':bnext<cr>' : ':wincmd gt<cr>'
nnoremap <silent><expr><Plug>(smart_gT) tabpagenr('$') == 1 ? ':bprevious<cr>' : ':wincmd gT<cr>'

nmap [e <Plug>(MoveUp)
nmap ]e <Plug>(MoveDown)
xmap [e <Plug>(MoveUp)
xmap ]e <Plug>(MoveDown)

nmap [<Space> <Plug>(BlankUp)
nmap ]<Space> <Plug>(BlankDown)
xmap [<Space> <ESC>[<Space>gv
xmap ]<Space> <ESC>]<Space>gv
nmap <Space>p <Plug>(BlankDown)jp
nmap <Space>P <Plug>(BlankUp)kP
"}}}

" # ga Info keymap and release " {{{

" vim-characterize
" nnoremap gaa ga
" xnoremap gaa ga

nnoremap ga8 g8
xnoremap ga8 g8
nnoremap gah <cmd>call my#syntax#get_syn_name()<cr>
nnoremap gaH <cmd>call my#syntax#get_syn_info()<cr>
nnoremap ga<C-G> g<C-G>
xnoremap ga<C-G> g<C-G>
nnoremap ga <nop>
xnoremap ga <nop>
" }}}
