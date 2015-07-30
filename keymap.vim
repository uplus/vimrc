command! SudoWrite w !sudo tee % > /dev/null
command! Q quit!
command! Sh update | shell
command! -nargs=1 -complete=file T tabedit <args>
command! Vshell tabnew +VimShell
command! Reload source $MYVIMRC
command! Ao Aonly
command! Co Conly
command! NeoBundleAllClean NeoBundleClean | NeoBundleClearCache
command! Commit !git cov
command! Uclear UndoClear

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
nnoremap <silent>\hh :nohlsearch \| :call clearmatches()<CR>
"}}}

nnoremap Y y$
nmap S <C-V>$sa
nmap <Space>J ]ekJ

nnoremap <silent><C-Q>q :q<CR>
nnoremap <silent><C-Q>a :qa<CR>
nnoremap <silent><C-Q>w :wq<CR>
nnoremap <silent>Zz ZZ
nnoremap <silent>Zq Zq

nnoremap <C-y> 3<C-y>
xnoremap <C-y> 3<C-y>
nnoremap <C-e> 3<C-e>
xnoremap <C-e> 3<C-e>

" 行末にスペースを一つ追加する
xnoremap zF zf
xnoremap <silent>zf <ESC>:call <SID>add_fold_and_space()<CR>
function! s:add_fold_and_space()
  silent '<s/\v\s*$/ /
  silent '>s/\v\s*$/ /
  silent '>s/\v^ $//e
  '<,'>fold
  nohlsearch
endfunction

map mp %
map mmp ^%

nnoremap ,ba :ActiveOnly<CR>
nnoremap ,bc :CurrentOnly<CR>
nnoremap ,bo :only<CR>
nnoremap ,bt :tabonly<CR>
nnoremap ,bl :ls<CR>
nnoremap ,bL :ls!<CR>
nnoremap ,bb :b#<CR>
nnoremap ,bd :bd<CR>
nnoremap ,bq :q<CR>

nnoremap ,dd :bd<CR>
nnoremap ,dw :q<CR>
nnoremap ,da :qa<CR>

nnoremap ,i ".p
nnoremap ,p "0p
nnoremap ,v '[<S-v>']
nnoremap ,uu :earlier 1f<CR>
nnoremap ,uc :UndoClear<CR>

inoremap <C-C> <ESC>

nnoremap v V
nnoremap V v
xnoremap v <C-V>
xnoremap V v

nnoremap <silent> <C-S> :update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" # ga Info keymap and release " {{{
nnoremap gaa ga
xnoremap gaa ga
nnoremap ga8 g8
xnoremap ga8 g8
nnoremap gah :SyntaxInfo<CR>
xnoremap gah :SyntaxInfo<CR>
nnoremap ga<C-G> g<C-G>
xnoremap ga<C-G> g<C-G>
nnoremap ga<C-A> g<C-A>
xnoremap ga<C-A> g<C-A>
" }}}

" #Space
nnoremap <Space>ss :%s/
nnoremap <Space>sg :%s//g<LEFT><LEFT>
xnoremap <Space>ss :s/
xnoremap <Space>sg :s//g<LEFT><LEFT>

" g^ g$ にするとsidescrollのとき画面上の端までしか動いてくれない
noremap <Space>h 0
noremap <Space>l $

nmap <Space>p :call feedkeys("]\<Space>jp")<CR>
nmap <Space>P :call feedkeys("[\<Space>kP")<CR>

nmap <silent> <Space>n \hh
xnoremap <Space>n :normal<Space>
nnoremap <Space>z za

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
inoremap <C-A>  <C-o>^
inoremap <C-E> <C-O>$
imap <C-D>  <Del>
" Todo: can delete {} with <C-W> and <C-U> in insert-mode
inoremap <C-W>  <C-G>u<C-W>
inoremap <C-U>  <C-G>u<C-U>
inoremap <C-K> <C-O>"_D

cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-D> <Del>

" noremap! is insert+command
noremap! <C-B> <Left>
noremap! <C-F> <Right>
"}}}

" #alt-keybind  はescapeとalt
" inoremap w <C-o>dw
" inoremap f <C-o>w
" inoremap b <C-o>b

" TODO: Move those settings to right section
" au uAutoCmd CmdwinEnter [:>] iunmap <buffer> <Tab>
" au uAutoCmd CmdwinEnter [:>] nunmap <buffer> <Tab>
