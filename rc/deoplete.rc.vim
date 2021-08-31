call deoplete#custom#option({
  \ 'max_list': 50,
  \ 'min_pattern_length': 1,
  \ 'nofile_complete_filetypes': ['denite-filter', 'zsh'],
  \ 'num_processes': 4,
  \ 'refresh_always': v:false,
  \ 'refresh_backspace': v:false,
  \ 'skip_multibyte': v:true,
  \ 'smart_case': v:true,
  \ })
  "\ 'auto_complete_delay': 300
  "\ 'min_pattern_length': 0

call deoplete#custom#option('ignore_sources', {
  \ '_': ['buffer', 'tag'],
  \ 'c': ['tabnine'],
  \ 'help': ['tabnine'],
  \ 'denite': ['neosnippet']
  \ })

call deoplete#custom#option('keyword_patterns', {
  \ '_': '[a-zA-Z_-]\k*\(?',
  \ 'tex': '[^\w|\s][a-zA-Z_]\w*',
  \ })

call deoplete#custom#source('_', 'max_abbr_width', 120)

call deoplete#custom#source('_', 'converters', [
  \ 'converter_remove_overlap',
  \ ])

" call deoplete#custom#source('_', 'matchers', ['matcher_head'])
" call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
" call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
" call deoplete#custom#source('buffer', 'mark', '')
" call deoplete#custom#source('buffer', 'mark', '*')
" call deoplete#custom#source('ghc', 'sorters', ['sorter_word'])
" call deoplete#custom#source('LanguageClient', 'min_pattern_length', 0)
" call deoplete#custom#source('LanguageClient', 'input_pattern', '\w*(\.|::|->)\w*$')

" call deoplete#custom#source('tabnine', 'rank', 200)
" call deoplete#custom#source('neosnippet', 'rank', 9000)
call deoplete#custom#source('zsh', 'filetypes', ['zsh', 'sh'])

call deoplete#custom#source('clang', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')
" call deoplete#custom#source('clang', 'max_pattern_length', -1)

call deoplete#custom#source('look', 'min_pattern_length', 1)
call deoplete#custom#source('look', 'rank', 100)

call deoplete#custom#source('look', 'filetypes', ['', 'markdown', 'text', 'gitcommit'])
call deoplete#custom#source('nextword', 'filetypes', ['', 'markdown', 'text', 'gitcommit'])
