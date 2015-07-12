command! SudoWrite w !sudo tee % > /dev/null
command! Q :q!
command! S :shell
command! Sh :w | sh
command! -nargs=1 -complete=file T tabedit <args>
command! Vs :tabedit | VimShell
command! Reload :source $MYVIMRC

" #comment mappings "{{{
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

" #non register delete "{{{
nnoremap _d "_d
vnoremap _d "_d
nnoremap _D "_D
vnoremap _D "_D
nnoremap _x "_x
vnoremap _x "_x
nnoremap _X "_X
vnoremap _X "_X
"}}}

" paired map
nnoremap <silent> [b :bnext<CR>
nnoremap <silent> ]b :bprevious<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap <silent> [<Space> O<ESC>j
nnoremap <silent> ]<Space> o<ESC>k
nnoremap <silent> [p :cprevious<CR>
nnoremap <silent> ]p :cprevious<CR>

nnoremap Y v$hy
nmap S <C-V>$sa

" deprecated
map mp %
" superseded
map gp %

inoremap <C-C> <ESC>

nnoremap <silent>mj :move+<CR>
nnoremap <silent>mk :move-2<CR>
nmap gJ mjkJ

nnoremap v V
nnoremap V v

nnoremap <silent> <C-S> :w<CR>
inoremap <silent> <C-S> <C-O>:w<CR>

" visual-modeで[<Space>]が使えるようにする
xmap [<Space> <ESC>[<Space>gv
xmap ]<Space> <ESC>]<Space>gv

" nnoremap <Space>bb :b#<CR>

"######<Space> family###### "{{{
nnoremap <Space>ss :%s/
nnoremap <Space>sg :%s//g<LEFT><LEFT>
xnoremap <Space>ss :s/
xnoremap <Space>sg :s//g<LEFT><LEFT>

" Toggle 0 and ^ VSのHome Endっぽくなる
" nnoremap <expr>0  col('.') == 1 ? '^' : '0'
" nnoremap <expr>^  col('.') == 1 ? '^' : '0'
noremap <Space>h ^
noremap <Space>l $

nmap <Space>p o<ESC>p
nmap <Space>P o<ESC>P

xnoremap <Space>n :normal<Space>
nnoremap <Space>z za

nnoremap <silent> <Space> <Nop>
xnoremap <silent> <Space> <Nop>
"}}}

"#Ctrl+W family"{{{
nnoremap <C-W>p gt
nnoremap <C-W>n gT
nnoremap <C-W>gs :vertical wincmd f<CR>
nnoremap gs :vertical wincmd f<CR>

"#cmdwin
cnoremap <C-K> <C-F>

au uAutoCmd CmdwinEnter  * call s:cmdwin_config()
function! s:cmdwin_config()
  nnoremap <silent><buffer>q :q<CR>
  nnoremap <silent><buffer><C-W> :q<CR><C-W>
endfunction

"}}}

"#Move"{{{
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
inoremap <C-D>  <Del>
inoremap <silent><C-A>  <C-o>^
inoremap <C-E> <C-O>$
inoremap <C-W>  <C-G>u<C-W>
inoremap <C-U>  <C-G>u<C-U>

cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-D> <Del>
" noremap! is insert+command
noremap! <C-B> <Left>
noremap! <C-F> <Right>
"}}}

" TODO: Move those settings to right section
" au MyAutoCmd CmdwinEnter [:>] iunmap <buffer> <Tab>
" au MyAutoCmd CmdwinEnter [:>] nunmap <buffer> <Tab>
