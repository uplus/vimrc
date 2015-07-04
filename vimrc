if &compatible
  set nocompatible
endif

function! Source_rc(path)
  execute 'source' fnameescape(expand('~/.vim/rc/' . a:path))
endfunction

function! IsMac()
  return has('mac') || has('macunix') || has('gui_mac')
endfunction

filetype off
filetype plugin indent off
set viminfo+=n~/.vim/tmp/info.txt
set path+=/usr/include/c++/HEAD/

set enc=utf-8
set number
set cursorline
set nocursorcolumn
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
set ignorecase
set backspace=start,eol,indent
set whichwrap=b,s,[,],<,>,~
"set virtualedit=onemore
set wildmenu
set wildmode=longest:full,full
set scrolloff=10
set wrapscan  "最後尾まで検索を終えたら次の検索で先頭に戻る
"set confirm  "未保存のファイルがあるときは終了前に確認
"set autoread "外部でファイルが変更された時読みなおす
set iskeyword+=$,@-@  "設定された文字が続く限り単語として扱われる @は英数字を表す
set nrformats-=octal  " 加減算で数値を8進数として扱わない

set tabstop=2               "Tab表示幅
let &softtabstop=&tabstop "Tab押下時のカーソル移動量
let &shiftwidth=&tabstop "インデント幅
set expandtab     "Tabキーでスペース挿入

set autoindent
set smartindent
set foldmethod=marker
set foldlevel=0
set foldnestmax=2

if IsMac()
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

"ここらへんの意味がわからない
set showcmd
set matchtime=1
set cmdwinheight=4

function! FoldText()
  let base  = foldtext()
  let title = substitute(base, '\s*\d.*:', '', 'g')
  return title
endfunction

set foldtext=FoldText()

" Capture {{{
command!
      \ -nargs=+ -bang
      \ -complete=command
      \ Capture call Capture(<f-args>)

function! Capture(cmd)
  redir => l:out
  silent execute a:cmd
  redir END
  let g:capture = substitute(l:out, '\%^\n', '', '')
  return g:capture
endfunction
" }}}

" Capture New window {{{
command!
      \ -nargs=+ -bang
      \ -complete=command
      \ CaptureWin call CaptureWin(<f-args>)

function! CaptureWin(cmd)
  redir => result
  silent execute a:cmd
  redir END

  let bufname = 'Capture: ' . a:cmd
  new
  setlocal bufhidden=unload
  setlocal nobuflisted
  setlocal buftype=nofile
  setlocal noswapfile
  silent file `=bufname`
  silent put =result
  1,2delete _
endfunction
" }}}

function! EraseSpace()
  if &filetype != 'markdown' && &filetype != 'gitcommit'
    let s:cursor = getpos(".")
    %s/^\s\+$//ge
    %s/\s\+$//ge
    call setpos(".", s:cursor)
  endif
endfunction

command! EraseSpace :call EraseSpace()
command! NoEraseSpace :au! BufWritePre

au BufReadPost  * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
au BufWritePre  * EraseSpace
au BufEnter     * lcd %:p:h

" CurrentOnly {{{
command! Conly call CurrentOnly()
command! CurrentOnly call CurrentOnly()
function! CurrentOnly()
  Capture buffers

  let l:current=bufnr('%')
  let l:count=0
  for b in split(substitute(g:capture, '\s', '', 'g'), '\n')
    let n = matchstr(b, '^\d*')
    if l:n != l:current
      execute 'bdelete' l:n
      let l:count+=1
    endif
  endfor
  echo l:count "buffer deleted"
endfunction
"}}}

command! BufferCount ruby print VIM::Buffer.count
function! BufferCount()
  Capture BufferCount
  return g:capture
endfunction

" #source
source ~/.vim/neobundle.vim
source ~/.vim/keymap.vim
source ~/.vim/filetype.vim

filetype plugin indent on
syntax enable
set t_Co=256
set background=dark

augroup call_functions
  autocmd!
  au FileType * call s:set_colors()
  au FileType * call s:only_once()
  au FileType * call s:set_highlight_sub()
augroup END

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
  highlight Todo            ctermfg=16 ctermbg=220
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

