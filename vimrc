if 0 | endif

" set debug=throw

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

function! s:source(path) abort "{{{
  let fpath = expand($HOME . '/.vim/' . a:path . '.vim')
  if filereadable(fpath)
    execute 'source' fnameescape(fpath)
  endif
endfunction "}}}

function! s:on_filetype() abort "{{{
  if execute('filetype') =~# 'OFF'
    " Lazy loading
    silent! filetype plugin indent on
    syntax enable
    filetype detect
  endif
endfunction "}}}

let $CACHE = $HOME . '/.cache'

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
"}}}

call s:source('before')

" load dein
if !exists('g:noplugin')
  call s:source('dein')

  if has('vim_starting') && !empty(argv())
    " 先の実行しないとInsertEnterあたりでいろいろ発生してしまう
    syntax enable
    filetype detect
  "   call s:on_filetype()
  endif

  call s:source('plugins-config')

  augroup myac
    " autoloadにするとワンテンポ遅くなる
    au VimEnter * call dein#call_hook('source')
    au VimEnter * call dein#call_hook('post_source')

    " treesitterでサポートされてない色に色を付けるためにこのタイミングで必要
    au FileType vim,markdown,make,dockerfile,neosnippet,help let &syntax=&filetype
    " au VimEnter * call lightline#highlight()
    " au VimEnter * if &l:ft ==# '' | filetype detect | endif
  augroup END
endif

call s:source('options')
call s:source('highlights')
call s:source('functions')
call s:source('keymaps')
call s:source('commands')
call s:source('autocmds')

call s:source('after')

set secure
