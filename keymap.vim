" neovim terminal "{{{
if has('nvim')
  tnoremap <esc> <c-\><c-n>
  " tmap jj <esc>
  " tnoremap <c-h> <c-\><c-n><c-w>h
  " tnoremap <c-j> <c-\><c-n><c-w>j
  " tnoremap <c-k> <c-\><c-n><c-w>k
  " tnoremap <c-l> <c-\><c-n><c-w>l
  nnoremap <c-w>ts :botrigh split +term<cr>
  nnoremap <c-w>tv :vsp +term<cr>
  nnoremap <space>t :botrigh split +term<cr>
  nnoremap <space>T :tabnew +term<cr>

  tnoremap <c-t>h <c-\><c-n><c-w>h
  tnoremap <c-t>j <c-\><c-n><c-w>j
  tnoremap <c-t>k <c-\><c-n><c-w>k
  tnoremap <c-t>l <c-\><c-n><c-w>l

  nnoremap <c-t>h <c-w>hI
  nnoremap <c-t>j <c-w>jI
  nnoremap <c-t>k <c-w>kI
  nnoremap <c-t>l <c-w>lI
endif "}}}

" Encode: Reopening with a specific character."{{{
" In particular effective when I am garbled in a terminal.
command! -bang -bar -complete=file -nargs=? Utf8      edit<bang> ++enc=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Iso2022jp edit<bang> ++enc=iso-2022-jp <args>
command! -bang -bar -complete=file -nargs=? Cp932     edit<bang> ++enc=cp932 <args>
command! -bang -bar -complete=file -nargs=? Euc       edit<bang> ++enc=euc-jp <args>
command! -bang -bar -complete=file -nargs=? Utf16     edit<bang> ++enc=ucs-2le <args>
command! -bang -bar -complete=file -nargs=? Utf16be   edit<bang> ++enc=ucs-2 <args>

" Aliases.
command! -bang -bar -complete=file -nargs=? Jis     Iso2022jp<bang> <args>
command! -bang -bar -complete=file -nargs=? Sjis    Cp932<bang> <args>
command! -bang -bar -complete=file -nargs=? Unicode Utf8<bang> <args>
"}}}

nnoremap ,gd :OpenGitDiffWin<CR>
nnoremap ,gt :Tig<CR>
nnoremap gst :WordTranslate<CR>

" #toggle options
nnoremap \toc :set cursorcolumn!<CR>
nnoremap \ton :set number!<CR>
nnoremap \tor :set relativenumber!<CR>
nnoremap \tow :set wrap!<CR>
nnoremap \tol :set list!<CR>

inoremap <silent><expr><c-j> pumvisible()? "\<c-y>" : "\<cr>"
" inoremap jj <esc>
nnoremap <silent><space>n :call ResetHightlights()<cr>:nohlsearch<cr>
xnoremap <space>n :normal<space>

noremap <Plug>(vim-basic-visual) v
noremap <Plug>(vim-basic-visualline) V
noremap <Plug>(vim-basic-visualblock) <c-v>
noremap <Plug>(vim-basic-start) 0
noremap <Plug>(vim-basic-last) $
noremap <Plug>(vim-basic-front) ^
noremap <Plug>(vim-basic-tail) g_

inoremap <Plug>(vim-basic-insert-lasttext) <c-a>

" Ctrl /
imap  <plug>(vim-basic-insert-lasttext)

inoremap <c-r><c-r> <c-r>"
nnoremap g?? Vg?
map mp %
map mmp ^%
nnoremap ,i ".p
nnoremap ,p "0p
nnoremap ,v '[<S-v>']
nmap dmp <Plug>(delete_for_match)
nmap <Space>J <Plug>(MoveDown)kJ
nnoremap <silent>( {:<c-u>exec ('' ==# getline('.')? 'normal! j' : '')<CR>
nnoremap <silent>) }:<c-u>exec ('' ==# getline('.')? 'normal! k' : '')<CR>
xnoremap <silent>( {:<c-u>exec 'normal! gv' . ('' ==# getline("'<")? 'j' : '')<CR>
xnoremap <silent>) }:<c-u>exec 'normal! gv' . ('' ==# getline("'>")? 'k' : '')<CR>
nmap >p p:'[,']><CR>
nmap <p p:'[,']<<CR>
nmap =p p=']
nnoremap <space>{ {o
nnoremap <space>} }O
nnoremap <silent>d{ :<c-u>normal! V{d<CR>
nnoremap <silent>d} :<c-u>normal! V}d<CR>
inoremap <silent><C-s> <ESC>:update<CR>
nnoremap <silent><C-s> :update<CR>
nnoremap <silent><C-q>w :wq<CR>
nnoremap Zz ZZ
nnoremap Zq ZQ
inoremap <c-z><c-z> <esc>:wq<cr>
inoremap <c-z>z <esc>:wq<cr>
inoremap <c-z><c-q> <esc>:q<cr>
inoremap <c-z>q <esc>:q<cr>
inoremap <c-z>eq <esc>:qall!<cr>

" #undo
nnoremap <silent>,uf :earlier 1f<CR>
nnoremap <silent>,ud :earlier 1d<CR>
nnoremap <silent>,uc :UndoClear<CR>
nnoremap <silent>,uw :e!<CR>
nnoremap <silent>,u <Nop>

" #buffer close
nnoremap <silent>,dd :bd<CR>
nnoremap <silent>,dq :q<CR>
nnoremap <silent>,da :qall<CR>
nnoremap <silent>,dw :wqall<CR>

" #overwrite
inoremap <c-c> <esc>
xmap u <esc>u
nnoremap Y y$
nnoremap <C-]> g<C-]>
nnoremap g<C-]> <C-]>
nnoremap <C-w><C-]> <C-w>g<C-]>
nnoremap <C-w>g<C-]> <C-w><C-]>
nnoremap <C-w>] <C-w>g]
nnoremap <C-w>g] <C-w>]
nnoremap v V
nnoremap V v
xnoremap <c-a> <c-a>gv
xnoremap <c-x> <c-x>gv
nnoremap <C-y> 4<C-y>
xnoremap <C-y> 4<C-y>
nnoremap <C-e> 4<C-e>
xnoremap <C-e> 4<C-e>
" nnoremap 0 ^
" nnoremap ^ 0
" nnoremap - $
" xnoremap 0 ^
" xnoremap ^ 0
" xnoremap - $

