" Complete
	" menu		候補が2つ以上あるときメニューを表示する
	" longest	候補が共通部分だけを挿入する
	" preview	付加的な情報を表示
set completeopt=menu,longest,preview

hi Pmenu	ctermbg=0
hi Pmenu	ctermbg=242
hi PmenuSel ctermbg=6	ctermfg=40
"hi PmenuSel ctermbg=70 ctermfg=129

" neocomplete
let g:neocomplete#enable_at_startup	= 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|::' 

inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr> <CR> pumvisible() ? "\<C-y><CR>" : "\<CR>"

" clang_complete
let g:clang_complete_auto		= 0
"let g:clang_auto_select			= 0
let g:clang_periodic_quickfix	= 0
let g:clang_complete_copen		= 1
let g:clang_use_library			= 1
let g:clang_library_path  =  '/usr/lib/llvm-3.5/lib'
let g:clang_user_options  =  '-std=c++1z -stdlib=libc++'

