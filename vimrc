if 0 | endif

if &compatible
  set nocompatible
endif

language message C
scriptencoding=utf-8

function! s:source(path)
  execute 'source' fnameescape(expand('~/.vim/' . a:path . '.vim'))
endfunction

function! s:on_filetype() abort
  if execute('filetype') =~# 'OFF'
    " Lazy loading
    silent! filetype plugin indent on
    syntax enable
    filetype detect
  endif
endfunction

augroup u10ac
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

if has('vim_starting') && !empty(argv())
  " call s:on_filetype()
endif

" if !has('vim_starting')
  " echomsg '!vim_starting'
  autocmd u10ac VimEnter * call dein#call_hook('source')
  autocmd u10ac VimEnter * call dein#call_hook('post_source')
  syntax on
  filetype plugin indent on
" endif

" if ! exists('g:noplugin')
"   call s:source('neobundle')
" endif

" Lazy loading
" silent! filetype plugin indent on
" syntax enable
" filetype detect

call s:source('opts')
call s:source('function')
call s:source('keymap')
call s:source('highlights')

" #autocmds
au u10ac BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
au u10ac VimResized  * if &ft !=# 'help' |  wincmd = | redraw! | endif
au u10ac BufWritePre * if expand('%:p') =~ printf("^%s/.*", $HOME) | call EraseSpace() | endif
au u10ac InsertLeave,CursorHold * if g:u10_autosave != 0 | update | endif
" windowの行数の10%にセットする
au u10ac VimEnter,WinEnter,VimResized * let &scrolloff=float2nr(winheight('') * 0.1)

" Skip return code when quit terminal.
if has('nvim')
  au u10ac TermOpen * call s:term_config()
  au u10ac TermClose * call feedkeys('\<cr>')

  function s:term_config()
    au u10ac BufEnter <buffer> call feedkeys('a')
    " au u10ac InsertLeave <buffer> call feedkeys('\<c-w>q') " Don't work endfunction
  endfunction
endif

if '' != $DISPLAY
  let @" = @*
  if exists('##TextYankPost')
    au TextYankPost * let @*=@" | let @+=@"
  endif
endif

if has('timers')
  function! Handler_DeleteTrashBuffers(timer) abort
    silent DeleteTrashBuffers
  endfunction
  call timer_start(1000, 'Handler_DeleteTrashBuffers', {'repeat': -1})
endif

if executable('fcitx-remote')
  command! FcitxOff call system('fcitx-remote -c')
  au u10ac InsertLeave * FcitxOff
endif

command! Rmswap if exists('g:swapname') | call system('rm ' . g:swapname) | endif
au u10ac SwapExists * let g:swapname = v:swapname

au u10ac VimEnter * call s:vimenter()
function! s:vimenter()
  if argc() == 0
    setl buftype=nowrite
  elseif argc() == 1 && !exists('g:swapname')
    " many side effect.
    " e.g invalid behavior smart_quit() of vimfiler.
    " e.g swap, grep
    " lcd %:p:h
  endif
endfunction

" #filetype config "{{{
au u10ac FileType c,cpp    setl commentstring=//\ %s
au u10ac FileType html,css setl foldmethod=indent
au u10ac FileType qf,help  nnoremap <silent><buffer>q :quit<CR>
au u10ac FileType text     setl nobreakindent wrap

au u10ac StdinReadPost * call s:stdin_config()
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
