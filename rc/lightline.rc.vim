let g:lightline = {
      \   'active': {
      \     'left': [['mode', 'paste'], ['git', 'filename', 'readonly',],],
      \     'right': [['cursor'], ['filetype', 'fileencoding'], ['syntax_check', 'cfi']]
      \   },
      \   'inactive': {
      \     'left': [['filename']],
      \     'right': [['cursor'], ['filetype']]
      \   },
      \   'tabline': {
      \     'left': [['tabs']],
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
      \     'filetype': '%{&ft !=# ""? &ft : "none"}',
      \     'percent': '%3p%%', 'percentwin': '%P',
      \     'close': '%999X X ',
      \   },
      \   'component_visible_condition': {
      \     'paste': '&paste', 'spell': '&spell',
      \   },
      \   'component_function': {
      \     'mode': 'LLmode', 'fileencoding': 'LLfileencoding', 'readonly': 'LLreadonly',
      \     'cursor': 'LLcursor',
      \     'filename': 'LLfilename',
      \     'git': 'LLgit',
      \     'cfi': 'LLcfi',
      \   },
      \   'component_function_visible_condition': {},
      \   'component_expand': {
      \     'tabs': 'lightline#tabs',
      \     'syntax_check': 'LLsyntax_check',
      \   },
      \   'component_type': {
      \     'tabs': 'tabsel', 'close': 'raw',
      \     'syntax_check': 'error',
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
      \   'colorscheme': 'mellow',
      \ }

" default(powerline) molokai  darcula solarized

" カラースキームで定義されてる数だけ色が使える?
" component_expand使えばピンポイントカラー&隠せる -> lightline#update()

" expandがリストを複数戻していいからtabは'tabs'だけで色変え出来てる?
" 幅があったらディレクトリ
" tab
" bufline
" submode
" buftype preview quickfix diff
" gundo
" コンポーネントから他のコンポーネントをいじる
  " 無効
  " 色
      " \ 'vimfiler' : 'vimfiler#get_status_string()',
      " \ 'unite' : 'unite#get_status_string()',
      " \ 'calendar' : "strftime('%Y/%m/%d')",
      " \ 'github-dashboard': "''",
      " \ '[Command Line]': "''",
      " \   'close': printf('%%999X %s ', has('multi_byte') && s:utf ? "\u2717" : 'x'),

" helpとかでgitが重いかも

au myac VimEnter * call timer_start(100, {-> lightline#update()})

function! LLfilename() abort
  return pathshorten(bufname('%')) . (&modified? ' +': '')
endfunction

function! LLmode() abort
  return  &ft == 'unite' ? 'Unite' :
        \ &ft == 'denite' ? 'Denite':
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'gundo' ? 'Gundo':
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
  " TODO &modified || !&modifiable, airlineみたいに色を変えたい
  if &ft =~# 'help\|undotree\|gundo\|vimfiler\|unite\|denite'
    return ''
  endif

  return &buftype !=# '' ? '':
        \ !&modifiable ? '🔐':
        \ !filewritable(expand('%')) ? '☢':
        \ &readonly? '':
        \ ''
endfunction

function! LLcursor() abort
  return printf('%3d/%d:%-2d', line('.'), line('$'), col('.'))
endfunction

function! LLgit() abort "{{{
  if !exists('g:loaded_fugitive')
    return  ''
  endif
  let status = fugitive#head()
  if status ==# ''
    return ''
  endif

  if exists('g:loaded_gitgutter')
    let tmp = gitgutter#hunk#summary('%')
    let status .= ' ±' . (tmp[0]+tmp[1]+tmp[2])
  endif

  return ' ' . status
endfunction "}}}

function! LLsyntax_check() abort "{{{
  let errs = filter(getqflist(), 'v:val.bufnr == ' . bufnr('%'))
  let num = len(errs)
  if num == 0
    return ''
  endif
  let e = errs[0]
  return printf("⚠%d %d:%d '%s'", num, e.lnum, e.vcol, substitute(e.text, '^\s*\|\s*$', '', '')[:winwidth('')/5])
endfunction "}}}

function! LLcfi() abort
  " runtime! ftplugin/zsh/cfi.vim
  if !exists('g:loaded_cfi')
    return
  endif
  return cfi#format('%s', '')
endfunction

finish


let g:lightline = {
      \ 'active': {
      \   'right': [ [ 'syntastic_error', 'syntastic_warning'], ]
      \ },
      \ 'tabline': {
      \   'left': [ [ 'tabs' ] ],
      \   'right': [ [ 'close' ] ]
      \ },
      \ 'tab': {
      \   'active': [ 'tabnum', 'readonly', 'filename', 'modified' ],
      \   'inactive': [ 'tabnum', 'readonly', 'filename', 'modified' ]
      \ },
      \ 'component': {
      \   'close': printf('%%999X %s ', has('multi_byte') && s:utf ? "\u2717" : 'x'),
      \   'lineinfo': '%3l:%-2c',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'lightline_powerful#gitbranch',
      \   'filename': 'lightline_powerful#filename',
      \   'mode': 'lightline_powerful#mode',
      \ },
      \ 'component_function_visible_condition': {
      \   'filename': 'get(b:,"lightline_filename","")!=#""',
      \   'mode': '1',
      \ },
      \ 'component_expand': {
      \   'syntastic_error': 'lightline_powerful#syntasticerror',
      \   'syntastic_warning': 'lightline_powerful#syntasticwarning',
      \ },
      \ 'component_type': {
      \   'syntastic_error': 'error',
      \   'syntastic_warning': 'warning',
      \ },
      \ 'tab_component_function': {
      \   'filename': 'lightline_powerful#tabfilename',
      \   'readonly': 'lightline_powerful#tabreadonly',
      \ },
      \ }, 'keep')

if s:utf
  call extend(g:lightline, {
      \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
      \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" } })
endif


let s:e = {
      \ 'ControlP' : "get(g:lightline, 'ctrlp_item', expand('%:t'))",
      \ '__Tagbar__' : "get(g:lightline, 'fname', expand('%:t'))",
      \ '__Gundo__' : "''",
      \ '__Gundo_Preview__' : "''",
      \ 'vimfiler' : 'vimfiler#get_status_string()',
      \ 'unite' : 'unite#get_status_string()',
      \ 'vimshell' : "exists('b:vimshell.current_dir') ? substitute(b:vimshell.current_dir,expand('~'),'~','') : default",
      \ 'quickrun' : "''",
      \ 'qf' : "''",
      \ 'vimcalc' : "''",
      \ 'dictionary' : "exists('b:dictionary.input') ? b:dictionary.input : default",
      \ 'calendar' : "strftime('%Y/%m/%d')",
      \ 'thumbnail' : "exists('b:thumbnail.status') ? b:thumbnail.status : 'Thumbnail'",
      \ 'agit' : "''",
      \ 'agit_diff' : "''",
      \ 'agit_stat' : "''",
      \ 'github-dashboard': "''",
      \ '[Command Line]': "''",
      \ }

let s:f = [ 'ControlP', '__Tagbar__', 'vimfiler', 'unite', 'vimshell', 'dictionary', 'thumbnail' ]

function! lightline_powerful#filename() abort
  let f = expand('%:t')
  if has_key(b:, 'lightline_filename') && get(b:, 'lightline_filename_', '') ==# f . &mod . &ma && index(s:f, &ft) < 0 && index(s:f, f) < 0
    return b:lightline_filename
  endif
  let b:lightline_filename_ = f . &mod . &ma
  let default = join(filter([&ro ? s:ro : '', f, &mod ? '+' : &ma ? '' : '-'], 'len(v:val)'), ' ')
  let b:lightline_filename = f =~# '^\[preview' ? 'Preview' : eval(get(s:e, &ft, get(s:e, f, 'default')))
  return b:lightline_filename
endfunction

let s:m = { 'ControlP': 'CtrlP', '__Tagbar__': 'Tagbar', '__Gundo__': 'Gundo', '__Gundo_Preview__': 'Gundo Preview', '[Command Line]': 'Command Line'}
let s:p = { 'unite': 'Unite', 'vimfiler': 'VimFiler', 'vimshell': 'VimShell', 'quickrun': 'Quickrun', 'dictionary': 'Dictionary', 'calendar': 'Calendar', 'thumbnail': 'Thumbnail', 'vimcalc': 'VimCalc', 'agit' : 'Agit', 'agit_diff' : 'Agit', 'agit_stat' : 'Agit', 'qf': 'QuickFix', 'github-dashboard': 'GitHub Dashboard' }
function! lightline_powerful#mode() abort
  if &ft ==# 'calendar'
    call lightline#link("nvV\<C-v>"[b:calendar.visual_mode()])
  elseif &ft ==# 'thumbnail'
    if !empty(b:thumbnail.view.visual_mode)
      call lightline#link(b:thumbnail.view.visual_mode)
    endif
  elseif expand('%:t') ==# 'ControlP'
    call lightline#link('iR'[get(g:lightline, 'ctrlp_regex', 0)])
  endif
  return get(s:m, expand('%:t'), get(s:p, &ft, lightline#mode()))
endfunction

let g:tagbar_status_func = 'lightline_powerful#TagbarStatusFunc'
function! lightline_powerful#TagbarStatusFunc(current, sort, fname, ...) abort
  let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

function! lightline_powerful#tabreadonly(n) abort
  let winnr = tabpagewinnr(a:n)
  return gettabwinvar(a:n, winnr, '&readonly') ? s:ro : ''
endfunction

function! lightline_powerful#tabfilename(n) abort
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
endfunction

function! lightline_powerful#syntasticerror() abort
  if exists('b:syntastic_loclist') && has_key(b:syntastic_loclist, 'errors') && len(b:syntastic_loclist.errors())
    return substitute(substitute(substitute(substitute(b:syntastic_loclist.errors()[0].text, '%', '%%', 'g'), '\[Char\]', 'String', 'g'), '\%(note: \|\(.*unable to load package\|In the second argument of\|Declared at: \| or explicitly provide\).*\|‘\|’\|Perhaps you .*\| (imported from[^)]*)\|(visible) \|It could refer to either.*\|It is a member of the .*\|In the expression:.*\|Probable cause:.*\|GHC\.\w\+\.\|In the [a-z]\+ argument of.*\|integer-gmp:\|Data\.\w\+\.\)', '', 'g'), 'Found\zs:.*\zeWhy not:', '. ', '')
  endif
  return ''
endfunction

function! lightline_powerful#syntasticwarning() abort
  if exists('b:syntastic_loclist') && has_key(b:syntastic_loclist, 'warnings') && has_key(b:syntastic_loclist, 'errors')
        \ && len(b:syntastic_loclist.warnings()) && !len(b:syntastic_loclist.errors())
    return substitute(substitute(substitute(substitute(substitute(b:syntastic_loclist.warnings()[0].text, '%', '%%', 'g'), '\[Char\]', 'String', 'g'), '\.hs:\d\+:\d\+-\d\+\zs.*', '', ''), '\(\(Defaulting the following constraint\|: Patterns not matched\| except perhaps to import instances from \).*\|forall [a-z]\. \|GHC\.\w\+\.\|integer-gmp:\|Data\.\w\+\.\)', '', 'g'), 'Found\zs:.*\zeWhy not:', '. ', '')
  endif
  return ''
endfunction

" 🕱  "U+1F系は表示がずれる
" ☠ ☢ ☺
" ☡ warning
" ♫ ⚠ ⚡☣
" Ꞩ ∄ Ξ 
" » « ▶ ◀
" ␊ ␤
" 🔒 🔑
