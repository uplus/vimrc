
" readonly modifiable
" カラースキームで定義されてる数だけ色が使える?
" component_expand使えばピンポイントカラー&隠せる

let g:lightline = {
      \   'active': {
      \     'left': [['mode', 'paste'], ['readonly', 'filename', 'modified']],
      \     'right': [['cursor'], ['filetype'], ['fileencoding']]
      \   },
      \   'inactive': {
      \     'left': [['filename']],
      \     'right': [['cursor']]
      \   },
      \   'tabline': {
      \     'left': [['tabs']],
      \     'right': [['close']]
      \   },
      \   'tab': {
      \     'active': ['tabnum', 'filename', 'modified'],
      \     'inactive': ['tabnum', 'filename', 'modified']
      \   },
      \   'component': {
      \     'absolutepath': '%F', 'relativepath': '%f', 'filename': '%t', 'modified': '%M', 'bufnum': '%n',
      \     'paste': '%{&paste?"PASTE":""}',
      \     'charvalue': '%b',
      \     'charvaluehex': '%B',
      \     'spell': '%{&spell? &spelllang:""}',
      \     'filetype': '%{&ft !=# ""? &ft : "none"}',
      \     'percent': '%3p%%', 'percentwin': '%P',
      \     'close': '%999X X ',
      \   },
      \   'component_visible_condition': {
      \     'modified': '&modified || !&modifiable',
      \     'paste': '&paste', 'spell': '&spell',
      \   },
      \   'component_function': {
      \     'mode': 'LLmode', 'fileencoding': 'LLfileencoding', 'readonly': 'LLreadonly',
      \     'cursor': 'LLcursor',
      \   },
      \   'component_function_visible_condition': {},
      \   'component_expand': {
      \     'tabs': 'lightline#tabs',
      \   },
      \   'component_type': {
      \     'tabs': 'tabsel', 'close': 'raw',
      \   },
      \   'tab_component': {},
      \   'tab_component_function': {
      \     'filename': 'lightline#tab#filename', 'modified': 'lightline#tab#modified',
      \     'readonly': 'lightline#tab#readonly', 'tabnum': 'lightline#tab#tabnum',
      \   },
      \   'colorscheme': 'default',
      \   'mode_map': {
      \     'n': 'N', 'i': 'I', 'R': 'R', 'c': 'C', 't': 'T',
      \     'v': 'V', 'V': 'V', "\<C-v>": 'V',
      \     's': 'S', 'S': 'S', "\<C-s>": 'S',
      \   },
      \   'separator': {'left': '', 'right': ''},
      \   'subseparator': {'left': '', 'right': ''},
      \   'tabline_separator': {'left': '', 'right': ''},
      \   'tabline_subseparator': {'left': '', 'right': ''},
      \   'enable': {'statusline': 1, 'tabline': 1},
      \   '_mode_': {
      \     'n': 'normal', 'i': 'insert', 'R': 'replace', 'v': 'visual', 'V': 'visual', "\<C-v>": 'visual',
      \     'c': 'command', 's': 'select', 'S': 'select', "\<C-s>": 'select', 't': 'terminal',
      \   },
      \   'mode_fallback': {'replace': 'insert', 'terminal': 'insert', 'select': 'visual'},
      \   'palette': {},
      \   'winwidth': winwidth(0),
      \ }

" TODO vim-cloverの状態を表示したい
" per line/maxline col
" 幅があったらディレクトリ
" branch
" bufline
" コンポーネントから他のコンポーネントをいじる
  " 無効
  " 色

" TODO gundo
function! LLmode() abort
  return  &ft == 'unite' ? 'Unite' :
        \ &ft == 'denite' ? 'Denite':
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ lightline#mode()
endfunction

function! LLfileencoding() abort
  let enc = (&fenc !=# "")? &fenc : &enc
  if enc ==# 'utf-8' && &ff ==# 'unix'
    return ''
  endif
  return printf('%s[%s]', enc, &ff[0])
endfunction

function! LLreadonly() abort
  return &readonly? '': ''
endfunction

function! LLcursor() abort
  return printf('%3d/%d %2d', line('.'), line('$'), col('.'))
endfunction

" unicode symbols
let g:airline_symbols = {}
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
