" Complete:
" set completeopt=menu,longest,preview

" let g:neocomplete#disable_auto_complete = 0
" let g:neocomplete#enable_insert_char_pre = 0

let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_camel_case = 1
let g:neocomplete#enable_fuzzy_completion = 0

let g:neocomplete#sources#syntax#min_keyword_length = 3 " Set minimum syntax keyword length.
let g:neocomplete#min_keyword_length = 3            " Set minimum keyword length.
let g:neocomplete#auto_completion_start_length = 1  "補完が自動で開始される文字数
let g:neocomplete#manual_completion_start_length = 0 " Set manual completion length.

let g:neocomplete#enable_auto_close_preview = 1

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


" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

" Enable heavy omni completion.
let g:neocomplete#force_overwrite_completefunc = 1
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns   = {}
endif

let g:neocomplete#sources#omni#input_patterns.c     = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#sources#omni#input_patterns.cpp   = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

" let g:neocomplete#sources#omni#input_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
" let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'


" " clang_complete
let g:clang_complete_auto = 0
let g:clang_auto_select   = 0
let g:clang_use_library	  = 1
let g:clang_user_options  = '-std=c++14 -stdlib=libc++'

if IsMac()
  " let g:clang_library_path = "/Library/Developer/CommandLineTools/usr/lib/libclang.dylib"
  let g:clang_library_path = "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib"
else
  let g:clang_library_path =  '/usr/lib/llvm-3.6/lib'
endif

if empty(getftype(g:clang_library_path))
  let g:clang_use_library = 0
  let g:clang_library_path = ""
endif
