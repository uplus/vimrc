if 0 | endif

language message C
scriptencoding=utf-8
" Very very high speed! ~300ms
set shell=/bin/sh

augroup myac
  autocmd!
  " autocmd FileType,Syntax,BufNewFile,BufNew,BufRead * call s:on_filetype()
augroup END

let g:working_register = 'p'

" After 7.4.2071, can use v:t_*
let g:type_func = type(function('getline'))
let g:type_int = type(0)
let g:type_float = type(0.0)
let g:type_str = type('')
let g:type_list = type([])
let g:type_dic = type({})
if exists('v:null')
  let g:type_bool = type(v:true)
  let g:type_null = type(v:null)
endif

function! s:source(path) "{{{
  let fpath = expand('~/.vim/' . a:path . '.vim')
  if filereadable(fpath)
    execute 'source' fnameescape(fpath)
  endif
endfunction "}}}

function! s:on_filetype() abort "{{{
  if execute('filetype') =~# 'OFF'
    filetype plugin indent on
    syntax enable
    filetype detect
  endif
endfunction "}}}

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
call s:source('functions')
call s:source('keymaps')
call s:source('highlights')
call s:source('commands')
call s:source('autocmds')

filetype plugin indent on
syntax enable

" ftdetectいらなそう
" call s:on_filetype()

" #filetype config "{{{
augroup myac
  au FileType html,css setl foldmethod=indent | setl foldlevel=20
  au FileType qf,help,vimconsole,diff,ref-* nnoremap <silent><buffer>q :quit<cr>
  au FileType conf,gitcommit,html,css set nocindent
  au StdinReadPost * call s:stdin_config()
  au VimEnter * call s:vimenter()

  au FileType gundo,vimfiler,quickrun setl foldcolumn=0
  au FileType gundo,vimfiler,quickrun,help,diff if has('patch-7.4.2201') | setl signcolumn=no | endif

  " preview window {{{
  if exists('##OptionSet')
    au OptionSet previewwindow,diff call s:quit_map()

    function! s:quit_map() abort
      if &previewwindow || &diff
        nnoremap <silent><buffer>q :quit<cr>
      endif
    endfunction
  endif
  "}}}

  function! s:stdin_config() "{{{
    call SetAsScratch()
    setl nofoldenable
    setl foldcolumn=0
    goto
    silent! %foldopen!
  endfunction "}}}

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
augroup END
"}}}


call s:source('after')
