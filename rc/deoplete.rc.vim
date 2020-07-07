" # keymaps
inoremap <expr><tab> pumvisible()? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible()? "\<c-p>" : "\<s-tab>"
inoremap <silent><expr><c-x><c-e> deoplete#manual_complete('emoji')
" <c-r>はleximaで定義

" inoremap <expr><c-y> <sid>imap_c_y()
function! s:imap_c_y() abort
  return pumvisible() ? deoplete#complete() : "\<c-y>"
" neosnippet#expandable()
endfunction

" imap <expr><tab> pumvisible()? "\<c-n>" : neosnippet#jumpable()? "\<Plug>(neosnippet_jump)" : "\<tab>"
imap <c-l> <Plug>(neosnippet_expand_or_jump)
smap <c-l> <Plug>(neosnippet_expand_or_jump)
xmap <c-l> <Plug>(neosnippet_jump)

" <bs>: close popup and delete backword char.
" inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
" inoremap <expr><C-g> deoplete#mappings#undo_completion()
" inoremap <expr><C-l> deoplete#mappings#refresh()
" inoremap <expr> '  pumvisible() ? deoplete#mappings#close_popup() : "'"
" inoremap <silent><expr> <C-t> deoplete#mappings#manual_complete('file')

call deoplete#custom#option({
      \ 'auto_refresh_delay': 10,
      \ 'smart_case': v:true,
      \ 'skip_multibyte': v:true,
      \ 'auto_preview': v:true,
      \ })
      "\ 'max_list': 200
      "\ 'refresh_always': v:true
      "\ 'auto_complete_delay': 300
      "\ 'min_pattern_length': 2
      "\ 'camel_case': v:true,

call deoplete#custom#option('ignore_sources', {
      \ '_': ['buffer', 'tag'],
      \ 'c': ['tabnine'],
      \ 'help': ['tabnine'],
      \ })

call deoplete#custom#option('keyword_patterns', {
      \ '_': '[a-zA-Z_-]\k*\(?',
      \ 'tex': '[^\w|\s][a-zA-Z_]\w*',
      \ })

call deoplete#custom#source('_', 'max_abbr_width', 0)
call deoplete#custom#source('_', 'converters', [
      \ 'converter_remove_overlap',
      \ 'converter_case',
      \ 'matcher_length',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_info',
      \ 'converter_truncate_menu',
      \ ])

" call deoplete#custom#source('_', 'matchers', ['matcher_head'])
" call deoplete#custom#source('ghc', 'sorters', ['sorter_word'])
" call deoplete#custom#source('buffer', 'mark', '')
" call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
" call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
" call deoplete#custom#source('buffer', 'mark', '*')

" call deoplete#custom#source('tabnine', 'rank', 200)
call deoplete#custom#source('neosnippet', 'rank', 9000)
call deoplete#custom#source('clang', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')
call deoplete#custom#source('clang', 'max_pattern_length', -1)
call deoplete#custom#source('look', 'min_pattern_length', 4)
call deoplete#custom#source('look', 'rank', 100)
call deoplete#custom#source('emoji', 'filetypes', ['markdown', 'text'])
call deoplete#custom#source('emoji', 'min_pattern_length', 9999)
" call deoplete#custom#source('LanguageClient', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')
" call deoplete#custom#source('ruby', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')
call deoplete#custom#source('zsh', 'filetypes', ['zsh', 'sh'])

" call deoplete#custom#source('LanguageClient', 'input_pattern', '\.[a-zA-Z0-9_?!]+|[a-zA-Z]\w*::\w*')
" call deoplete#custom#source('ruby', 'input_pattern', '\.[a-zA-Z0-9_?!]+|[a-zA-Z]\w*::\w*')

let g:LanguageClient_serverCommands = {
  \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
  \ 'ruby': ['solargraph', 'stdio'],
  \ 'javascript': ['javascript-typescript-stdio'],
  \ 'typescript': ['typescript-language-server', '--stdio'],
  \ 'typescriptreact': ['typescript-language-server', '--stdio'],
  \ 'python': ['pyls']
  \ }

  " \ 'ruby': ['tcp://localhost:7658'],
  " \ 'ruby': ['language_server-ruby'],
  " \ 'ruby': ['orbaclerun', 'file-server'],
  " \ 'rust': ['rls'],
  " \ 'rust': ['rustup', 'run', 'stable', 'rls'],
  " \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
  " \ 'javascript': ['javascript-typescript-stdio'],

" call deoplete#custom#source('omni', 'functions', {
"  \ 'lua': 'xolox#lua#omnifunc',
"  \})

call deoplete#custom#option('omni_patterns', {
  \ 'terraform':  '[^ *\t"{=$]\w*',
  \ })

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
