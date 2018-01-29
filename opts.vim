set encoding=utf-8 " Removed in Neovim
scriptencoding utf-8

" set undodir=~/.vim/tmp/undo.txt
" set viewdir=~/.vim/tmp/view
set backupdir-=.
set path+=/usr/include/c++/HEAD/
set swapfile
set nobackup
set nowritebackup

" #encoding {{{
set termencoding=utf-8
set fileencodings=utf-8,iso-2022-jp-3,iso-2022-jp,euc-jisx0213,ucs-bom,euc-jp,eucjp-ms,cp932
" Default fileformat.
set fileformat=unix
" Automatic recognition of a new line cord.
set fileformats=unix,dos,mac
"}}}

" #search {{{
set gdefault
set ignorecase smartcase
set incsearch
set nohlsearch | nohlsearch "Highlight search patterns, support reloading
"}}}

" #tab {{{
set shiftround
set expandtab     "Tabキーでスペース挿入
set tabstop=2     "Tab表示幅
set softtabstop=2 "Tab押下時のカーソル移動量
set shiftwidth=2  "インデント幅
set smarttab      "削除とかいい感じに
set nocopyindent  "expandtabを無視して既存行のタブで判定する
set nopreserveindent " ==などでインデントを変更してもタブ文字を保持
"}}}

" #fold {{{
set foldmethod=syntax
set foldtext=FoldCCtext()
set foldcolumn=1
set foldlevelstart=0     " どのレベルから折りたたむか
set foldnestmax=3   " indent,syntaxでどの深さまで折りたたむか
" set foldclose=all " 折りたたんでるエリアからでると自動で閉じる
set foldopen=block,hor,mark,percent,quickfix,search,tag,undo
"}}}

" #indent {{{
set autoindent smartindent
" set cindent
set cinkeys-=0#
" *<return> enterするたびにreindent
set cinoptions+=#0,J1,j1,g0,N-2
" :0 switchとcaseが同じレベルになる
" set indentkeys=
"}}}

set showfulltag         " Display all the information of the tag by the supplement of the Insert mode.
set tags=tags;$HOME,.tags;$HOME,./tags,./.tags
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
  set signcolumn=yes
endif
set showtabline=2
set modelines=1
set report=0  " コマンドでN行変更されたら出力
set number
set hidden
set showcmd
set noshowmode
set cursorline
set noshowmatch matchtime=0 " 括弧を入力した時に移動しないようにする
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
set switchbuf=usetab

set completeopt=menuone
set complete+=d,t
if has('patch-7.4.775')
  set completeopt+=noinsert  " 第1候補を選択 非挿入
  " set completeopt+=noselect
endif

set nowrap
if has('linebreak')
  set breakindent
endif
set sidescroll=0
set sidescrolloff=12
set virtualedit=block
set nrformats-=octal

if has('nvim')
  set shada=!,'300,<50,s10,h
else
  set viminfo=!,'300,<50,s10,h
endif

" set shortmess=filnxtToO " default
" Do not display the greetings message at the time of Vim start.
set shortmess=aTI
" Do not display the completion messages
set noshowmode
if has('patch-7.4.314')
  set shortmess+=c
endif

" Do not display the edit messages
if has('patch-7.4.1570')
  set shortmess+=F
endif

" Keymapping timeout.
set timeout timeoutlen=3000 ttimeoutlen=100
" CursorHold time.
set updatetime=1000

set commentstring=#\ %s
set backspace=start,eol,indent
set whichwrap=b,s,[,],<,>,h,l
set iskeyword+=$,@-@

" #wild menu
set wildoptions=tagfile " Can supplement a tag in a command-line.
" 補完候補を全て表示 もう一度<Tab>で巡回
set wildmenu
set wildmode=list:longest,full
" set wildmode=longest:full,full

set fillchars=diff:-,vert:│
set list
set listchars=tab:❯\ ,extends:»,precedes:«,nbsp:%, " trail:␣
" http://unicode-table.com/en/2A20/
" ❯ ❮ ⊳ ▶ ◇ ± ◈ ▷ ➤ ⟫ ⥀ ⥁ ␣ 》

if has('diff')
  set diffopt=filler,context:2,vertical,foldcolumn:0
endif

" set clipboard=unnamed,unnamedplus
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus
else
  set clipboard& clipboard+=unnamed
endif
set cpoptions-=m
set cpoptions+=Z

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

if has('nvim')
  " set inccommand=split
  let g:python_host_prog  = '/usr/bin/python2'
  let g:python3_host_prog = '/usr/bin/python3'
else
  " let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  " let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  " let &t_ti .= "\e[?2004h"
  " let &t_te .= "\e[?2004l"
  " let &t_ti .= "\e[?1004h"
  " let &t_te .= "\e[?1004l"
  let &pastetoggle = "\e[201~"
endif

" Change cursor shape.
if &term =~# 'xterm'
  " let &t_SI = "\e[5 q\e]12;Orange\x7"
  " let &t_EI = "\e[0 q\e]12;RoyalBlue1\x7"
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

let g:my_autosave = 1
