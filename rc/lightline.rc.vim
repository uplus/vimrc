" g:lightline {{{
let g:lightline = {
      \   'active': {
      \     'left': [['mode', 'paste'], ['git', 'filename', 'readonly',],],
      \     'right': [['cursor'], ['filetype', 'fileencoding'], ['syntax_check', 'current_function']]
      \   },
      \   'inactive': {
      \     'left': [['filename']],
      \     'right': [['cursor'], ['filetype']]
      \   },
      \   'tabline': {
      \     'left': [['tabline']],
      \     'right': [['close']]
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
      \     'close': printf('%%999X %s ', has('multi_byte') ? '✗' : 'x'),
      \   },
      \   'component_visible_condition': {
      \     'paste': '&paste', 'spell': '&spell',
      \   },
      \   'component_function': {
      \     'mode': 'LLmode', 'fileencoding': 'LLfileencoding', 'readonly': 'LLreadonly',
      \     'cursor': 'LLcursor',
      \     'filetype': 'LLfiletype',
      \     'filename': 'LLfilename',
      \     'git': 'LLgit',
      \     'current_function': 'LLcurrent_function',
      \   },
      \   'component_function_visible_condition': {},
      \   'component_expand': {
      \     'tabline': 'LLtabs_buffers',
      \     'syntax_check': 'LLsyntax_check',
      \   },
      \   'component_type': {
      \     'tabs': 'tabsel', 'close': 'raw',
      \     'syntax_check': 'error',
      \     'tabline': 'tabsel',
      \   },
      \   'tab_component': {},
      \   'tab_component_function': {
      \     'filename': 'lightline#tab#filename',
      \     'modified': 'lightline#tab#modified',
      \     'readonly': 'lightline#tab#readonly',
      \     'tabnum': 'lightline#tab#tabnum',
      \   },
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
      \
      \   'winwidth': winwidth(0),
      \   'colorscheme': 'Dracula',
      \ }
"}}}

      " \   'colorscheme': 'mellow',

" default(powerline) molokai darcula solarized
" カラースキームで定義されてる数だけ色が使える?
" expandがリストを複数戻していいからtabは'tabs'だけで色変え出来る
" tab
"   タブがあるならデフォルトのonetab()?返してないならbuflist返す
" buftype preview quickfix diff
" gundo
" 'w:N b:N' from vim-ezbar
" コンポーネントから他のコンポーネントをいじる
"   *_visual_condition使えば隠せるかも だめだった セパレータは消えた 事前に定義が必要?
"   無効
"   色

" TODO &modified || !&modifiable, airlineみたいに色を変えたい
" TODO &buflisted == 1 && &buftype ==# '' && &modifiable
" TODO qfstatusline(現状の常時1つめ表示じゃ不便)
" TODO modifiedが見づらい 色的にも

let s:m = { '__Gundo__': 'Gundo', '__Gundo_Preview__': 'Gundo Preview',
          \ '[Command Line]': 'Command Line',
          \ }

let s:p = { 'unite': 'Unite', 'denite': 'Denite', 'vimfiler': 'VimFiler',
          \ 'quickrun': 'Quickrun',
          \ 'dictionary': 'Dictionary',
          \ 'calendar': 'Calendar',
          \ 'agit' : 'Agit', 'agit_diff' : 'Agit', 'agit_stat' : 'Agit',
          \ 'qf': 'QuickFix',
          \ 'github-dashboard': 'GitHub Dashboard',
          \ 'tagbar': 'Tagbar',
          \ }

let s:e = { 'tagbar':     "get(g:lightline, 'fname', expand('%:t'))",
          \ 'vimfiler':   'vimfiler#get_status_string()',
          \ 'unite':      'unite#get_status_string()',
          \ 'dictionary': "exists('b:dictionary.input') ? b:dictionary.input : default",
          \ 'calendar':   "strftime('%Y/%m/%d')",
          \ 'quickrun':   "''",
          \ 'agit': "''", 'agit_diff': "''", 'agit_stat': "''",
          \ '__Gundo__': "''",
          \ '__Gundo_Preview__': "''",
          \ '[Command Line]': "''",
          \ }

