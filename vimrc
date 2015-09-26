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

function! s:source_rc(path)
  execute 'source' fnameescape(expand('~/.vim/rc/' . a:path))
endfunction

augroup uAutoCmd
  autocmd!
augroup END

command! -nargs=1 Source
      \ execute 'source' expand('~/.vim/' . <args> . '.vim')

let $CACHE = expand('~/.cache')
set viminfo+=n~/.vim/tmp/info.txt
set undodir=~/.vim/tmp/undo.txt
set viewdir=~/.vim/tmp/view
set path+=/usr/include/c++/HEAD/

if filereadable(expand('~/.vimrc_local_before'))
  source $HOME/.vimrc_local_before
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
nnoremap gr <Nop>
xnoremap gr <Nop>
nnoremap gR <Nop>
xnoremap gR <Nop>
nnoremap gh <Nop>
xnoremap gh <Nop>
nnoremap gm <Nop>
xnoremap gm <Nop>
nnoremap g8 <Nop>
xnoremap g8 <Nop>
nnoremap g<C-G> <Nop>
xnoremap g<C-G> <Nop>
"}}}

Source 'neobundle'
filetype plugin indent on
syntax enable

if has('vim_starting')
  NeoBundleCheck
endif

set encoding=utf-8
set fileformats=unix,mac
set fileencodings=ucs-bom,utf-8,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932

" set undofile
set report=0  " コマンド似よって0行以上変更されたらmessage
set nonumber
set hidden
set showcmd
set cursorline
set showmatch   " 閉じ括弧が入力された時、対応する括弧にわずかの間ジャンプする
set matchtime=0 " 括弧を入力した時に移動しないようにする
set laststatus=2
set cmdheight=2 cmdwinheight=4
set mouse=      " クリックでマウスが動かないように
set nobackup
set modeline modelines=2
set cedit=<C-L> " move to cmdwin key
set splitright nosplitbelow
set nostartofline " Maintain a current line at the time of movement as much as possible.
set ttyfast
set completeopt=menuone
set switchbuf=usetab

if has('patch755')
  set completeopt+=noinsert
endif

set nowrap
set breakindent
set sidescroll=1
set sidescrolloff=12
set virtualedit=block
set nrformats-=octal

" Keymapping timeout.
set timeout timeoutlen=3000 ttimeoutlen=100
" CursorHold time.
set updatetime=500

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
set hlsearch | nohlsearch "Highlight search patterns, support reloading

" #tab
set shiftround
set expandtab     "Tabキーでスペース挿入
set tabstop=2     "Tab表示幅
set softtabstop=2 "Tab押下時のカーソル移動量
set shiftwidth=2  "インデント幅
" set smarttab

" #fold
set foldmethod=marker
set foldtext=FoldCCtext()
set foldcolumn=1
set foldlevelstart=0     " どのレベルから折りたたむか
set foldnestmax=3   " indent,syntaxでどの深さまで折りたたむか
" set foldclose=all " 折りたたんでるエリアからでると自動で閉じる

" set list
set listchars=tab:❯\ ,trail:˼,extends:»,precedes:«,nbsp:%

set clipboard=unnamed,unnamedplus
set cpoptions-=m
set cpoptions+=Z
set complete+=d,t
set cryptmethod=zip,blowfish,blowfish2
set diffopt=filler,context:2,vertical,foldcolumn:0

set t_Co=256
set background=dark

" Change cursor shape.
if &term =~ "xterm"
  let &t_SI = "\<Esc>]12;lightgreen\x7"
  let &t_EI = "\<Esc>]12;white\x7"
endif

Source 'function'
Source 'keymap'

" #auto commands
au uAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
au uAutoCmd VimResized  * wincmd =
au uAutoCmd BufWritePre * EraseSpace

au uAutoCmd VimEnter    * call s:vimenter()
function s:vimenter()
  if argc() == 0
    setl buftype=nowrite
  elseif argc() == 1
    lcd %:p:h
  endif
endfunction

" windowの行数の20%にセットする
command! SmartScrolloff let &scrolloff=float2nr(winheight('') * 0.1)
au uAutoCmd VimEnter,WinEnter,VimResized * SmartScrolloff
au uAutoCmd InsertLeave * if executable('fcitx-remote') | call system('fcitx-remote -c') | endif

au uAutoCmd FileType vim setl keywordprg=:help
au uAutoCmd FileType vim nnoremap <silent><buffer>K :help <C-r><C-a><CR>
au uAutoCmd FileType vim nnoremap <silent><buffer>gD :call GotoVimFunction()<CR>

au uAutoCmd FileType * nested call s:set_colors()
au uAutoCmd ColorScheme * call s:set_highlights()

function! s:set_colors() "{{{
  if exists("g:set_colors")
    return
  end

  if &filetype == 'vimfiler'
    let g:set_airline_color = 1
  endif

  if &filetype == 'cpp' || &filetype == 'c'
    colorscheme lettuce
    " colorscheme kalisi
    hi Pmenu ctermfg=36 ctermbg=235
  elseif &filetype == 'ruby' || &filetype == 'gitcommit'
    colorscheme railscasts_u10
  elseif &filetype == 'vim'
    colorscheme BusyBee
  else
    colorscheme molokai
  endif

  let g:set_colors=1
endfunction "}}}

function! s:set_highlights() "{{{
  hi Visual     cterm=reverse
  hi Todo       ctermfg=201     ctermbg=56
  hi QFError    cterm=undercurl ctermfg=198
  hi QFWarning  cterm=undercurl ctermfg=198
  hi DiffAdd    ctermfg=255     ctermbg=27
  hi DiffDelete ctermfg=200     ctermbg=56
  hi DiffChange ctermfg=252     ctermbg=22
  hi DiffText   ctermfg=226     ctermbg=29
  colorscheme vimfiler_color

  if exists("g:set_airline_color") && g:set_airline_color
    colorscheme airline_color
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
    hi Folded       ctermfg=0    ctermbg=24
    hi FoldColumn   ctermfg=14   ctermbg=233
    hi Visual       ctermfg=NONE ctermbg=NONE
    hi NonText      ctermfg=NONE ctermbg=NONE
    hi CursorLine   cterm=NONE   ctermbg=234
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

au uAutoCmd FileType diff call s:diff_config()
function! s:diff_config()
  nnoremap <silent><buffer> q :q<CR>
  setl foldmethod=diff
  setl foldcolumn=0
endfunction

au uAutoCmd FileType help call s:help_config()
function! s:help_config()
  nnoremap <silent><buffer> q :q<CR>
  setl nofoldenable
  setl foldcolumn=0
  setl number
endfunction

au uAutoCmd FileType gitrebase call s:gitrebase_config()
function! s:gitrebase_config() abort
  noremap <silent><buffer><C-j>p :Pick<CR>
  noremap <silent><buffer><C-j>r :Reword<CR>
  noremap <silent><buffer><C-j>e :Edit<CR>
  noremap <silent><buffer><C-j>s :Squash<CR>
  noremap <silent><buffer><C-j>f :Fixup<CR>
endfunction
"}}}

" #autosave "{{{
au uAutoCmd InsertLeave,CursorHold * if g:u10_autosave != 0 | update | endif
nnoremap <silent><F2> :call AutoSave()<CR>
command! AutoSave call AutoSave()

let g:u10_autosave = 0
function! AutoSave()
  silent update
  let g:u10_autosave = !g:u10_autosave
  echo "autosave" g:u10_autosave? "enabled" : "disabled"
endfunction
"}}}

if filereadable(expand('~/.vimrc_local_after'))
  source $HOME/.vimrc_local_after
endif

