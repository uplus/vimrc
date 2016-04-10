if 0 | endif

if &compatible
  set nocompatible
endif

language message C
scriptencoding=utf-8

function! IsMac()
  return (has('mac') || has('macunix') || has('gui_macvim') ||
        \   (!executable('xdg-open') && system('uname') =~? '^darwin'))
endfunction

function! s:source(path)
  execute 'source' fnameescape(expand('~/.vim/' . a:path . '.vim'))
endfunction

augroup uAutoCmd
  autocmd!
augroup END

set undodir=~/.vim/tmp/undo.txt
set viewdir=~/.vim/tmp/view
set path+=/usr/include/c++/HEAD/
set tags=tags;$HOME,.tags;$HOME,./tags,./.tags
" tags;     current-dirからtagsが見つかるまで遡る
" tas;/dir  上記と同じだが/dirより上には行かない

let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif

if filereadable(expand('~/.vimrc.before'))
  source $HOME/.vimrc.before
endif

" #Release keymaps"{{{
let mapleader = ";"
nnoremap Q <Nop>
nnoremap ; <Nop>
xnoremap ; <Nop>
nnoremap , <Nop>
xnoremap , <Nop>
nnoremap s <Nop>
xnoremap s <Nop>
nnoremap gs <Nop>
xnoremap gs <Nop>
nnoremap gR <Nop>
xnoremap gR <Nop>
nnoremap g8 <Nop>
xnoremap g8 <Nop>
nnoremap g<C-G> <Nop>
xnoremap g<C-G> <Nop>
"}}}

call s:source('dein')

" if ! exists('g:noplugin')
"   call s:source('neobundle')
" endif

" filetype plugin indent on
" syntax enable

" Lazy loading
" silent! filetype plugin indent on
" syntax enable
" filetype detect

" autocmd uAutoCmd FileType,Syntax,BufEnter,BufWinEnter * call s:my_on_filetype()
function! s:my_on_filetype() abort "{{{
  if &l:filetype == '' && bufname('%') == ''
    return
  endif

  redir => filetype_out
  silent! filetype
  redir END
  if filetype_out =~# 'OFF'
    " Lazy loading
    silent! filetype plugin indent on
    syntax enable
    filetype detect
  endif
endfunction "}}}

set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,iso-2022-jp-3,iso-2022-jp,euc-jisx0213,ucs-bom,euc-jp,eucjp-ms,cp932
" Default fileformat.
set fileformat=unix
" Automatic recognition of a new line cord.
set fileformats=unix,dos,mac

" set undofile
set report=0  " コマンド似よって0行以上変更されたらmessage
set nonumber
set hidden
set showcmd
set noshowmode
set cursorline
set noshowmatch matchtime=0 " 括弧を入力した時に移動しないようにする
set laststatus=2
set cmdheight=2 cmdwinheight=4
set mouse=      " クリックでマウスが動かないように
set nobackup
set modeline modelines=2
" TODO: <c-g>  <C-l>には補完用のマップがある。
set cedit=<c-l> " move to cmdwin key
set splitright nosplitbelow
set nostartofline " Maintain a current line at the time of movement as much as possible.
" set ttyfast
set completeopt=menuone
set switchbuf=usetab

if has('patch755')
  " set completeopt+=noinsert
endif

if has('linebreak')
  set breakindent
endif
set nowrap
set sidescroll=1
set sidescrolloff=12
set virtualedit=block
set nrformats-=octal

" Keymapping timeout.
set timeout timeoutlen=3000 ttimeoutlen=100
" CursorHold time.
set updatetime=2500

" #indent
au uAutoCmd FileType conf,gitcommit,html,css set nocindent
set autoindent cindent
set cinkeys-=0#
" *<Return> enterするたびにreindent
set cinoptions+=#1,J1,j1,g0,N-2
" :0 にすると switchとcaseが同じレベルになる

set backspace=start,eol,indent
set whichwrap=b,s,[,],<,>
set iskeyword+=$,@-@  "設定された文字が続く限り単語として扱われる @は英数字を表す
                      " _を除くと*での検索がやりずらい
" au uAutoCmd FileType vim setl iskeyword-=# " #を含めると*での検索や補完が楽
" au uAutoCmd FileType zsh setl iskeyword-=-
au uAutoCmd FileType zsh setl iskeyword-=$
au uAutoCmd FileType ruby setl iskeyword+=?

" #menu
set showfulltag         " Display all the information of the tag by the supplement of the Insert mode.
set wildoptions=tagfile " Can supplement a tag in a command-line.
" 補完候補を全て表示 もう一度<Tab>で巡回
set wildmenu
set wildmode=list:longest,full

" #search
set gdefault
set ignorecase smartcase
set incsearch
set nohlsearch | nohlsearch "Highlight search patterns, support reloading

" #tab
set shiftround
set expandtab     "Tabキーでスペース挿入
set tabstop=2     "Tab表示幅
set softtabstop=2 "Tab押下時のカーソル移動量
set shiftwidth=2  "インデント幅
" set smarttab

" #fold
set foldmethod=marker
au uAutoCmd FileType zsh,ruby setl foldmethod=marker " php perl perl6 javascript clojure
set foldtext=FoldCCtext()
set foldcolumn=1
set foldlevelstart=0     " どのレベルから折りたたむか
set foldnestmax=3   " indent,syntaxでどの深さまで折りたたむか
" set foldclose=all " 折りたたんでるエリアからでると自動で閉じる

" set list
set listchars=tab:❯\ ,trail:˼,extends:»,precedes:«,nbsp:%
if has('diff')
  set diffopt=filler,context:2,vertical,foldcolumn:0
endif

set clipboard=unnamed,unnamedplus
set cpoptions-=m
set cpoptions+=Z
set complete+=d,t

" It seems 15ms overhead.
" set cryptmethod=blowfish2

set t_Co=256
set background=dark

if has('gui_running')
   set guioptions=Mc
endif

" Change cursor shape.
if &term =~ "xterm"
  " let &t_SI = "\e[5 q\e]12;Orange\x7"
  " let &t_EI = "\e[0 q\e]12;RoyalBlue1\x7"
endif

call s:source('function')
call s:source('keymap')

" #autocmds
au uAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
au uAutoCmd VimResized  * if &ft !=# 'help' |  wincmd = | redraw! | endif
au uAutoCmd BufWritePre * call EraseSpace()
au uAutoCmd InsertLeave,CursorHold * if g:u10_autosave != 0 | update | endif
" windowの行数の10%にセットする
au uAutoCmd VimEnter,WinEnter,VimResized * let &scrolloff=float2nr(winheight('') * 0.1)

let g:cursor_hold_count = 0
au uAutoCmd CursorHold,CursorHoldI * call <SID>auto_delete_hidden_buffers()
function! s:auto_delete_hidden_buffers() abort
  if 10 <= g:cursor_hold_count
    ActiveOnly
    let g:cursor_hold_count = 0
  else
    let g:cursor_hold_count += 1
  endif
endfunction

if executable('fcitx-remote')
  command! FcitxOff call system('fcitx-remote -c')
  au uAutoCmd InsertLeave * FcitxOff
endif

command! Rmswap if exists('g:swapname') | call system('rm ' . g:swapname) | endif
au uAutoCmd SwapExists * let g:swapname = v:swapname

au uAutoCmd VimEnter * call s:vimenter()
function! s:vimenter()
  if argc() == 0
    setl buftype=nowrite
  elseif argc() == 1 && !exists('g:swapname')
    " many side effect.
    " e.g: invalid behavior smart_quit() of vimfiler.
    " e.g: swap, grep
    " lcd %:p:h
  endif
endfunction

if !exists('g:noplugin')
  au uAutoCmd FileType    * nested call s:set_colors()
  au uAutoCmd ColorScheme * call s:set_highlights()
endif

let g:colors_name = ''
function! s:colorscheme(name) abort
  if g:colors_name !=# a:name
    execute 'colorscheme' a:name
  endif
endfunction

function! s:set_colors() "{{{
  if -1 != index(['', 'unite', 'quickrun', 'qf'], &filetype)
    return
  endif

  if &filetype == 'cpp' || &filetype == 'c'
    call s:colorscheme('lettuce')
    " call s:colorscheme('kalisi')
    hi Pmenu ctermfg=36 ctermbg=235
  elseif &filetype == 'ruby'
    call s:colorscheme('railscasts_u10')
  elseif &filetype == 'vim'
    call s:colorscheme('BusyBee')
  elseif &filetype == 'gitcommit'
    call s:colorscheme('gitcommit_u10')
  elseif !exists('g:colors_seted')
    call s:colorscheme('molokai')
  endif

  let g:colors_seted = 1
endfunction "}}}

function! s:set_highlights() "{{{
  hi Visual     cterm=reverse
  hi Title      ctermfg=118
  hi Todo       ctermfg=0   ctermbg=226
  hi Error      ctermfg=255 ctermbg=161
  hi QFError    cterm=undercurl ctermfg=198
  hi QFWarning  cterm=undercurl ctermfg=198
  hi DiffAdd    ctermfg=255     ctermbg=163
  hi DiffDelete ctermfg=200     ctermbg=56
  hi DiffChange ctermfg=252     ctermbg=22
  hi DiffText   ctermfg=226     ctermbg=29

  colorscheme vimfiler_color

  if !has('vim_starting')
    execute 'AirlineTheme' g:airline_theme
  endif

  if &diff
    hi clear CursorLine
  endif

  if g:colors_name == 'molokai'
    hi Folded       ctermfg=63
    hi Comment      ctermfg=245
    hi Pmenu        ctermfg=232 ctermbg=6
    hi PmenuSel     ctermfg=232 ctermbg=32
    hi NonText      ctermfg=NONE ctermbg=NONE
  elseif g:colors_name == 'BusyBee'
    hi Normal       ctermbg=233
    hi Folded       ctermfg=0    ctermbg=4
    hi FoldColumn   ctermfg=14   ctermbg=233
    hi Visual       ctermfg=NONE ctermbg=NONE
    hi NonText      ctermfg=NONE ctermbg=NONE
    hi CursorLine   cterm=NONE   ctermbg=234
    hi vimFuncVar ctermfg=198
  endif
endfunction "}}}

" #filetype config "{{{
au uAutoCmd FileType c,cpp    setl commentstring=//\ %s
au uAutoCmd FileType html,css setl foldmethod=indent
au uAutoCmd FileType qf       nnoremap <silent><buffer>q :quit<CR>

au uAutoCmd StdinReadPost * call s:stdin_config()
function! s:stdin_config()
  nnoremap <buffer>q :quit<CR>
  setl buftype=nofile
  setl nofoldenable
  setl foldcolumn=0

  %s/\(_\|.\)//ge
  goto
  silent! %foldopen!
endfunction

"}}}

if filereadable(expand('~/.vimrc.after'))
  source $HOME/.vimrc.after
endif
