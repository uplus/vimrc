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
for key in [';', ',', 's', 'gs']
  execute 'noremap' key '<Nop>'
endfor

" Disable unnecessary keymaps
let g:netrw_nogx = 1

" Enable filetype lua
" 72877bb でfiletype.luaがデフォになったから廃止
" let g:did_load_filetypes = 0
" let g:do_filetype_lua = 1

" provider config
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:python3_host_prog = '/usr/bin/python3'

augroup myac
  autocmd!
augroup END

function! s:try_source(filepath) abort
  try
    execute 'source' a:filepath
  catch /^Vim\%((\a\+)\)\=:E484/
    " File not found
  endtry
endfunction

source ~/.vim/options.vim

" load dein
if &g:loadplugins
  source ~/.vim/dein.vim

  if has('vim_starting') && !empty(argv())
    " nvimではsyntax enableなどが必要ない
  endif

  source ~/.vim/highlights.vim

  augroup myac
    " lazy plugin以外のsourceとpost_sourceを実行する
    au VimEnter * call dein#call_hook('source') | call dein#call_hook('post_source')

    " TODO: neovimのデグレ?で呼ばれないっぽいのでワークアラウンド
    source ~/.cache/dein/.cache/init.vim/.dein/after/ftplugin.vim

    " treesitterでサポートされてない色に色を付けるためにこのタイミングで必要(はずせる気がする)
    " au FileType * call my#option#set_syntax()
    " au VimEnter * call lightline#highlight()
    " au VimEnter * if &l:ft ==# '' | filetype detect | endif
  augroup END
endif

source ~/.vim/functions.vim
source ~/.vim/keymaps.vim
source ~/.vim/commands.vim
source ~/.vim/autocmds.vim

call s:try_source(' ~/.vim/local.vim')

set secure
