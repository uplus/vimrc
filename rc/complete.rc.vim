" Complete:

let g:neocomplete#enable_auto_select     = 0 " noinsertがあると無視
let g:neocomplete#disable_auto_complete  = 0
let g:neocomplete#enable_insert_char_pre = 0

let g:neocomplete#enable_auto_close_preview = 1 " preview windowを補完完了後に自動で閉じる
let g:neocomplete#enable_auto_delimiter     = 1
let g:neocomplete#disable_auto_select_buffer_name_pattern = '\[Command Line\]'

let g:neocomplete#enable_smart_case       = 1
let g:neocomplete#enable_camel_case       = 1
let g:neocomplete#enable_fuzzy_completion = 0

let g:neocomplete#sources#syntax#min_keyword_length = 3 " Set minimum syntax keyword length.
let g:neocomplete#min_keyword_length                = 3 " Set minimum keyword length.
let g:neocomplete#auto_completion_start_length      = 1 " 補完が自動で開始される文字数
let g:neocomplete#manual_completion_start_length    = 0 " Set manual completion length.

call neocomplete#custom#source('look', 'min_pattern_length', 3)

" Enable omni completion.
autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags

let g:neocomplete#sources#omni#input_patterns = get(g:, 'g:neocomplete#sources#omni#input_patterns', {})
let g:neocomplete#sources#omni#functions      = get(g:, 'g:neocomplete#sources#omni#functions', {})
let g:neocomplete#force_omni_input_patterns   = get(g:, 'g:neocomplete#force_omni_input_patterns', {})

let g:neocomplete#sources#omni#functions.go = 'gocomplete#Complete'

let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

" Enable heavy omni completion.
let g:neocomplete#force_overwrite_completefunc = 1

let g:neocomplete#sources#omni#input_patterns.c     = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#sources#omni#input_patterns.cpp   = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#sources#omni#input_patterns.python = '[^. *\t]\.\w*\|\h\w*'

" let g:neocomplete#sources#omni#input_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
" let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
