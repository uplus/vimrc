command! VS :tabedit | VimShell
command! Reload :source $MYVIMRC
command! Colors :Unite colorscheme -auto-preview
command! SudoWrite w !sudo tee % > /dev/null
command! Q :q!
command! QuickRunStop call quickrun#sweep_sessions()
command! S :shell

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
nnoremap Y v$hy
" sorrund
nmap S <C-V>$S
nmap zp v%zf
map mp %

nnoremap v V
nnoremap V v

function! CleanLine()
  s/[^ ]//ge
  noh
endfunction

" なぜかC-Uの挙動がおかしくなった
" nmap <silent>o o<Space><C-O>:call CleanLine()<CR><BS>
" nmap <silent><S-O> <S-O><Space><C-O>:call CleanLine()<CR><BS>

nnoremap <silent> <C-S> :w<CR>
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
function! WriteQuickRunN()
  write
  QuickRun -mode n
endfunction

nnoremap <Leader>r :call WriteQuickRunN()<CR>
xnoremap <Leader>r :QuickRun -mode v<CR>

nnoremap <Leader>m :Unite mark<CR>
nnoremap <Leader>b :Unite buffer<CR>

"######<Space> family######
xnoremap <Space>n :normal<Space>

nnoremap <Space>ss :%s/
nnoremap <Space>sg :%s//g<LEFT><LEFT>
xnoremap <Space>ss :s/
xnoremap <Space>sg :s//g<LEFT><LEFT>

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

"######Move######
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
" noremap! is insert+command
noremap! <C-B> <Left>
noremap! <C-F> <Right>
