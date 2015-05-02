"Ctrl-M は<CR>
"Ctrl-[ は<ESC>
"Ctrl-i は<TAB>
"<CR>のマッピングは <expr>の結果として使えば行ける?
":Errors :nohのマップ
" inoremap <C-Space>を　状況によって <C-Y>に割り当てる
"nnoremap <Space>h.. をundo履歴とかyank履歴とかにわりあてる
"nnoremap , コロンにマップできる :s がマップできるらしい　mはマークにマップされてる

command! VS :tabedit | VimShell
command! Reload :source $MYVIMRC
command! Colors :Unite colorscheme -auto-preview
command! SudoWrite w !sudo tee % > /dev/null
command! Q :q!

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

nnoremap gJ kddpkJ
nnoremap mj ddp
nnoremap mk ddkP
nnoremap <Space>z za
nmap zp v%zf

" do to end
nmap mp %
vmap mp %

nnoremap v V
nnoremap V v

" ex-modeいらない
nnoremap Q <Nop>
inoremap <C-C> <ESC>

" buffer
nnoremap <silent> [b :bpreviou<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap <Space>bb :b#<CR>
nnoremap <Space>bd :bd<CR>

"######<Leader> family######
nnoremap <Leader>r :QuickRun -mode n<CR>
xnoremap <Leader>r :QuickRun -mode v<CR>
nnoremap <Leader>m :Unite mark<CR>
nnoremap <Leader>b :Unite buffer<CR>

"######<Space> family######
" 現在の位置に空行を挿入
nnoremap <silent> <Space><CR> <S-O><ESC>x
xnoremap <Space>n :normal<Space>

nnoremap <Space>ss q:i%s/
xnoremap <Space>ss q:i%s/\%V

nnoremap <Space>h ^
nnoremap <Space>l $
xnoremap <Space>h ^
xnoremap <Space>l $

nnoremap <Space>p o<ESC>p
nnoremap <Space>P o<ESC>P

nnoremap <silent> <Space> <Nop>
xnoremap <silent> <Space> <Nop>


"######Ctrl+W family######
"NERDTree
nnoremap <silent> <C-W>e :NERDTreeFocus<CR>

"Window control
nnoremap <C-W>q :bdelete<CR>

"Tab control
nnoremap <C-W>p gt
nnoremap <C-W>n gT

"file open
nnoremap <C-W>gs :vertical wincmd f<CR>
nnoremap gs :vertical wincmd f<CR>

call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>+')
call submode#map('winsize', 'n', '', '-', '<C-w>-')

"######Ctrl+S family######
" Save need #stty -ixon -ixoff
noremap  <silent> <C-S> :w<CR>
inoremap <silent> <C-S> <C-O>:w<CR>

"######Move######
nnoremap <UP> gk
nnoremap <DOWN> gj
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

inoremap <UP> <C-O>gk
inoremap <DOWN> <C-O>gj
inoremap <C-K> <C-O>d$
inoremap <C-A> <C-O>^
inoremap <C-E> <C-O>$

xnoremap <UP> gk
xnoremap <DOWN> gj
xnoremap <LEFT> h
xnoremap <RIGHT> l
xnoremap k gk
xnoremap j gj
xnoremap gk k
xnoremap gj j
