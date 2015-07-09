command! Schemes :Unite colorscheme -auto-preview
command! SudoWrite w !sudo tee % > /dev/null
command! QuickRunStop call quickrun#sweep_sessions()
command! Q :q!
command! S :shell
command! -nargs=1 -complete=file T tabedit <args>
command! Sh :w | sh
command! Vs :tabedit | VimShell
command! Reload :source $MYVIMRC

"#comment mappings "{{{
nnoremap <silent> gyy yy:TComment<CR>
nnoremap <silent> gyj yj:.,+1TComment<CR>
nnoremap <silent> gyk yk:.,+1TComment<CR>j
nnoremap <silent> gyg ygg<C-o>:0,.TComment<CR>
nnoremap <silent> gyG yG:.,$TComment<CR>
nnoremap <silent> gyp :%y<CR>:%TComment<CR>
xnoremap <silent> gy ygv:TComment<CR>
nnoremap <silent> gcj :TComment<CR>j:TComment<CR>k
nnoremap <silent> gck :TComment<CR>k:TComment<CR>j
nnoremap <silent> gcp :%TComment<CR>
"}}}

"#not register delete "{{{
nnoremap _d "_d
vnoremap _d "_d
nnoremap _D "_D
vnoremap _D "_D
nnoremap _x "_x
vnoremap _x "_x
nnoremap _X "_X
vnoremap _X "_X
"}}}

nnoremap Y v$hy
nmap S <C-V>$S
map mp %
nnoremap gJ kddpkJ

inoremap <C-C> <ESC>
nnoremap <silent>mj :.move +1<CR>
nnoremap <silent>mk :.move -2<CR>
nmap zp v%zf

nnoremap v V
nnoremap V v

nnoremap <silent> <C-S> :w<CR>
inoremap <silent> <C-S> <C-O>:w<CR>

" ex-modeいらない
nnoremap Q <Nop>

" visual-modeで[<Space>]が使えるようにする
xmap [<Space> <ESC>[<Space>gv
xmap ]<Space> <ESC>]<Space>gv

" #buffer
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
" nnoremap <Space>bb :b#<CR>


"######<Space> family###### "{{{
nnoremap <Space>m :Unite mark<CR>
nnoremap <Space>b :Unite buffer<CR>

nnoremap <Space>ss :%s/
nnoremap <Space>sg :%s//g<LEFT><LEFT>
xnoremap <Space>ss :s/
xnoremap <Space>sg :s//g<LEFT><LEFT>

nnoremap <Space>h ^
nnoremap <Space>l $
xnoremap <Space>h ^
xnoremap <Space>l $

nmap <Space>p o<ESC>p
nmap <Space>P o<ESC>P
" 一括でUndoできない
" nmap <Space>p ]<Space>jp
" nmap <Space>P ]<Space>jP

xnoremap <Space>n :normal<Space>
nnoremap <Space>z za

nnoremap <silent> <Space> <Nop>
xnoremap <silent> <Space> <Nop>
"}}}

"######Ctrl+W family###### "{{{
nnoremap <silent><C-W>e :Vf<CR>
nnoremap <C-W>q :bdelete<CR>
nnoremap <C-W>p gt
nnoremap <C-W>n gT
nnoremap <C-W>gs :vertical wincmd f<CR>
nnoremap gs :vertical wincmd f<CR>

"#resize "{{{
if neobundle#is_installed('vim-submode')
  call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
  call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
  call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
  call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
  call submode#map('winsize', 'n', '', '>', '<C-w>>')
  call submode#map('winsize', 'n', '', '<', '<C-w><')
  call submode#map('winsize', 'n', '', '+', '<C-w>+')
  call submode#map('winsize', 'n', '', '-', '<C-w>-')
endif
"}}}

"#cmdwin "{{{
cnoremap <C-K> <C-F>

au CmdwinEnter  * call s:cmdwin_config()
function! s:cmdwin_config()
  nnoremap <silent><buffer>q :q<CR>
  nnoremap <silent><buffer><C-W> :q<CR><C-W>
endfunction
"}}}
"}}}

"######Move###### "{{{
nnoremap <UP> gk
nnoremap <DOWN> gj
nnoremap <LEFT> h
nnoremap <RIGHT> l
vnoremap <UP> gk
vnoremap <DOWN> gj
vnoremap <LEFT> h
vnoremap <RIGHT> l

nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j
vnoremap k gk
vnoremap j gj
vnoremap gk k
vnoremap gj j

inoremap <UP> <C-O>gk
inoremap <DOWN> <C-O>gj
inoremap <C-K> <C-O>"_D
inoremap <C-D> <C-O>"_x
inoremap <C-A> <C-O>^
inoremap <C-E> <C-O>$
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-D> <Del>

" noremap! is insert+command
noremap! <C-B> <Left>
noremap! <C-F> <Right>
"}}}
