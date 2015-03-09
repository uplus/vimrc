" Complete
set completeopt=menu,longest,preview
hi Pmenu	ctermbg=0
hi Pmenu	ctermbg=242
hi PmenuSel ctermbg=6	ctermfg=40
"hi PmenuSel ctermbg=70 ctermfg=129


"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
" let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1		"曖昧ですれば_と大文字ができる"
let g:neocomplete#enable_camel_case = 1

" <TAB>: completion.
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr> <CR> pumvisible() ? "\<C-y><CR>" : "\<CR>"
let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns   = {}
endif
let g:neocomplete#sources#omni#input_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c    = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp  = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

let g:neocomplete#force_overwrite_completefunc  = 1
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns   = {}
endif
let g:neocomplete#force_omni_input_patterns.c      = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp    = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::'
let g:neocomplete#force_omni_input_patterns.perl   = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#force_omni_input_patterns.ruby   = '[^. *\t]\.\w*\|\h\w*::'




" " clang_complete
let g:clang_complete_auto = 0
let g:clang_auto_select  = 0
let g:clang_use_library	 = 1
let g:clang_library_path =  '/usr/lib/llvm-3.5/lib'
let g:clang_user_options =  '-std=c++1z -stdlib=libc++'
" let g:clang_snippets	 = 1
" let g:clang_snippets_engine = 'clang_complete'


