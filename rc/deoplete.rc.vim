"---------------------------------------------------------------------------
" deoplete.nvim

let g:neocomplete#enable_smart_case       = 1
let g:neocomplete#enable_camel_case       = 1
let g:neocomplete#enable_fuzzy_completion = 0
let g:deoplete#auto_complete_start_length = 2 " 2
" let g:deoplete#enable_refresh_always = 1  " 0, Note: screen flick
let g:deoplete#max_list = 200 " (100)
" let g:deoplete#delimiters = ['/'] " ['/']
let g:deoplete#auto_complete_delay = 100 " 50
let g:deoplete#skip_chars = ['(', ')']
let g:deoplete#file#enable_buffer_path = 1

call deoplete#custom#option('refresh_always', v:true)
" call deoplete#custom#option('auto_complete_delay', 0)
call deoplete#custom#option('async_timeout', 100)
" call deoplete#custom#option('num_processes', 0)

let g:deoplete#ignore_sources = {'_': ['tag']}
" スニペット候補が出なくなる
" let g:deoplete#sources = {
      " \ '_': ['omni', 'buffer', 'file', 'member', 'dictionary'],
      " \ 'cpp': ['buffer', 'tag'],
      " \ }

" call deoplete#initialize()
" call deoplete#custom#source('_', 'matchers', ['matcher_head'])
" call deoplete#custom#source('ghc', 'sorters', ['sorter_word'])
" call deoplete#custom#source('buffer', 'mark', '')
" call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
" call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
" call deoplete#custom#source('buffer', 'mark', '*')

call deoplete#custom#source('_', 'converters', [
      \ 'converter_remove_paren',
      \ 'converter_remove_overlap',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_menu',
      \ 'converter_auto_delimiter',
      \ ])

call deoplete#custom#source('neosnippet', 'rank', 9999)

call deoplete#custom#source('clang', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')
call deoplete#custom#source('clang', 'max_pattern_length', -1)

" call deoplete#custom#source('tabnine', 'rank', 200)

call deoplete#custom#source('look', 'min_pattern_length', 4)
call deoplete#custom#source('look', 'rank', 100)

call deoplete#custom#source('emoji', 'filetypes', '')
call deoplete#custom#source('emoji', 'min_pattern_length', 9999)
inoremap <silent><expr><c-x><c-e> deoplete#manual_complete('emoji')

" call deoplete#custom#source('LanguageClient', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')
" call deoplete#custom#source('ruby', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')

call deoplete#custom#source('zsh', 'filetypes', ['zsh', 'sh'])

" " For buffer completion
" let g:deoplete#keyword_patterns = {
"       \ '_' : '[a-zA-Z_-]\k*\(?|\w*',
"       \ 'tex' : '[^\w|\s][a-zA-Z_]\w*',
"       \ }

" call deoplete#custom#source('LanguageClient', 'input_pattern', '\.[a-zA-Z0-9_?!]+|[a-zA-Z]\w*::\w*')
" call deoplete#custom#source('ruby', 'input_pattern', '\.[a-zA-Z0-9_?!]+|[a-zA-Z]\w*::\w*')

let g:LanguageClient_serverCommands = {
  \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
  \ 'ruby': ['solargraph', 'stdio'],
  \ }

" \ 'ruby': ['solargraph', 'socket'],
" \ 'ruby': ['tcp://localhost:7658'],

" \ 'ruby': ['solargraph', 'socket'],
" \ 'ruby': ['language_server-ruby'],
" \ 'ruby': ['orbaclerun', 'file-server'],
" \ 'rust': ['rls'],
" \ 'rust': ['rustup', 'run', 'stable', 'rls'],
" \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
" \ 'javascript': ['javascript-typescript-stdio'],

" cannot call some omni functions
let g:deoplete#omni#input_patterns = {
      \ 'python': '',
      \ }
      " \ 'ruby': ['[^. \t].\w', '[a-zA-Z_]\w*::'],

let g:deoplete#sources#omni#input_patterns = {
      \ }

let g:deoplete#omni#functions = {
      \ 'lua': 'xolox#lua#omnifunc',
      \ }

let g:deoplete#omni_patterns = {
  \ 'terraform':  '[^ *\t"{=$]\w*',
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
