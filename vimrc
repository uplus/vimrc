if 0 | endif

if &compatible
  set nocompatible
endif

language message C
scriptencoding=utf-8

augroup u10ac
  autocmd!
augroup END

function! s:source(path)
  let fpath = expand('~/.vim/' . a:path . '.vim')
  if filereadable(fpath)
    execute 'source' fnameescape(fpath)
  endif
endfunction

function! s:on_filetype() abort
  if execute('filetype') =~# 'OFF'
    " Lazy loading
    silent! filetype plugin indent on
    syntax enable
    filetype detect
  endif
endfunction

let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif

call s:source('before')

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

command! Recache call dein#clear_state() | call dein#recache_runtimepath() | UpdateRemotePlugins
command! Q qall!
command! W w!
command! Sh update | shell
command! ReloadKeymap source ~/.vim/keymap.vim
command! Tig execute "silent! !tig status" | redraw!
command! TmpCommit !git tmpc
command! WWW w !sudo tee > /dev/null %
command! Cdbuffer cd %:h
command! Lcdbuffer lcd %:h
command! -nargs=? Ls !ls -F --color=always <args>
command! -nargs=+ Cal echo eval(<q-args>)
command! Zatof normal! 0diwf=cl()lxC{Px>>o}
command! Narrow set laststatus=0 cmdheight=1 showtabline=0
command! -nargs=* Job call jobstart(<q-args>)
command! -nargs=1 Char echo printf("%c", 0x<args>)

" #autocmds
au u10ac BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
au u10ac VimResized  * if &ft !=# 'help' |  wincmd = | redraw! | endif
au u10ac BufWritePre * if expand('%:p') =~ printf("^%s/.*", $HOME) | call EraseSpace() | endif
au u10ac InsertLeave,CursorHold * call DoAutoSave()
" au u10ac CursorHold *.toml syntax sync minlines=300
if exists('##FocusLost')
  au u10ac FocusLost * call DoAutoSave()
endif
" windowの行数の10%にセットする
au u10ac VimEnter,WinEnter,VimResized * let &scrolloff=float2nr(winheight('') * 0.1)

" nohlsearchする代わりに出力が常に消える
" visual modeがバグる
" au u10ac CursorMoved * call feedkeys(":silent nohlsearch\<cr>\<c-l>")

" Skip return code when quit terminal.
if has('nvim')
  au u10ac TermOpen * call s:term_config()
  au u10ac TermClose term://*$SHELL call feedkeys('\<cr>')

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
  " 運が悪いとキー入力中に割り込まれる
  " call timer_start(30000, 'Handler_DeleteTrashBuffers', {'repeat': -1})
endif

if executable('fcitx-remote')
  command! FcitxOff call system('fcitx-remote -c')
  au u10ac InsertLeave * FcitxOff

  if exists('##FocusGained')
    au u10ac FocusGained * FcitxOff
  endif
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

call s:source('after')
