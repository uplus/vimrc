if 0 | endif

" set debug=throw

language message C
scriptencoding utf-8

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

" Disable unnecessary keymaps
let g:netrw_nogx = 1

" provider config
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:python3_host_prog = '/usr/bin/python3'

augroup myac
  autocmd!
augroup END

function! s:source(path) abort
  let fpath = expand($HOME . '/.vim/' . a:path)
  if filereadable(fpath)
    execute 'source' fnameescape(fpath)
  endif
endfunction

call s:source('options.vim')

" load dein
if &g:loadplugins
  call s:source('dein.vim')

  if has('vim_starting') && !empty(argv())
    " nvimではsyntax enableなどが必要ない
  endif

  call s:source('highlights.vim')

  augroup myac
    " lazy plugin以外のsourceとpost_sourceを実行する
    au VimEnter * call dein#call_hook('source') | call dein#call_hook('post_source')

    " treesitterでサポートされてない色に色を付けるためにこのタイミングで必要(はずせる気がする)
    au FileType * call my#option#set_syntax()
    " au VimEnter * call lightline#highlight()
    " au VimEnter * if &l:ft ==# '' | filetype detect | endif
  augroup END
endif

call s:source('functions.vim')
call s:source('keymaps.vim')
call s:source('commands.vim')
call s:source('autocmds.vim')
call s:source('local.vim')

set secure