let s:ignore_ft = ['tagbar', 'vimfiler', 'unite', 'denite', 'dictionary', 'gundo', 'undotree']
let s:ignore_fn = ['__Gundo_Preview__']

function! s:is_ignore() abort
  return index(s:ignore_ft, &l:ft) != -1 || index(s:ignore_fn, expand('%:t')) != -1
endfunction

" #left

function! LLmode() abort "{{{
  if &filetype ==# 'calendar'
    call lightline#link("nvV\<C-v>"[b:calendar.visual_mode()])
  endif
  return get(s:m, expand('%:t'), get(s:p, &filetype, lightline#mode()))
endfunction "}}}

function! LLfilename() abort "{{{
  " TODO
  let l:f = expand('%:t')
  let l:tmp = get(s:e, &filetype, get(s:e, l:f, ''))
  if l:tmp !=# ''
    return eval(l:tmp)
  endif

  let l:filename = bufname('%')
  if winwidth(0) < 120
    let l:filename = pathshorten(l:filename)
  endif

  return l:filename . (&modified? ' +': '')
endfunction "}}}

function! LLreadonly() abort "{{{
  if s:is_ignore()
    return ''
  endif

  return &buftype !=# '' ? '':
        \ expand('%') ==# '' ? '':
        \ !&modifiable ? '🔐':
        \ !filewritable(expand('%')) ? '☢':
        \ &readonly? '':
        \ ''
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

" #right
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
  " TODO runtime! ftplugin/zsh/cfi.vim
  if !exists('g:loaded_cfi')
    return
  endif
  " TODO neosnippet中でエラーがでる E523 winsaveしてるのが問題?
  return cfi#format('%s', '')
endfunction "}}}

function! LLsyntax_check() abort "{{{
  let l:errs = filter(getqflist(), 'v:val.bufnr == ' . bufnr('%'))
  let l:num = len(l:errs)
  if l:num == 0
    return ''
  endif
  let l:err = l:errs[0]
  return printf("⚠%d %d:%d '%s'", l:num, l:err.lnum, l:err.vcol, substitute(l:err.text, '^\s*\|\s*$', '', '')[:winwidth('')/5])
endfunction "}}}

" #tabline

function! LLtabs_buffers() abort
  let l:tabs = lightline#tabs()
  if empty(l:tabs[0]) && empty(l:tabs[2])
    return lightline#bufferline#buffers()
  else
    return l:tabs
  endif
endfunction

finish


function! lightline_powerful#tabreadonly(n) abort "{{{
  let winnr = tabpagewinnr(a:n)
  return gettabwinvar(a:n, winnr, '&readonly') ? s:ro : ''
endfunction "}}}

function! lightline_powerful#tabfilename(n) abort "{{{
  let bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  let bufname = expand('#' . bufnr . ':t')
  let buffullname = expand('#' . bufnr . ':p')
  let bufnrs = filter(range(1, bufnr('$')), 'v:val != bufnr && len(bufname(v:val)) && bufexists(v:val) && buflisted(v:val)')
  let i = index(map(copy(bufnrs), 'expand("#" . v:val . ":t")'), bufname)
  let ft = gettabwinvar(a:n, tabpagewinnr(a:n), '&ft')
  if strlen(bufname) && i >= 0 && map(bufnrs, 'expand("#" . v:val . ":p")')[i] != buffullname
    let fname = substitute(buffullname, '.*/\([^/]\+/\)', '\1', '')
  else
    let fname = bufname
  endif
  return fname =~# '^\[preview' ? 'Preview' : get(s:m, fname, get(s:p, ft, fname))
endfunction "}}}

let g:lightline = {
      \ 'tab': {
      \   'active': ['tabnum', 'readonly', 'filename', 'modified'],
      \   'inactive': ['tabnum', 'readonly', 'filename', 'modified']
      \ },
      \ 'component_function_visible_condition': {
      \   'filename': 'get(b:,"lightline_filename","") !=# ""',
      \   'mode': '1',
      \ },
      \ 'tab_component_function': {
      \   'filename': 'lightline_powerful#tabfilename',
      \   'readonly': 'lightline_powerful#tabreadonly',
      \ },
      \ }

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
