if &compatible
  set nocompatible
endif

augroup uAutoCmd
  autocmd!
augroup END

command! -nargs=1 Source
      \ execute 'source' expand('~/.vim/' . <args> . '.vim')

command! -nargs=1 RcSource
      \ Source 'rc/' . <args> .  '.rc'

function! IsMac()
  return (has('mac') || has('macunix') || has('gui_macvim') ||
        \   (!executable('xdg-open') && system('uname') =~? '^darwin'))
endfunction


filetype off
filetype plugin indent off
set viminfo+=n~/.vim/tmp/info.txt
set path+=/usr/include/c++/HEAD/

" #vim system config "{{{
language message C
scriptencoding=utf-8
set encoding=utf-8
set fileformats=unix,dos,mac
" set fileencodings=ucs-bom,utf-8,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set number
set cursorline nocursorcolumn
set showmatch
set matchtime=1
set laststatus=2
set cmdheight=2
set cmdwinheight=4
set timeout ttimeout
set timeoutlen=3000
set ttimeoutlen=100
set nobackup
set mouse=a
set showcmd " 入力中のキーマップを表示する
let &clipboard = IsMac()? 'unnamed' : 'unnamedplus'
set hidden
"}}}

" #action config " {{{
set autoindent smartindent
set ignorecase smartcase
set wrapscan  "最後尾まで検索を終えたら次の検索で先頭に戻る
set backspace=start,eol,indent
set whichwrap=b,s,[,],<,>
" set whichwrap+=h,l
set matchpairs+=<:>
"set virtualedit=onemore
set wildmenu
set wildmode=longest:full,full
set iskeyword+=$,@-@  "設定された文字が続く限り単語として扱われる @は英数字を表す
set iskeyword-=#
set nrformats-=octal  " 加減算で数値を8進数として扱わない
" }}}

" #tab
set expandtab     "Tabキーでスペース挿入
set tabstop=2     "Tab表示幅
set softtabstop=2 "Tab押下時のカーソル移動量
set shiftwidth=2  "インデント幅
" set smarttab

" #fold
set foldmethod=marker
set foldlevel=0
set foldnestmax=2
set foldtext=FoldCCtext()

" set list
set listchars=tab:❯\ ,trail:˼,extends:»,precedes:«,nbsp:%

au uAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
au uAutoCmd BufEnter    * lcd %:p:h
au uAutoCmd VimResized   * wincmd =

" windowの行数の20%にセットする scrolloffはglobal-option
command! SmartScrolloff let &scrolloff=float2nr(winheight('')*0.2)
au uAutoCmd VimEnter * SmartScrolloff
au uAutoCmd WinEnter * SmartScrolloff

nnoremap Q <Nop>
" #Source
Source 'function'
Source 'neobundle'
Source 'keymap'

" Change cursor shape.
if &term =~ "xterm"
  let &t_SI = "\<Esc>]12;lightgreen\x7"
  let &t_EI = "\<Esc>]12;white\x7"
endif

syntax enable
set t_Co=256
set background=dark
if has('vim_starting')
  NeoBundleCheck
endif


augroup call_functions
  autocmd!
  au FileType * call s:set_colors()
  au FileType * call s:only_once()
  au FileType * call s:set_highlight_sub()
augroup END

" TODO: 動作検証
" cmdは文字列とれるようにした方がいいかも
function! OneShotAutocmd(name, event, pattern, cmd) "{{{
  function l:tmp_func()
    {a:cmd}
    autocmd! {a:name}
  endfunction

  augroup a:name
    autocmd!
    autocmd {a:event} {a:pattern} call l:tmp_func()
  augroup END
endfunction "}}}

function! s:set_colors() "{{{
  if exists("g:set_colors")
    return 0
  end

  if &filetype == 'cpp' || &filetype == 'c'
    colorscheme lettuce
    " colorscheme kalisi
  elseif &filetype == 'ruby' || &filetype == 'gitcommit'
    colorscheme railscasts_u10
  elseif &filetype == 'vimfiler'
    " 一度だけ実行するautocmd
    augroup set_airline_color
      autocmd!
      autocmd FileType * colorscheme airline_color | autocmd! set_airline_color
    aug END

    colorscheme vimfiler_color
    return 0
  else
    colorscheme molokai
  endif

  colorscheme vimfiler_color

  let g:set_colors=1
endfunction "}}}

function! s:set_highlight_sub() " {{{
  highlight Search          ctermfg=39 ctermbg=56
  highlight IncSearch       ctermfg=39 ctermbg=50
  highlight Visual          cterm=reverse
  highlight YankRoundRegion cterm=italic
endfunction " }}}

function! s:only_once() "{{{
  if exists("g:only_once")
    return 0
  endif

  SpeedDatingFormat! %v
  SpeedDatingFormat! %^v

  let g:only_once = 1
endfunction "}}}

" each filetype config
au uAutoCmd FileType c,cpp,ruby,zsh,php,perl set cindent
au uAutoCmd FileType vim nnoremap <silent> gca A<Tab>"<Space>
au uAutoCmd FileType c,cpp set commentstring=//\ %s
au uAutoCmd FileType html,css set foldmethod=indent

au uAutoCmd FileType help call s:help_config()
function! s:help_config()
  nnoremap <buffer> q :q<CR>
  setlocal foldmethod=indent
  setlocal foldlevel=2
  setlocal foldenable
endfunction
