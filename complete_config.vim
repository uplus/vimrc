" Complete
set completeopt=menu,longest,preview

let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_camel_case = 1

let g:neocomplete#mini_keyword_length = 3           "シンタックスをキャッシュするときの最短文字数
let g:neocomplete#auto_completion_start_length = 1  "補完が自動で開始される文字数

" Define dictionary.
" let g:neocomplete#sources#dictionary#dictionaries = {
"     \ 'default':    '',
"     \ 'vimshell':   $HOME.'/.vimshell_hist',
"     \ 'scala':      $HOME.'/.vim/bundle/vim-scala/dict/scala.dict',
"     \ 'c':          $HOME.'/.vim/dict/c.dict',
"     \ 'cpp':        $HOME.'/.vim/dict/cpp.dict',
"     \ 'java':       $HOME.'/.vim/dict/java.dict',
"     \ 'javascript': $HOME.'/.vim/dict/javascript.dict',
"     \ 'lua':        $HOME.'/.vim/dict/lua.dict',
"     \ 'ocaml':      $HOME.'/.vim/dict/ocaml.dict',
"     \ 'perl':       $HOME.'/.vim/dict/perl.dict',
"     \ 'php':        $HOME.'/.vim/dict/php.dict',
"     \ 'scheme':     $HOME.'/.vim/dict/scheme.dict',
"     \ 'vim':        $HOME.'/.vim/dict/vim.dict'
"     \ }

" <TAB>: completion.
inoremap <expr> <TAB> pumvisible()? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" <CR>: close popup and save indent.
inoremap <silent><CR> <C-r>=<SID>cr_comp()<CR>
function! s:cr_comp()
  if pumvisible()
    echo ""
    return "\<C-y>" . "\<CR>"
  else
    echo ""
    return neocomplete#smart_close_popup() . "\<CR>"
  endif
endfunction

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
" if !exists('g:neocomplete#sources#omni#input_patterns')
"   let g:neocomplete#sources#omni#input_patterns   = {}
" endif
" let g:neocomplete#sources#omni#input_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
" let g:neocomplete#sources#omni#input_patterns.c    = '[^.[:digit:] *\t]\%(\.\|->\)'
" let g:neocomplete#sources#omni#input_patterns.cpp  = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
" let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"
" let g:neocomplete#force_overwrite_completefunc  = 1
" if !exists('g:neocomplete#force_omni_input_patterns')
"   let g:neocomplete#force_omni_input_patterns   = {}
" endif
" let g:neocomplete#force_omni_input_patterns.c      = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
" let g:neocomplete#force_omni_input_patterns.cpp    = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::'
" let g:neocomplete#force_omni_input_patterns.perl   = '\h\w*->\h\w*\|\h\w*::'
" let g:neocomplete#force_omni_input_patterns.ruby   = '[^. *\t]\.\w*\|\h\w*::'


" " clang_complete
let g:clang_complete_auto = 0
let g:clang_auto_select  = 0
let g:clang_use_library	 = 1
let g:clang_library_path =  '/usr/lib/llvm-3.5/lib'
let g:clang_user_options =  '-std=c++14 -stdlib=libc++'
" let g:clang_snippets	 = 1
" let g:clang_snippets_engine = 'clang_complete'
