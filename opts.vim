set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,iso-2022-jp-3,iso-2022-jp,euc-jisx0213,ucs-bom,euc-jp,eucjp-ms,cp932
" Default fileformat.
set fileformat=unix
" Automatic recognition of a new line cord.
set fileformats=unix,dos,mac

" set undofile
set report=0  " コマンド似よって0行以上変更されたらmessage
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
set nobackup
set modeline modelines=2
" TODO: <c-g>  <C-l>には補完用のマップがある。
set cedit=<c-l> " move to cmdwin key
set splitright nosplitbelow
set nostartofline " Maintain a current line at the time of movement as much as possible.
" set ttyfast
set completeopt=menuone
set switchbuf=usetab

if has('patch338')
  setg breakindent
endif
set nowrap
set sidescroll=0
set sidescrolloff=12
set virtualedit=block
set nrformats-=octal

" Keymapping timeout.
set timeout timeoutlen=3000 ttimeoutlen=100
" CursorHold time.
set updatetime=2500

" #indent
au u10ac FileType conf,gitcommit,html,css set nocindent
set autoindent cindent
set cinkeys-=0#
" *<Return> enterするたびにreindent
set cinoptions+=#1,J1,j1,g0,N-2
" :0 にすると switchとcaseが同じレベルになる

set backspace=start,eol,indent
set whichwrap=b,s,[,],<,>,h,l
set iskeyword+=$,@-@  "設定された文字が続く限り単語として扱われる @は英数字を表す
                      " _を除くと*での検索がやりずらい
" au u10ac FileType vim setl iskeyword-=# " #を含めると*での検索や補完が楽
" au u10ac FileType zsh setl iskeyword-=-
au u10ac FileType zsh setl iskeyword-=$
au u10ac FileType ruby setl iskeyword+=?

" #menu
set showfulltag         " Display all the information of the tag by the supplement of the Insert mode.
set wildoptions=tagfile " Can supplement a tag in a command-line.
" 補完候補を全て表示 もう一度<Tab>で巡回
set wildmenu
set wildmode=list:longest,full
" set wildmode=longest:full,full

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
au u10ac FileType zsh,ruby setl foldmethod=marker " php perl perl6 javascript clojure
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

" set termguicolors
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Change cursor shape.
if &term =~ "xterm"
  " let &t_SI = "\e[5 q\e]12;Orange\x7"
  " let &t_EI = "\e[0 q\e]12;RoyalBlue1\x7"
endif
