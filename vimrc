if &compatible
  set nocompatible
endif

filetype off
filetype plugin indent off
set path+=/usr/include/c++/4.9.1,/usr/include/linux
set viminfo+=n~/.vim/tmp/info.txt

set enc=utf-8
set number
set cursorline
set showmatch       " Show matching brackets.
set laststatus=2
set cmdheight=2

set timeout
set ttimeout          " なくても同じ
set timeoutlen=3000
set ttimeoutlen=100
set nobackup
set mouse=a
set nohidden
set clipboard=unnamedplus   "この形なら動作した
set backspace=start,eol,indent
set whichwrap=b,s,[,],<,>,~
"set virtualedit=onemore
set wildmenu
set wildmode=longest:full,full
set incsearch
set hlsearch            "検索候補をハイライト :noh でハイライトを消す
set scrolloff=10
set wrapscan  "最後尾まで検索を終えたら次の検索で先頭に戻る
"set confirm  "未保存のファイルがあるときは終了前に確認
"set autoread "外部でファイルが変更された時読みなおす
set iskeyword+=$,@-@  "設定された文字が続く限り単語として扱われる @は英数字を表す

set tabstop=2               "Tab表示幅
let &softtabstop = &tabstop "Tab押下時のカーソル移動量
let &shiftwidth  = &tabstop "インデント幅
set expandtab     "Tabキーでスペース挿入
set autoindent
set smartindent

"ここらへんの意味がわからない
set showcmd
set matchtime=1

function! EraseSpace_func()
  if &filetype != 'markdown'
    let s:cursor = getpos(".")
    %s/^\s\+$//ge
    %s/\s\+$//ge
    call setpos(".", s:cursor)
  endif
endfunction

command! EraseSpace :call EraseSpace_func()
command! NoEraseSpace :au! BufWritePre


if has("autocmd")
  " Remenber position
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  au BufWritePre * EraseSpace
endif


  "==============="
  "   Dark vim?   "
  "==============="
"#Neobundle
source ~/.vim/neobundle.vim

"#When insert mode, change status line's color
source ~/.vim/imode-color.vim

"#Keymap
source ~/.vim/keymap.vim

"#Filetype
source ~/.vim/filetype.vim

filetype plugin indent on
syntax enable
set t_Co=256    " 色を256にしてくれる


"######################
"######################
  "------------"
  "    Keep    "
  "------------"
"set term=gnome-256color
"set term=xterm-256color  "execute in the railscasts-yuuto

"set term=screen-256color "あってもなくても動作は変わらなかった
"set term=screen-256color-bce
  "set <xHome>=OH
  "set <xEnd>=OF

  "-------------"
  "    Trash    "
  "-------------"
