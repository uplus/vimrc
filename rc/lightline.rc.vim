" g:lightline
let g:lightline = {
      \   'active': {
      \     'left': [['mode', 'paste'], ['filename', 'cursor', 'filestate'], ['current_function']],
      \     'right': [[], ['filetype', 'fileencoding'],]
      \   },
      \   'inactive': {
      \     'left': [['mode', 'paste'], ['filename', 'cursor', 'filestate'], ['current_function']],
      \     'right': [[], ['filetype', 'fileencoding']]
      \   },
      \   'tabline': {
      \     'left': [['tabline']],
      \     'right': [[]]
      \   },
      \   'tab': {
      \     'active': ['tabnum', 'filename', 'modified'],
      \     'inactive': ['tabnum', 'filename', 'modified']
      \   },
      \
      \   'component': {
      \     'absolutepath': '%F', 'relativepath': '%f', 'modified': '%M', 'bufnum': '%n',
      \     'paste': '%{&paste?"PASTE":""}',
      \     'charvalue': '%b',
      \     'charvaluehex': '%B',
      \     'spell': '%{&spell? &spelllang:""}',
      \     'percent': '%3p%%', 'percentwin': '%P',
      \   },
      \   'component_visible_condition': {
      \     'paste': '&paste',
      \     'spell': '&spell',
      \   },
      \   'component_function': {
      \     'current_function': 'LLcurrent_function',
      \     'cursor': 'LLcursor',
      \     'fileencoding': 'LLfileencoding',
      \     'filename': 'LLfilename',
      \     'filetype': 'LLfiletype',
      \     'git': 'LLgit',
      \     'mode': 'LLmode',
      \     'filestate': 'LLfilestate',
      \   },
      \   'component_function_visible_condition': {},
      \   'component_expand': {
      \     'tabline': 'LLtabline',
      \   },
      \   'component_type': {
      \     'tabline': 'tabsel',
      \     'tabs': 'tabsel',
      \   },
      \
      \   'tab_component': {},
      \   'tab_component_function': {
      \     'filename': 'lightline#tab#filename',
      \     'modified': 'lightline#tab#modified',
      \     'readonly': 'lightline#tab#readonly',
      \     'tabnum': 'lightline#tab#tabnum',
      \   },
      \
      \   'mode_map': {
      \     'n': 'N', 'i': 'I', 'R': 'R', 'c': 'C', 't': 'T',
      \     'v': 'V', 'V': 'V', "\<C-v>": 'V',
      \     's': 'S', 'S': 'S', "\<C-s>": 'S',
      \   },
      \
      \   'separator': {'left': '', 'right': ''},
      \   'subseparator': {'left': '', 'right': ''},
      \   'tabline_separator': {'left': '', 'right': ''},
      \   'tabline_subseparator': {'left': '', 'right': ''},
      \
      \   'enable': {'statusline': 1, 'tabline': 1},
      \   'winwidth': winwidth(0),
      \   'colorscheme': 'mellow',
      \ }

      "\   'colorscheme': 'rosepine',
      "\   'separator': {'left': '', 'right': ''},
      "\   'subseparator': {'left': '', 'right': ''},
      "\   'tabline_separator': {'left': '', 'right': ''},
      "\   'tabline_subseparator': {'left': '', 'right': ''},

let g:lightline#bufferline#shorten_path = 0

" expandがリストを複数戻していいからtabは'tabs'だけで色変え出来る
" buftype preview quickfix diff
" 'w:N b:N' from vim-ezbar
" コンポーネントから他のコンポーネントをいじる

" TODO &modified || !&modifiable, airlineみたいに色を変えたい
" TODO &buflisted == 1 && &buftype ==# '' && &modifiable
" TODO qfstatusline(現状の常時1つめ表示じゃ不便)
" TODO modifiedが見づらい 色的にも

let s:mode_map_filename = {
  \ '[Command Line]': 'Command Line',
  \ }

let s:mode_map_filetype = {
  \ 'denite': 'Denite',
  \ 'Defx': 'defx',
  \ 'quickrun': 'Quickrun',
  \ 'dictionary': 'Dictionary',
  \ 'qf': 'QuickFix',
  \ 'tagbar': 'Tagbar',
  \ }

