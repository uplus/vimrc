command! SudoWrite w !sudo tee % > /dev/null
command! Q quit!
command! Sh update | shell
command! -nargs=1 -complete=file T tabedit <args>
command! Vs tabnew +VimShell
command! Reload source $MYVIMRC

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

" #reset highlight "{{{
nnoremap <silent>\hn :nohlsearch<CR>

" Reset all highlight 3以上|で連続できない
nnoremap <silent>\hh :nohlsearch \| QuickhlManualReset<CR>:RCReset<CR>
"}}}

nnoremap Y y$
nmap S <C-V>$sa
nmap <Space>J ]ekJ

nnoremap d<Space>j 3dj
nnoremap d<Space>k 3dk
nnoremap y<Space>j 3yj
nnoremap y<Space>k 3yk

" 行末にスペースを一つ追加する
" Todo: 高速に動作するようにsubsを使って改良する appendでできる
xnoremap zF <ESC>'<A<Space><ESC>'>A<Space><ESC>gvzf

" deprecated
map mp %
nmap mmp g^%

inoremap <C-C> <ESC>

nnoremap v V
nnoremap V v
xnoremap v <C-V>
xnoremap V v

nnoremap <silent> <C-S> :update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" Info keymap and release " {{{
nnoremap g8 <Nop>
xnoremap g8 <Nop>
nnoremap g<C-G> <Nop>
xnoremap g<C-G> <Nop>
nnoremap g<C-A> <Nop>
xnoremap g<C-A> <Nop>

nnoremap gaa ga
xnoremap gaa ga
nnoremap ga8 g8
xnoremap ga8 g8
nnoremap gas :SyntaxInfo<CR>
xnoremap gas :SyntaxInfo<CR>
nnoremap ga<C-G> g<C-G>
xnoremap ga<C-G> g<C-G>
nnoremap ga<C-A> g<C-A>
xnoremap ga<C-A> g<C-A>
" }}}

" #Space "{{{
nnoremap <Space>ss :%s/
nnoremap <Space>sg :%s//g<LEFT><LEFT>
xnoremap <Space>ss :s/
xnoremap <Space>sg :s//g<LEFT><LEFT>

" Toggle 0 and ^ VSのHome Endっぽくなる
" nnoremap <expr>0  col('.') == 1 ? '^' : '0'
" nnoremap <expr>^  col('.') == 1 ? '^' : '0'
noremap <Space>h g^
noremap <Space>l g$

nmap <Space>p :call feedkeys("]\<Space>jp")<CR>
nmap <Space>P :call feedkeys("[\<Space>kP")<CR>

xnoremap <Space>n :normal<Space>
nnoremap <Space>z za

noremap <Space>w W
noremap <Space>e E
noremap <Space>b B
noremap <Space>ge gE

nnoremap <silent> <Space> <Nop>
xnoremap <silent> <Space> <Nop>
"}}}

" #window"{{{
nnoremap <C-W>gs :vertical wincmd f<CR>
nnoremap gft gf
nnoremap gfv :vertical wincmd f<CR>

"#cmdwin
cnoremap <C-L> <C-F>

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
