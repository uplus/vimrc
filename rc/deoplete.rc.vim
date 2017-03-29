"---------------------------------------------------------------------------
" deoplete.nvim

let g:neocomplete#enable_smart_case       = 1
let g:neocomplete#enable_camel_case       = 1
let g:neocomplete#enable_fuzzy_completion = 0
let g:deoplete#auto_complete_start_length = 1 " 2
" let g:deoplete#enable_refresh_always = 1  " 0, Note: screen flick
" let g:deoplete#max_list = 100 " (100)
" let g:deoplete#delimiters = ['/'] " ['/']
" let g:deoplete#auto_complete_delay = 150 " 50
let g:deoplete#skip_chars = ['(', ')']

let g:deoplete#ignore_sources = {'_': ['tag']}
let g:deoplete#sources = get(g:, 'deoplete#sources', {})
let g:deoplete#sources.cpp = ['buffer', 'tag']


" <s-tab>: completion back.
inoremap <expr><s-tab> pumvisible()? "\<c-p>" : "\<s-tab>"
" <bs>: close popup and delete backword char.
" inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
" inoremap <expr><C-g> deoplete#mappings#undo_completion()
" inoremap <expr><C-l> deoplete#mappings#refresh()
" inoremap <expr> '  pumvisible() ? deoplete#mappings#close_popup() : "'"
" inoremap <silent><expr> <C-t> deoplete#mappings#manual_complete('file')
" <cr>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function() abort
"   return deoplete#mappings#close_popup() . "\<CR>"
" endfunction


" call deoplete#custom#set('_', 'matchers', ['matcher_head'])
" call deoplete#custom#set('ghc', 'sorters', ['sorter_word'])
" call deoplete#custom#set('buffer', 'mark', '')
" call deoplete#custom#set('_', 'matchers', ['matcher_full_fuzzy'])
" call deoplete#custom#set('_', 'disabled_syntaxes', ['Comment', 'String'])
" call deoplete#custom#set('buffer', 'mark', '*')

" Use auto delimiter
" call deoplete#custom#set('_', 'converters',
"       \ ['converter_auto_paren',
"       \  'converter_auto_delimiter', 'remove_overlap'])
call deoplete#custom#set('_', 'converters', [
      \ 'converter_remove_paren',
      \ 'converter_remove_overlap',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_menu',
      \ 'converter_auto_delimiter',
      \ ])

" call deoplete#custom#set('buffer', 'min_pattern_length', 9999)


call deoplete#custom#set('clang', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')
call deoplete#custom#set('clang', 'max_pattern_length', -1)

let g:deoplete#keyword_patterns = {
      \ '_' : '[a-zA-Z_]\k*\(?',
      \ 'tex' : '[^\w|\s][a-zA-Z_]\w*',
      \ }

" cannot call some omni functions
let g:deoplete#omni#input_patterns = {
      \ 'python': ''
      \ }

let g:deoplete#sources#omni#input_patterns = {
      \ }

let g:deoplete#omni#functions = {
      \ 'lua': 'xolox#lua#omnifunc',
      \ }


" deoplete-clang
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
let g:deoplete#sources#clang#std = { 'c': 'gnu11', 'cpp': 'c++1z' }
" let g:deoplete#sources#clang#flags = ['-x', 'c++'] " libclang default compile flags


" deoplete-jedi
let g:deoplete#sources#jedi#python_path = '/usr/bin/python3'
