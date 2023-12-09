set encoding=utf-8 " Removed in Neovim

set exrc

" set undodir=~/.vim/tmp/undo.txt
set viewdir=~/.vim/tmp/view
set backupdir-=.
set path+=/usr/include/c++/HEAD/
set noswapfile
set nobackup
set nowritebackup

" Encoding: {{{
" set termencoding=utf-8
set fileencodings=utf-8,iso-2022-jp-3,iso-2022-jp,euc-jisx0213,ucs-bom,euc-jp,eucjp-ms,cp932
" Default fileformat.
set fileformat=unix
" Automatic recognition of a new line cord.
set fileformats=unix,dos,mac
"}}}

" Search: {{{
set gdefault
set ignorecase smartcase
set incsearch
set hlsearch | nohlsearch " support reloading
if exists('+inccommand')
  set inccommand=nosplit
endif
"}}}

" Wrap: {{{
set nowrap
if has('linebreak')
  set linebreak
  set breakindent
  " breakする場所 その文字の直後でブレークする
  set breakat=<09>;,/?)

  " breakした行の先頭にうっすら挿入
  set showbreak=>>
  au myac OptionSet tabstop call my#option#set_breakindentopt()
endif
" }}}

" Tab: {{{
" global
set shiftround    " >>とかのインデントがshiftwidthの倍数に丸められる
set smarttab      " 削除とかいい感じに

" buffer-local(引数なしで起動した場合の設定)
set expandtab     " Tabキーでスペース挿入
set nocopyindent  " expandtabを無視して既存行のタブで判定する
set nopreserveindent " ==などでインデントを変更してもタブ文字を保持
call my#option#set_tab(2)
" set vartabstop varsofttabstop

" buffer-localだから各バッファで設定する必要がある
au myac FileType * call my#option#set_tab(2)
"}}}

" Fold: {{{
set foldtext=FoldCCtext()
set foldcolumn=1
set foldlevelstart=99     " どのレベルから折りたたむか
set foldnestmax=10   " indent,syntaxでどの深さまで折りたたむか
" set foldclose=all " 折りたたんでるエリアからでると自動で閉じる
set foldopen=block,hor,mark,percent,quickfix,search,tag,undo
"}}}

" Indent: {{{
set autoindent smartindent
" set cindent
set cinkeys-=0#
" *<return> enterするたびにreindent
set cinoptions+=#0,J1,j1,g0,N-2
" :0 switchとcaseが同じレベルになる

" 自動インデントを発動する条件を指定する
" oなどがあるとMarkdownのインデントで変な挙動をする
" インデントはsmartindentとかに任せとけば良さそう
" set indentkeys=
"}}}

" set sessionoptions
set sessionoptions=buffers,curdir,folds,help,tabpages,winsize,winpos
set viewoptions=folds,options,cursor,curdir

set showfulltag         " Display all the information of the tag by the supplement of the Insert mode.
set tags=tags;$HOME,.tags;$HOME,./tags,./.tags
set tagcase=followscs
" tags;     current-dirからtagsが見つかるまで遡る
" tas;/dir  上記と同じだが/dirより上には行かない

" Disable bell.
set t_vb=
set novisualbell
if has('patch-7.4.793')
  set belloff=all
endif

" set undofile
if has('patch-7.4.2201')
  set signcolumn=yes:2
endif
set showtabline=2
set report=0  " コマンドでN行変更されたら出力
set number
set hidden
set showcmd
set noshowmode
set cursorline
set noshowmatch matchtime=0 " 括弧を入力した時に移動しないようにする
" set laststatus=3
set laststatus=2
set display=lastline,uhex
" set ambiwidth=double " マルチバイト文字があるときのカーソル位置の調節
set cmdheight=2 cmdwinheight=4
set mouse=      " クリックでマウスが動かないように
set title

set keywordprg=:help
" It seems 15ms overhead.
" set cryptmethod=blowfish2
set history=1000
set modeline modelines=2
" TODO <c-g>  <C-l>には補完用のマップがある?
set cedit=<c-l> " move to cmdwin key
set splitright splitbelow
set nostartofline " Maintain a current line at the time of movement as much as possible.
" 特定の方法でバッファを開いたときの動作
set switchbuf=usetab

" Complate: {{{
" set complete+=d,t
set complete-=t
set completeopt=menuone

" 遅延があると操作ミスになる
" set completeopt+=noinsert  " 第1候補を選択 非挿入
" set completeopt+=noselect
"}}}

set sidescroll=0
set sidescrolloff=12
" set virtualedit=block,onemore
set virtualedit=block
set nrformats=hex,bin

if has('nvim')
  set shada=!,'300,<50,s10,h
else
  set viminfo=!,'300,<50,s10,h
endif

set shortmess=aTIcCF
set shortmess+=oO " TODO: 検討中

" Do not display the completion messages
set noshowmode

" Keymapping timeout.
" set timeout timeoutlen=3000 ttimeoutlen=100

" CursorHold time.
set updatetime=100

set commentstring=#\ %s
set backspace=start,eol,indent
set whichwrap=b,s,[,],<,>,h,l
set iskeyword+=$,@-@

" #wild menu
set wildignorecase
set wildignore+=.git/*,.git\\*,.hg/*,.hg\\*,.svn/*,.svn\\*,node_modules/**

if exists('+pumblend')
  set winblend=0
  set pumblend=0
  set pumheight=30
  set wildoptions=pum,tagfile
  set wildmode=full:longest,full
else
  set wildoptions=tagfile " Can supplement a tag in a command-line.
  " 補完候補を全て表示 もう一度<Tab>で巡回
  set wildmenu
  set wildmode=list:longest,full
  " set wildmode=longest:full,full
endif

" set fillchars=diff:-,vert:│
set list
set listchars=tab:❯\ ,extends:»,precedes:«,nbsp:%, " trail:␣
" http://unicode-table.com/en/2A20/
" ❯ ❮ ⊳ ▶ ◇ ± ◈ ▷ ➤ ⟫ ⥀ ⥁ ␣ 》

if has('diff')
  set diffopt=internal,filler,linematch:60,closeoff,context:2,vertical,foldcolumn:0
endif

if has('unnamedplus')
  set clipboard& clipboard^=unnamedplus
else
  set clipboard& clipboard^=unnamed
endif
set cpoptions-=m
set cpoptions+=Z


if exists('+lazyredraw')
  set lazyredraw
endif

if has('conceal')
  " set conceallevel=2 concealcursor=niv
endif

if !has('gui_running')
  set t_Co=256
endif

set background=dark

if has('termguicolors') && $COLORTERM ==# 'truecolor'
  set termguicolors
endif

if has('gui_running')
  set guioptions=Mc
endif

" Change cursor shape.
if &term =~# 'xterm'
endif

if !empty($SUDO_USER) && $USER !=# $SUDO_USER
  set viminfo=
  if has('nvim')
    set shada=
  endif
  set directory-=~/tmp
  set backupdir-=~/tmp
  set undodir=
  set viewdir=
endif

"  eventignore=all " 全てのイベントを無視
" writeany " いかなるファイルも!無しで書き込み
" confirm