let s:e = {
  \ 'tagbar':     "get(g:lightline, 'fname', expand('%:t'))",
  \ 'dictionary': "exists('b:dictionary.input') ? b:dictionary.input : default",
  \ 'quickrun':   "''",
  \ '[Command Line]': "''",
  \ }

let s:ignore_ft = ['tagbar', 'defx', 'denite', 'denite-filter', 'dictionary', 'undotree']
let s:ignore_fn = []

function! s:is_ignore() abort "{{{
  return index(s:ignore_ft, &l:ft) != -1 || index(s:ignore_fn, expand('%:t')) != -1
endfunction "}}}

function! LLmode() abort "{{{
  if s:is_ignore()
    return ''
  endif

  return get(s:mode_map_filename, expand('%:t'), get(s:mode_map_filetype, &filetype, lightline#mode()))
endfunction "}}}

function! LLfilename() abort "{{{
  if s:is_ignore()
    return ''
  endif

  let l:f = expand('%:t')
  let l:tmp = get(s:e, &filetype, get(s:e, l:f, ''))
  if l:tmp !=# ''
    return eval(l:tmp)
  endif

  let l:filename = bufname('%')
  if winwidth(0) < 120
    let l:filename = pathshorten(l:filename)
  endif

  return l:filename
endfunction "}}}

function! LLfilestate() abort "{{{
  if s:is_ignore()
    return ''
  endif

  return LLreadonly() . (&modified ? '+': ' ')
endfunction "}}}

function! LLreadonly() abort "{{{
  if &buftype !=# '' || expand('%') ==# ''
    return ''
  endif

  if !&modifiable
    return '🔒'
  endif

  if !filewritable(expand('%'))
    return '🔑'
  endif

  if &readonly
    return '🔒'
  endif

  return ''
endfunction "}}}

function! LLgit() abort "{{{
  if !exists('g:loaded_gina') || s:is_ignore()
    return  ''
  endif

  let l:status = gina#component#repo#branch()
  if l:status ==# ''
    return ''
  endif

  if exists('g:loaded_signify') && bufname('%') !=# ''
    let [l:added, l:modified, l:removed] = sy#repo#get_stats()
    let l:status .= ' ±' . (l:added + l:modified + l:removed)
  endif

  return ' ' . l:status
endfunction "}}}

function! LLcursor() abort "{{{
  if s:is_ignore()
    return ''
  endif

  return printf('%3d/%d:%-2d', line('.'), line('$'), virtcol('.'))
endfunction "}}}

function! LLfiletype() abort "{{{
  if s:is_ignore()
    return ''
  endif
  return &filetype !=# ''? &filetype : 'NONE'
endfunction "}}}

function! LLfileencoding() abort "{{{
  let l:enc = (&fileencoding !=# '')? &fileencoding : &encoding
  if l:enc ==# 'utf-8' && &fileformat ==# 'unix'
    return ''
  endif
  return printf('%s[%s]', l:enc, &fileformat[0])
endfunction "}}}

function! LLcurrent_function() abort "{{{
  if dein#is_sourced('nvim-treesitter')
    if vimrc#is_include(['yaml', 'json'], &filetype)
      let l:opts = {
        \ 'type_patterns': ['pair$'],
        \ 'transform_fn': luaeval('function(line) return line:gsub(":.*$", "") end')
        \ }
    else
      let l:opts = {}
    endif

    let l:current_context = nvim_treesitter#statusline(l:opts)

    if l:current_context != v:null
      return l:current_context
    endif
  end

  if exists('g:loaded_cfi')
    " TODO neosnippet中でエラーがでる E523 winsaveしてるのが問題?
    return cfi#format('%s', '')
  endif

  return ''
endfunction "}}}

function! LLtabline() abort "{{{
  if tabpagenr('$') == 1
    return lightline#bufferline#buffers()
  else
    return lightline#tabs()
  endif
endfunction "}}}

" 🕱  "U+1F系は表示がずれる
" ☠ ☢ ☺
" ☡ warning
" ♫ ⚠ ⚡☣
" Ꞩ ∄ Ξ 
" » « ▶ ◀
" ␊ ␤
" 🔒 🔑
" '⮁' '⮃' '⮀' '⮂'
" '↩' '⭠' '⭡' '⭤'
" '≫' '•' 'Ξ'
