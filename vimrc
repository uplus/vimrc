if 0 | endif

" set debug=throw

language message C
scriptencoding=utf-8

" Very very high speed! ~300ms
set shell=/bin/sh

let g:working_register = 'p'
let $CACHE = $HOME . '/.cache'

if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif

" release keymaps
let mapleader = ';'
for key in ['Q', ';', ',', 's', 'gs', 'gR', 'g8']
  execute 'noremap' key '<Nop>'
endfor

" provider config
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:python3_host_prog = '/usr/bin/python3'

augroup myac
  autocmd!
  " autocmd FileType,Syntax,BufNewFile,BufNew,BufRead * call s:on_filetype()
augroup END

function! s:source(path) abort
  let fpath = expand($HOME . '/.vim/' . a:path . '.vim')
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

" load dein
if &g:loadplugins
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

    " echo luaeval("require'nvim-treesitter.parsers'.list[vim.bo.filetype] ~= nil")
    au FileType * call SetSyntax()
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
