"commandモードでのマップは文字入力に影響がある
" Ctrl-M は<CR>
"Ctrl-[ は<ESC>
"Ctrl-i は<TAB>
"<CR>のマッピングは <expr>の結果として使えば行ける?
":Errors :nohのマップ
" inoremap <C-Space>を　状況によって <C-Y>に割り当てる
"nnoremap <Space>h.. をundo履歴とかyank履歴とかにわりあてる
"nnoremap , コロンにマップできる

command! VS :tabedit | VimShell
command! Reload :source $MYVIMRC
command! Colors :Unite colorscheme -auto-preview
command! SudoWrite w !sudo tee % > /dev/null
command! Q :q!

nnoremap <silent> gyy yy:TComment<CR>
nnoremap <silent> gyj 2yy:.,+1TComment<CR>
nnoremap <silent> gyk k2yy:.,+1TComment<CR>j
nnoremap <silent> gyg ygg<C-o>:0,.TComment<CR>
nnoremap <silent> gyG yG:.,$TComment<CR>
nnoremap <silent> gyp :%y<CR>:%TComment<CR>
vnoremap <silent> gy ygv:TComment<CR>
nnoremap <silent> gcj :TComment<CR>j:TComment<CR>k
nnoremap <silent> gck :TComment<CR>k:TComment<CR>j
nnoremap <silent> gcp :%TComment<CR>

nnoremap <silent> y% :%y<CR>
nnoremap <silent> d% :%d<CR>
nnoremap <silent> yp :%y<CR>
nnoremap <silent> dp :%d<CR>

nnoremap <C-J> ddpkJ
nnoremap mj ddp
nnoremap mk ddkP
nnoremap <Space>z za
nmap zp zf%

nnoremap v V
nnoremap V v

" ex mode はいらない
nnoremap Q <Nop>
" 履歴誤爆防止 これがあるとNERDTreeがqで終了できない
" nnoremap q: <Nop>
vnoremap <BS> d
inoremap <C-C> <ESC>


"######Ctrl+@ family######

"######<Space> family######
" 現在の位置に空行を挿入
nnoremap <silent> <Space><CR> <S-O><ESC>x
" do to end
nmap <Space>t %
"vmapはpを%にマップしても飯井かもしれない
vmap <Space>t %

nnoremap <Space>ss :OverCommandLine<CR>%s/
nnoremap <Space>sg :OverCommandLine<CR>%s//g<LEFT><LEFT>
nnoremap <Space>ws :OverCommandLine<CR>%s/<C-r><C-w>/
nnoremap <Space>wg :OverCommandLine<CR>%s/<C-r><C-w>//g<LEFT><LEFT>
vnoremap <Space>ss :OverCommandLine<CR>s/\%V
vnoremap <Space>sg :OverCommandLine<CR>s/\%V/g<LEFT><LEFT>
vnoremap <Space>ws :OverCommandLine<CR>s/\%V<C-r><C-w>/
vnoremap <Space>wg :OverCommandLine<CR>s/\%V<C-r><C-w>//g<LEFT><LEFT>

nnoremap <Space>j <C-D>
nnoremap <Space>k <C-U>
nnoremap <Space>h ^
nnoremap <Space>l $
vnoremap <Space>j <C-D>
vnoremap <Space>k <C-U>
vnoremap <Space>h ^
vnoremap <Space>l $

nnoremap <Space>p o<ESC>p
nnoremap <Space>P o<ESC>P

" buffer
nnoremap <Space>bb :b#<CR>
nnoremap <Space>bp :bp<CR>
nnoremap <Space>bn :bn<CR>
nnoremap <Space>bd :bd<CR>

nnoremap <silent> <Space> <Nop>
vnoremap <silent> <Space> <Nop>


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
" quit vim
nnoremap <C-S>q :q<CR>
nnoremap <C-S>aq :qa<CR>
inoremap <C-S>q <ESC>:q<CR>
inoremap <C-S>aq <ESC>:qa<CR>

" buffer delete
nnoremap <C-S>d :bd<CR>
inoremap <C-S>d <ESC>:bd<CR>

" exit
nnoremap <C-S>e :q!<CR>
nnoremap <C-S>ae :qa!<CR>
inoremap <C-S>e <ESC>:q!<CR>
inoremap <C-S>ae <ESC>:qa!<CR>

" save and quit
nnoremap <C-S>z :wq<CR>
nnoremap <C-S>az :wqa<CR>
inoremap <C-S>z <ESC>:wq<CR>
inoremap <C-S>az <ESC>:wqa<CR>


" Save need #stty -ixon -ixoff
noremap  <silent> <C-S>s :update<CR>
inoremap <silent> <C-S>s <C-O>:update<CR>

" Save single C-S version
noremap  <silent> <C-S> :update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

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

vnoremap <UP> gk
vnoremap <DOWN> gj
vnoremap <LEFT> h
vnoremap <RIGHT> l
vnoremap k gk
vnoremap j gj
vnoremap gk k
vnoremap gj j

"######Trash######
"すでに前の行の先頭　にマップされている
" 0 == ^ - == $
"nnoremap - $

"なんかいろいろすごいけど・・・
"cnoreabb <silent><expr>s getcmdtype()==':' && getcmdline()=~'^s' ? 'OverCommandLine<CR><C-u>%s/<C-r>=get([], getchar(0), '')<CR>' : 's'
