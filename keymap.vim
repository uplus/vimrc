command! SudoWrite w !sudo tee % > /dev/null
command! Q qall!
command! Sh update | shell
command! -nargs=1 -complete=file T tabedit <args>
command! Reload source $MYVIMRC
command! ReloadKeymap source ~/.vim/keymap.vim
command! NeoBundleAllClean NeoBundleClean | NeoBundleClearCache
command! Commit !git cov
command! Tig execute "silent! !tig" | redraw!

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
" Todo: search other mappings.
" nnoremap <silent> [p :cprevious<CR>
" nnoremap <silent> ]p :cprevious<CR>
" visual-modeで[<Space>]が使えるようにする
xmap [<Space> <ESC>[<Space>gv
xmap ]<Space> <ESC>]<Space>gv

"}}}

nnoremap <silent>\hn :nohlsearch<CR>
nnoremap <silent>\hh :nohlsearch \| :call clearmatches()<CR>

nnoremap Y y$
nmap S <C-V>$sa
nmap <Space>J ]ekJ
noremap ( {j
noremap ) }k
nnoremap d{ V{jd
nnoremap d} ^d}

nnoremap \gd :OpenGitDiffWin<CR>
nnoremap 0 ^
nnoremap ^ 0
nnoremap - $
xnoremap 0 ^
xnoremap ^ 0
xnoremap - $

nnoremap gst :WordTranslate<CR>
xnoremap gst :ExciteTranslate<CR>

" #toggle options
nnoremap \toc :set cursorcolumn!<CR>

nmap [<Space> <Plug>(BlankUp)
nmap ]<Space> <Plug>(BlankDown)
nmap [e <Plug>(MoveUp)
nmap ]e <Plug>(MoveDown)
xmap [e <Plug>(MoveSelectionUp)
xmap ]e <Plug>(MoveSelectionDown)

vnoremap <c-a> <c-a>gv
vnoremap <c-x> <c-x>gv
map mp %
map mmp ^%
nnoremap v V
nnoremap V v

nnoremap <silent><C-Q>q :q<CR>
nnoremap <silent><C-Q>a :qa<CR>
nnoremap <silent><C-Q>w :wq<CR>
nnoremap <silent>Zz ZZ
nnoremap <silent>Zq ZQ

nnoremap <C-y> 3<C-y>
xnoremap <C-y> 3<C-y>
nnoremap <C-e> 3<C-e>
xnoremap <C-e> 3<C-e>

nnoremap zr zR
nnoremap zR zr
nnoremap zm zM
nnoremap zM zm
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

nnoremap <silent>,ba :ActiveOnly<CR>
nnoremap <silent>,bc :CurrentOnly<CR>
nnoremap <silent>,bo :only<CR>
nnoremap <silent>,bt :tabonly<CR>
nnoremap <silent>,bl :ls<CR>
nnoremap <silent>,bh :ls!<CR>
nnoremap <silent>,bb :b#<CR>
nnoremap <silent>,bd :bd<CR>
nnoremap <silent>,bq :q<CR>

nnoremap <silent>,dd :bd<CR>
nnoremap <silent>,dq :q<CR>
nnoremap <silent>,da :qa<CR>

nnoremap ,i ".p
nnoremap ,p "0p
nnoremap ,v '[<S-v>']
nnoremap <silent> ,uf :earlier 1f<CR>
nnoremap <silent> ,ud :earlier 1d<CR>
nnoremap <silent> ,uc :UndoClear<CR>

inoremap <C-C> <ESC>

inoremap <silent> <C-S> <C-O>:update<CR>
nnoremap <silent><C-S> :update<CR>

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
nnoremap <Space>sw :%s/<C-r><C-w>/g<LEFT><LEFT>
nnoremap <Space>sa :%s/<C-r><C-a>/g<LEFT><LEFT>
xnoremap <Space>ss :s/
xnoremap <Space>sg :s//g<LEFT><LEFT>
xnoremap <Space>sw :%s/<C-r><C-w>/g<LEFT><LEFT>
xnoremap <Space>sa :%s/<C-r><C-a>/g<LEFT><LEFT>

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
nnoremap gfb gf
nnoremap gft :tab wincmd f<CR>
nnoremap gfv :vertical wincmd f<CR>
nnoremap gfs :botright wincmd f<CR>

au uAutoCmd CmdwinEnter  * call s:cmdwin_config()
function! s:cmdwin_config()
  nnoremap <silent><buffer>q :q<CR>
  nnoremap <silent><buffer><C-W> :q<CR><C-W>
  startinsert
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

nnoremap <silent><expr>h foldclosed('.') != -1? "zo" : "h"
nnoremap <silent><expr>l foldclosed('.') != -1? "zO" : "l"

inoremap <UP> <C-O>gk
inoremap <DOWN> <C-O>gj
"}}}

" #emacs-bind "{{{
inoremap <C-A>  <C-o>^
inoremap <C-E> <C-O>$
imap <C-D>  <Del>

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
