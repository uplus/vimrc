if 0 | endif

if &compatible
  set nocompatible
endif

language message C
scriptencoding=utf-8

augroup u10ac
  autocmd!
  " autocmd FileType,Syntax,BufNewFile,BufNew,BufRead * call s:on_filetype()
augroup END

let g:working_register = 'p'

function! s:source(path)
  let fpath = expand('~/.vim/' . a:path . '.vim')
  if filereadable(fpath)
    execute 'source' fnameescape(fpath)
  endif
endfunction

function! s:on_filetype() abort
  if execute('filetype') =~# 'OFF'
    filetype plugin indent on
    syntax enable
    filetype detect
  endif
endfunction

let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif

" #release keymaps"{{{
let mapleader = ';'
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

call s:source('before')

" load dein
if !exists('g:noplugin')
  call s:source('dein')
endif

call s:source('opts')
call s:source('function')
call s:source('keymap')
call s:source('highlights')
call s:source('cmds')

filetype plugin indent on
syntax enable

" ftdetectいらなそう
" call s:on_filetype()

" #autocmds "{{{
augroup u10ac
  au CursorMoved * call u10#auto_cursorcolumn()
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  au VimResized  * if &ft !=# 'help' |  wincmd = | redraw! | endif
  au BufWritePre * if expand('%:p') =~ printf("^%s/.*", $HOME) | call EraseSpace() | endif
  au InsertLeave,CursorHold,WinLeave * call DoAutoSave()
  au SwapExists * let g:swapname = v:swapname
  au CursorHold * silent ActiveOnly
  au CursorHold *.toml syntax sync minlines=300

  " windowの行数の10%にセットする
  au VimEnter,WinEnter,VimResized * let &scrolloff=float2nr(winheight('') * 0.1)

  " Terminal
  if has('nvim')
    " Skip return code when quit terminal.
    au TermClose term://*$SHELL call feedkeys('\<cr>')

    au TermOpen * call s:term_config()
    function s:term_config()
      au BufEnter <buffer> call feedkeys('a')
      " au InsertLeave <buffer> call feedkeys('\<c-w>q') " Don't work endfunction
    endfunction
  endif

  " Sync clipboard
  if '' != $DISPLAY
    let @" = @*
    if exists('##TextYankPost')
      au TextYankPost * let @*=@" | let @+=@"
    endif
  endif

  " Auto off fcitx
  if executable('fcitx-remote')
    au InsertLeave * FcitxOff
    if exists('##FocusGained')
      au FocusGained * FcitxOff
    endif
  endif

  " Auto save
  if exists('##FocusLost')
    au FocusLost * call DoAutoSave()
  endif

  " nohlsearchする代わりに出力が常に消える
  " visual modeがバグる
  " au CursorMoved * call feedkeys(":silent nohlsearch\<cr>\<c-l>")
augroup END
"}}}

au u10ac VimEnter * call s:vimenter()
function! s:vimenter() "{{{
  if argc() == 0
    setl buftype=nowrite
  elseif argc() == 1 && !exists('g:swapname')
    " many side effect.
    " e.g invalid behavior smart_quit() of vimfiler.
    " e.g swap, grep
    " lcd %:p:h
  endif
endfunction "}}}

" #filetype config "{{{
augroup u10ac
  au FileType html,css setl foldmethod=indent | setl foldlevel=20
  au FileType qf,help,vimconsole  nnoremap <silent><buffer>q :quit<CR>
  au FileType text     setl nobreakindent wrap
  au StdinReadPost * call s:stdin_config()
augroup END

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