" #fold "{{{
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

nnoremap <Space>z za
"}}}

" #buffer "{{{
nnoremap <silent>,ba :call ActiveOnly()<CR>
nnoremap <silent>,bc :call CurrentOnly()<CR>
nnoremap <silent>,bo :only<CR>
nnoremap <silent>,bt :tabonly<CR>
nnoremap <silent>,bl :ls<CR>
nnoremap <silent>,bh :ls!<CR>
nnoremap <silent>,bb :b#<CR>
nnoremap <silent>,bd :bd<CR>
nnoremap <silent>,bq :q<CR>
"}}}

" #window"{{{
nnoremap gfb gf
nnoremap <silent>gft :tab wincmd f<CR>
nnoremap <silent>gfv :vertical wincmd f<CR>
nnoremap <silent>gfs :botright wincmd f<CR>
nnoremap gf <NOP>

au u10ac CmdwinEnter  * call s:cmdwin_config()
function! s:cmdwin_config()
  nnoremap <silent><buffer>q :q<CR>
  nnoremap <silent><buffer><C-W> :q<CR><C-W>
endfunction

"}}}

" #complete "{{{
cnoremap <c-y> <c-y><BS>
cnoremap <c-g> <c-c>:<c-p>

inoremap <C-x>n <C-x><C-n>
inoremap <C-x>i <C-x><C-i>
inoremap <C-x>] <C-x><C-]>
inoremap <C-x>k <C-x><C-k>
inoremap <C-x>s <C-x><C-s>
inoremap <C-x>l <C-x><C-l>
inoremap <C-x>f <C-x><C-f>
inoremap <C-x>o <C-x><C-o>
inoremap <C-x>u <C-x><C-u>
inoremap <C-x>d <C-x><C-d>
inoremap <C-x>p <C-x><C-p>
inoremap <C-x>v <C-x><C-v>
" inoremap <C-x> <Nop> " cannot do <c-x><c-u>
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

" #emacs bind "{{{
inoremap <C-A> <C-o>^
inoremap <C-E> <C-o>$
imap <C-D> <Del>
imap <c-h> <bs>

inoremap <C-W> <C-g>u<C-W>
inoremap <C-U> <C-g>u<C-U>
inoremap <C-K> <C-o>"_D

cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-D> <Del>

" noremap! is insert+command
noremap! <C-B> <Left>
noremap! <C-F> <Right>
"}}}

" #alt keybind
inoremap <m-w> <c-o>dw
inoremap <m-f> <c-o>w
inoremap <m-b> <c-o>b
inoremap <nowait><esc> <esc>
" TODO: Move those settings to right section

nnoremap <c-p> :<c-p>
vnoremap <c-p> :<c-p>
vnoremap <c-n> :<c-n>

" #non register delete "{{{
nnoremap _c "_c
vnoremap _c "_c
nnoremap _d "_d
vnoremap _d "_d
nnoremap _C "_C
vnoremap _C "_C
nnoremap _D "_D
vnoremap _D "_D
nnoremap _x "_x
vnoremap _x "_x
nnoremap _X "_X
vnoremap _X "_X
"}}}

" #paired map "{{{
nmap [e <Plug>(MoveUp)
nmap ]e <Plug>(MoveDown)
xmap [e <Plug>(MoveUp)
xmap ]e <Plug>(MoveDown)

nnoremap <silent>[c :cp<cr>
nnoremap <silent>]c :cc<cr>

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
" Todo: search other mappings. [p is adjust the indent paste
" nnoremap <silent> [p :cprevious<CR>
" nnoremap <silent> ]p :cprevious<CR>

nmap [<Space> <Plug>(BlankUp)
nmap ]<Space> <Plug>(BlankDown)
" visual-modeで[<Space>]が使えるようにする
xmap [<Space> <ESC>[<Space>gv
xmap ]<Space> <ESC>]<Space>gv
nmap <Space>p <Plug>(BlankDown)jp
nmap <Space>P <Plug>(BlankUp)kP
"}}}

" # ga Info keymap and release " {{{
nnoremap gaa ga
xnoremap gaa ga
nnoremap ga8 g8
xnoremap ga8 g8
nnoremap gah :SyntaxInfo<CR>
xnoremap gah :SyntaxInfo<CR>
nnoremap ga<C-G> g<C-G>
xnoremap ga<C-G> g<C-G>
" }}}

