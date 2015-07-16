command! SudoWrite w !sudo tee % > /dev/null
command! Q :q!
command! S :shell
command! Sh :w | sh
command! -nargs=1 -complete=file T tabedit <args>
command! Vs :tabedit | VimShell
command! Reload :source $MYVIMRC

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

" #paired map "{{{
nnoremap <silent> [b :bnext<CR>
nnoremap <silent> ]b :bprevious<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap <silent> [p :cprevious<CR>
nnoremap <silent> ]p :cprevious<CR>
" visual-modeで[<Space>]が使えるようにする
xmap [<Space> <ESC>[<Space>gv
xmap ]<Space> <ESC>]<Space>gv
"}}}

nnoremap Y v$hy
nmap S <C-V>$sa
nmap gJ ]ekJ

" 行末にスペースを一つ追加する
xnoremap zF <ESC>'<A<Space><ESC>'>A<Space><ESC>gvzf

" deprecated
map mp %
" superseded
map gp %

inoremap <C-C> <ESC>

nnoremap v V
nnoremap V v
xnoremap v <C-V>
xnoremap V v

nnoremap <silent> <C-S> :update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" #Space "{{{
nnoremap <Space>ss :%s/
nnoremap <Space>sg :%s//g<LEFT><LEFT>
xnoremap <Space>ss :s/
xnoremap <Space>sg :s//g<LEFT><LEFT>

" Toggle 0 and ^ VSのHome Endっぽくなる
" nnoremap <expr>0  col('.') == 1 ? '^' : '0'
" nnoremap <expr>^  col('.') == 1 ? '^' : '0'
noremap <Space>h ^
noremap <Space>l $

nmap <Space>p :call feedkeys("]\<Space>jp")<CR>
nmap <Space>P :call feedkeys("[\<Space>kP")<CR>

xnoremap <Space>n :normal<Space>
nnoremap <Space>z za

nnoremap <silent> <Space> <Nop>
xnoremap <silent> <Space> <Nop>
"}}}

" #window"{{{
nnoremap <C-W>p <Nop>
nnoremap <C-W>n <Nop>
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

" #move "{{{
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
"}}}

" #emacs-bind "{{{
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
" au uAutoCmd CmdwinEnter [:>] iunmap <buffer> <Tab>
" au uAutoCmd CmdwinEnter [:>] nunmap <buffer> <Tab>
