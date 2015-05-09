"Ctrl-M は<CR>
"Ctrl-[ は<ESC>
"Ctrl-i は<TAB>
"<CR>のマッピングは <expr>の結果として使えば行ける?
" inoremap <C-Space>を　状況によって <C-Y>に割り当てる
" nnoremap <Space>h.. をundo履歴とかyank履歴とかにわりあてる
" nnoremap ,コロンにマップできる mはマークにマップされてる

command! VS :tabedit | VimShell
command! Reload :source $MYVIMRC
command! Colors :Unite colorscheme -auto-preview
command! SudoWrite w !sudo tee % > /dev/null
command! Q :q!
command! QuickRunStop call quickrun#sweep_sessions()

"comment mappings
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

" go to opposite
map mp %

nnoremap v V
nnoremap V v

noremap  <silent> <C-S> :w<CR>
inoremap <silent> <C-S> <C-O>:w<CR>

" ex-modeいらない
nnoremap Q <Nop>
inoremap <C-C> <ESC>

" buffer
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
xnoremap <Space>n :normal<Space>

nnoremap <Space>ss q:i%s/
xnoremap <Space>ss q:is/

nnoremap <Space>h ^
nnoremap <Space>l $
xnoremap <Space>h ^
xnoremap <Space>l $

nnoremap <Space>p o<ESC>p
nnoremap <Space>P o<ESC>P

nnoremap <silent> <Space> <Nop>
xnoremap <silent> <Space> <Nop>


"######Ctrl+W family######
nnoremap <silent> <C-W>e :NERDTreeFocus<CR>
nnoremap <C-W>q :bdelete<CR>
nnoremap <C-W>p gt
nnoremap <C-W>n gT
nnoremap <C-W>gs :vertical wincmd f<CR>
nnoremap gs :vertical wincmd f<CR>

"resize
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>+')
call submode#map('winsize', 'n', '', '-', '<C-w>-')

"######Move######
noremap <UP> gk
noremap <DOWN> gj
noremap <LEFT> h
noremap <RIGHT> l
noremap k gk
noremap j gj
noremap gk k
noremap gj j

inoremap <UP> <C-O>gk
inoremap <DOWN> <C-O>gj
inoremap <C-K> <C-O>d$
inoremap <C-A> <C-O>^
inoremap <C-E> <C-O>$
