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
let g:deoplete#file#enable_buffer_path = 1

let g:deoplete#ignore_sources = {'_': ['tag']}
" スニペット候補が出なくなる
" let g:deoplete#sources = {
      " \ '_': ['omni', 'buffer', 'file', 'member', 'dictionary'],
      " \ 'cpp': ['buffer', 'tag'],
      " \ }

" call deoplete#initialize()
" call deoplete#custom#set('_', 'matchers', ['matcher_head'])
" call deoplete#custom#set('ghc', 'sorters', ['sorter_word'])
" call deoplete#custom#set('buffer', 'mark', '')
" call deoplete#custom#set('_', 'matchers', ['matcher_full_fuzzy'])
" call deoplete#custom#set('_', 'disabled_syntaxes', ['Comment', 'String'])
" call deoplete#custom#set('buffer', 'mark', '*')

call deoplete#custom#set('_', 'converters', [
      \ 'converter_remove_paren',
      \ 'converter_remove_overlap',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_menu',
      \ 'converter_auto_delimiter',
      \ ])

call deoplete#custom#set('neosnippet', 'rank', 9999)
call deoplete#custom#set('clang', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')
call deoplete#custom#set('clang', 'max_pattern_length', -1)

" " For buffer completion
" let g:deoplete#keyword_patterns = {
"       \ '_' : '[a-zA-Z_-]\k*\(?|\w*',
"       \ 'tex' : '[^\w|\s][a-zA-Z_]\w*',
"       \ }

" cannot call some omni functions
let g:deoplete#omni#input_patterns = {
      \ 'python': ''
      \ }

let g:deoplete#sources#omni#input_patterns = {
      \ }

let g:deoplete#omni#functions = {
      \ 'lua': 'xolox#lua#omnifunc',
      \ }

" # keymaps
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



" # config of sources

" deoplete-clang
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
let g:deoplete#sources#clang#std = { 'c': 'gnu11', 'cpp': 'c++1z' }
" let g:deoplete#sources#clang#flags = ['-x', 'c++'] " libclang default compile flags


" deoplete-jedi
let g:deoplete#sources#jedi#python_path = '/usr/bin/python3'

" deoplete-rust
" let g:deoplete#sources#rust#racer_binary = $HOME . '/.cargo/bin/racer'
" let g:deoplete#sources#rust#rust_source_path = ''
" let g:deoplete#sources#rust#show_duplicates = 0
" let g:deoplete#sources#rust#disable_keymap=1
" let g:deoplete#sources#rust#documentation_max_height=20

" deoplete-racer for rust
" let g:racer_experimental_completer = 1

" deople-ternjs for javascript
" https://github.com/carlitux/deoplete-ternjs
let g:deoplete#sources#ternjs#timeout = 1
let g:deoplete#sources#ternjs#filetypes = [
  \ 'jsx',
  \ 'javascript.jsx',
  \ 'vue',
  \ ]
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#depths = 1
let g:deoplete#sources#ternjs#types = 1
