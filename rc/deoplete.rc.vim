" # keymaps

" leximaでcrが上書きされるため先に呼び出して全て実行する
call lexima#set_default_rules()

inoremap <expr><tab> pumvisible()? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible()? "\<c-p>" : "\<s-tab>"
inoremap <silent><expr><c-x><c-e> deoplete#manual_complete(['emoji'])
imap <c-l> <Plug>(neosnippet_expand_or_jump)
smap <c-l> <Plug>(neosnippet_jump)
xmap <c-l> <Plug>(neosnippet_jump)
imap <expr><silent><cr> <sid>imap_cr()
" inoremap <expr><bs> deoplete#mappings#smart_close_popup()."\<C-h>"
" inoremap <expr><c-g> deoplete#mappings#undo_completion()
" inoremap <expr><c-l> deoplete#mappings#refresh()
" inoremap <expr> '  pumvisible() ? deoplete#mappings#close_popup() : "'"
" inoremap <silent><expr> <C-t> deoplete#mappings#manual_complete('file')

function! s:imap_cr() abort
  if pumvisible()
    if neosnippet#expandable()
      return "\<Plug>(neosnippet_expand)"
    else
      return lexima#expand('<CR>', 'i')
    endif
  else
    return lexima#expand('<CR>', 'i')
  endif
endfunction

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

call deoplete#custom#source('_', 'max_abbr_width', 120)

" call deoplete#custom#source('_', 'converters', [
"      \ 'converter_remove_overlap',
"      \ 'converter_case',
"      \ 'matcher_length',
"      \ 'converter_truncate_abbr',
"      \ 'converter_truncate_info',
"      \ 'converter_truncate_menu',
"      \ ])

" call deoplete#custom#source('_', 'matchers', ['matcher_head'])
" call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
" call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
" call deoplete#custom#source('buffer', 'mark', '')
" call deoplete#custom#source('buffer', 'mark', '*')
" call deoplete#custom#source('ghc', 'sorters', ['sorter_word'])

" call deoplete#custom#source('tabnine', 'rank', 200)
call deoplete#custom#source('neosnippet', 'rank', 9000)
call deoplete#custom#source('zsh', 'filetypes', ['zsh', 'sh'])

call deoplete#custom#source('clang', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')
call deoplete#custom#source('clang', 'max_pattern_length', -1)
call deoplete#custom#source('look', 'min_pattern_length', 4)
call deoplete#custom#source('look', 'rank', 100)
call deoplete#custom#source('emoji', 'filetypes', ['markdown', 'text'])
call deoplete#custom#source('emoji', 'min_pattern_length', 9999)
" call deoplete#custom#source('LanguageClient', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')
" call deoplete#custom#source('LanguageClient', 'input_pattern', '\.[a-zA-Z0-9_?!]+|[a-zA-Z]\w*::\w*')
" call deoplete#custom#source('ruby', 'input_pattern', '\.\w*|\.->\w*|\w+::\w*')
" call deoplete#custom#source('ruby', 'input_pattern', '\.[a-zA-Z0-9_?!]+|[a-zA-Z]\w*::\w*')
" call deoplete#custom#source('omni', 'functions', { 'lua': 'xolox#lua#omnifunc' })

call deoplete#custom#option('omni_patterns', {
  \ 'terraform':  '[^\s*\t"{=$]\w*',
  \ })
