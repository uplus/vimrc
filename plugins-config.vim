let g:netrw_nogx = 1 " Disable unnecessary keymaps
" let g:loaded_netrw             = 1
" let g:loaded_netrwPlugin       = 1
" let g:loaded_netrwSettings     = 1
" let g:loaded_netrwFileHandlers = 1
let g:solarized_termcolors = 256 " To use solarized in CLI

" tmp " https://github.com/w0rp/ale/issues/2021
let g:ale_virtualenv_dir_names = []
" let ruby_no_expensive = 1
" let ruby_minlines = 100

" vim-operator taps "{{{
if dein#tap('vim-operator-replace')
  nmap gz <Plug>(operator-replace)
  xmap gz <Plug>(operator-replace)
  for s:c in split("\" ' ` ( { [ <")
    exe 'nmap gz' . s:c '<Plug>(operator-replace)i' . s:c
  endfor
  unlet s:c
endif

if dein#tap('vim-operator-surround') "{{{
  " () {} はab aB で表す 他は記号 でもb Bは使わないかな
  map <silent>sa <Plug>(operator-surround-append)
  map <silent>sd <Plug>(operator-surround-delete)a
  map <silent>sr <Plug>(operator-surround-replace)a

  " if you use vim-textobj-multiblock
  nmap <silent>sdd <Plug>(operator-surround-delete)<Plug>(textobj-multiblock-a)
  nmap <silent>srr <Plug>(operator-surround-replace)<Plug>(textobj-multiblock-a)

  nmap S <Plug>(vim-original-visual)<Plug>(vim-original-tail)<Plug>(operator-surround-append)
  " nmap saw saaw
  " nmap saW saaW
  nmap saL saiL
endif "}}}
"}}}

" vim-textobj taps "{{{
if dein#tap('vim-textobj-user')
  call textobj#user#plugin(
        \ 'blankline', {
        \   'prev': {'select': '', 'select-function': 'vimrc#textobj_blankline_prev'},
        \   'next': {'select': '', 'select-function': 'vimrc#textobj_blankline_next'},
        \ },
        \ )

  omap } <Plug>(textobj-blankline-next)
  omap { <Plug>(textobj-blankline-prev)
endif

if dein#tap('textobj-lastpaste') "{{{
  let g:textobj_lastpaste_no_default_key_mappings = 1
  omap v <Plug>(textobj-lastpaste-i)
endif "}}}

if dein#tap('textobj-wiw') "{{{
  " bkad/CamelCaseMotionと組み合わせれば意図した通りに動く
  let g:textobj_wiw_no_default_key_mappings = 1
  omap a<space>w <Plug>(textobj-wiw-a)
  omap i<space>w <Plug>(textobj-wiw-i)
  xmap a<space>w <Plug>(textobj-wiw-a)
  xmap i<space>w <Plug>(textobj-wiw-i)
endif "}}}

if dein#tap('vim-textobj-line') "{{{
  let g:textobj_line_no_default_key_mappings = 1
  omap aL <Plug>(textobj-line-a)
  omap iL <Plug>(textobj-line-i)

  " whitout last <Space> <CR>...
  nmap yY y<Plug>(textobj-line-i)
  nmap dD d<Plug>(textobj-line-i)
  nmap cC c<Plug>(textobj-line-i)
endif "}}}

if dein#tap('vim-textobj-function') "{{{
  let g:textobj_function_no_default_key_mappings = 1
  omap im <Plug>(textobj-function-i)
  omap am <Plug>(textobj-function-a)
  xmap im <Plug>(textobj-function-i)
  xmap am <Plug>(textobj-function-a)

  " I A でvisual-blockの挿入ができない
  " omap IF <Plug>(textobj-function-I)
  " omap AF <Plug>(textobj-function-A)
  " vmap IF <Plug>(textobj-function-I)
  " vmap AF <Plug>(textobj-function-A)
endif "}}}

if dein#tap('sideways.vim') "{{{
  nmap <space>l <Plug>SidewaysRight
  nmap <space>h <Plug>SidewaysLeft
endif "}}}

if dein#tap('vim-textobj-ruby') "{{{
  let g:textobj_ruby_no_default_key_mappings = 1
  " do-endとかのブロックもある

  " TODO プルリク送る?
  function! s:textobj_function_ruby_select(object_type)
    return textobj#ruby#object_definition_select_{a:object_type}()
  endfunction
  au myac FileType ruby let b:textobj_function_select = function('s:textobj_function_ruby_select')
endif "}}}

if dein#tap('vim-textobj-multiblock') "{{{
  let g:textobj_multiblock_no_default_key_mappings = 1
  omap ib <Plug>(textobj-multiblock-i)
  xmap ib <Plug>(textobj-multiblock-i)
  omap ab <Plug>(textobj-multiblock-a)
  xmap ab <Plug>(textobj-multiblock-a)

  let g:textobj#multiblock#enable_block_in_cursor = 1
  let g:textobj_multiblock_search_limit = 40
  let g:textobj_multiblock_blocks = [
        \   ['"', '"', 1],
        \   ["'", "'", 1],
        \   ['`', '`', 1],
        \   ['(', ')', 1],
        \   ['[', ']', 1],
        \   ['{', '}', 1],
        \   ['<', '>', 1],
        \   ['|', '|', 1],
        \ ]
endif "}}}
"}}}

if dein#tap('caw.vim') " {{{
  let g:caw_no_default_keymappings = 1
  let g:caw_dollarpos_sp_left = ' '
  let g:caw_dollarpos_startinsert = 1

  " for context_filetype and precious. これがあるとHTMLで上手くいかなくなる
  " au myac FileType * let b:caw_oneline_comment = substitute(&commentstring, '\s*%s', '', '')

  " basic mappings, 回数指定は gc2j など
  nmap gcc <Plug>(caw:hatpos:toggle)
  nmap gc <Plug>(operator-caw-hatpos-toggle)
  nmap g<space> gcc
  xmap g<space> gc

  nmap gcj <Plug>(caw:hatpos:toggle)j<PLug>(caw:hatpos:toggle)k
  nmap gck <Plug>(caw:hatpos:toggle)k<PLug>(caw:hatpos:toggle)j
  " append tail comment, Aじゃないとobjectのaと被る
  nmap gcA <Plug>(caw:dollarpos:toggle)

  " yank and comment out
  nmap gyy yy<Plug>(caw:hatpos:toggle)
  xmap <Plug>(comment-toggle-yank) ygv<Plug>(caw:hatpos:toggle)
  xmap gy <Plug>(comment-toggle-yank)
  xmap gc <Plug>(caw:hatpos:toggle)

  " paste and comment out
  nmap gcp p<Plug>(select-pasted)gc

  if dein#tap('vim-operator-exec_command')
    nmap <silent><expr>gy operator#exec_command#mapexpr_v_keymapping("\<Plug>(comment-toggle-yank)")
  endif
endif
"}}}

if dein#tap('neosnippet.vim') "{{{
  let g:neosnippet#enable_snipmate_compatibility = 0
  let g:neosnippet#snippets_directory = '~/.vim/snippets'
  let g:neosnippet#enable_complete_done = 1
  let g:neosnippet#expand_word_boundary = 1
  let g:neosnippet#scope_aliases = {}
  let g:neosnippet#scope_aliases['ruby'] = 'ruby,ruby-rails'
  let g:neosnippet#scope_aliases['arduino'] = 'c'
  " let g:neosnippet#enable_auto_clear_markers = 1 " Don't work for multi lines

  " imap <expr><tab> pumvisible()? "\<c-n>" : neosnippet#jumpable()? "\<Plug>(neosnippet_jump)" : "\<tab>"
  imap <c-l> <Plug>(neosnippet_expand_or_jump)
  smap <c-l> <Plug>(neosnippet_expand_or_jump)
  xmap <c-l> <Plug>(neosnippet_jump)

  if has('conceal')
    " set conceallevel=2 concealcursor=niv
  endif
endif "}}}

if dein#tap('vim-easymotion') "{{{
  let g:EasyMotion_do_mapping       = 0
  let g:EasyMotion_keys             = 'asdghklqwertuiopzxcvbnmfj'
  let g:EasyMotion_use_upper        = 0
  let g:EasyMotion_smartcase        = 1
  let g:EasyMotion_leader_key       = ';'
  let g:EasyMotion_landing_highlight = 0
  let g:EasyMotion_do_shade         = 1
  let g:EasyMotion_enter_jump_first = 1 " Enter jump to first match
  let g:EasyMotion_space_jump_first = 1 " Space jump to first match
  let g:EasyMotion_add_search_history = 0
  let g:EasyMotion_prompt           = '{n}> '
  let g:EasyMotion_cursor_highlight = 0

  au myac ColorScheme,VimEnter * call s:easymotion_highlight()
  function! s:easymotion_highlight() "{{{
    hi EasyMotionTarget        ctermfg=220 guifg=#ffd700
    hi EasyMotionTarget2First  ctermfg=220 guifg=#ffd700
    hi EasyMotionTarget2Second ctermfg=46  guifg=#00ff00
  endfunction "}}}

  " <Plug>(easymotion-lineanywhere) current line上のwordの初めと終わりを選択して飛ぶ
  " <Plug>(easymotion-jumptoanywhere) スクリーン上のwordの初めと終わりを選択して飛ぶ

  map ;h <Plug>(easymotion-linebackward)
  map ;l <Plug>(easymotion-lineforward)
  map ;j <Plug>(easymotion-j)
  map ;k <Plug>(easymotion-k)
  nmap ;L <Plug>(easymotion-overwin-line)

  map ;; <Plug>(easymotion-s2)
  " map ;f <Plug>(easymotion-sl2)
  map ;f <Plug>(easymotion-fln)
  map ;t <Plug>(easymotion-tln)

  map ;w <Plug>(easymotion-w)
  nmap ;w <Plug>(easymotion-w)
  nmap ;W <Plug>(easymotion-overwin-w)
  map ;b <Plug>(easymotion-b)

  " nmap <expr><tab> EasyMotion#is_active()? '<Plug>(easymotion-next)' : '<tab>'
endif "}}}

if dein#tap('incsearch.vim') && dein#tap('vim-asterisk') && dein#tap('vim-anzu') " {{{
  let g:incsearch#no_inc_hlsearch        = 0    " 他のwindowではハイライトしない
  let g:incsearch#auto_nohlsearch        = 1    " 自動でハイライトを消す
  let g:incsearch#consistent_n_direction = 0    " 1:nで常にforwardに移動
  let g:incsearch#magic                  = '\v' " very magic

  " let g:asterisk#keeppos = 1
  " let g:anzu_enable_CursorHold_AnzuUpdateSearchStatus = 1
  " Treat folding well
  " nnoremap <expr> n anzu#mode#mapexpr('n', '', 'zzzv')
  " nnoremap <expr> N anzu#mode#mapexpr('N', '', 'zzzv')
  " clear status
  " nmap <Esc><Esc> <Plug>(anzu-clear-search-status)

  if dein#is_sourced('incsearch-index.vim')
    map / <Plug>(incsearch-index-/)
    map ? <Plug>(incsearch-index-?)
    map z/ <Plug>(incsearch-index-stay)
  else
    map / <Plug>(incsearch-forward)
    map ? <Plug>(incsearch-backward)
    map z/ <Plug>(incsearch-stay)
  endif

  map * <Plug>(incsearch-nohl-*)<Plug>(anzu-update-search-status-with-echo)
  map # <Plug>(incsearch-nohl-#)<Plug>(anzu-update-search-status-with-echo)
  map z* <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)<Plug>(anzu-update-search-status-with-echo)
  map z# <Plug>(incsearch-nohl0)<Plug>(asterisk-z#)<Plug>(anzu-update-search-status-with-echo)

  xmap * <Plug>(incsearch-nohl)<Plug>(asterisk-g*)<Plug>(anzu-update-search-status-with-echo)
  xmap # <Plug>(incsearch-nohl)<Plug>(asterisk-g#)<Plug>(anzu-update-search-status-with-echo)
  xmap z* <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)<Plug>(anzu-update-search-status-with-echo)
  xmap z# <Plug>(incsearch-nohl0)<Plug>(asterisk-gz#)<Plug>(anzu-update-search-status-with-echo)

  map  n <Plug>(incsearch-nohl-n)
  map  N <Plug>(incsearch-nohl-N)
  nmap n <Plug>(incsearch-nohl)<Plug>(anzu-n)zzzv
  nmap N <Plug>(incsearch-nohl)<Plug>(anzu-N)zzzv
endif "}}}

if dein#tap('open-browser.vim') "{{{
  nmap gss :<c-u>Wsearch<CR>
  " nmap gsc <Plug>(openbrowser-open)
  xmap gsc <Plug>(openbrowser-smart-search)
  nmap gsc :call <sid>smart_open()<cr>

  function! s:smart_open() abort
    let l:iskeyword_save = &iskeyword
    setl iskeyword=@,@-@,-,_,:,;,.,#,%,/,48-57

    try
      let l:str = expand('<cword>')
      let l:str = substitute(l:str, '[,.]$', '', '')
      call openbrowser#smart_search(l:str)
    finally
      let &l:iskeyword = l:iskeyword_save
    endtry
  endfunction

  command! -nargs=* Wsearch :call <SID>www_search(<q-args>)
  nnoremap <Plug>(openbrowser-wwwsearch) :<c-u>call <SID>www_search()<CR>
  function! s:www_search(query)
    if a:query !=# ''
      let l:search_word = a:query
    else
      let l:search_word = input('Please input search word: ')
    endif

    if l:search_word !=# ''
      let l:search_word = substitute(l:search_word, "'", "''", 'g')
      call openbrowser#search(l:search_word)
    endif
  endfunction
endif "}}}

if dein#tap('vim-hopping') "{{{
  let g:hopping#prompt     = 'Input:> '
  nmap \H <Plug>(hopping-start)
  " let g:hopping#keymapping = {
  "   \ "\<C-n>" : "<Over>(hopping-next)",
  "   \ "\<C-p>" : "<Over>(hopping-prev)",
  "   \ "\<C-u>" : "<Over>(scroll-u)",
  "   \ "\<C-d>" : "<Over>(scroll-d)",
  "   \}
endif "}}}

if dein#tap('vim-fugitive') "{{{
  command! Commit Gcommit -v
  command! Fix Gcommit --amend -v
endif "}}}

if dein#tap('vim-expand-region') "{{{
  xmap v <Plug>(expand_region_expand)
  xmap gm <Plug>(expand_region_shrink)
endif "}}}

if dein#tap('webapi-vim') "{{{
  command! -nargs=* URIencode :call URIencode(<q-args>)
  command! -nargs=* URIdecode :call URIdecode(<q-args>)

  function! URIencode(...) abort
    if a:0 == 0 || '' ==# a:1
      let l:list = matchlist(getline('.'), '\v^(\s*)(.*)\s*$')[1:2]
      let l:url = webapi#http#encodeURI(l:list[1])
      call setline('.', l:list[0] . l:url)
    else
      echo webapi#http#encodeURI(a:1)
    endif
  endfunction

  function! URIdecode(...) abort
    if a:0 == 0 || '' ==# a:1
      let l:list = matchlist(getline('.'), '\v^(\s*)(.*)\s*$')[1:2]
      let l:url = webapi#http#decodeURI(l:list[1])
      call setline('.', l:list[0] . l:url)
    else
      echo webapi#http#decodeURI(a:1)
    endif
  endfunction
endif "}}}

if dein#tap('ref-dicts-en') "{{{
  let g:ref_source_webdict_sites = {
        \ 'ej': { 'url': 'http://dictionary.infoseek.ne.jp/ejword/%s' },
        \ 'je': { 'url': 'http://dictionary.infoseek.ne.jp/jeword/%s' },
        \ 'wiki': { 'url': 'http://ja.wikipedia.org/wiki/%s' },
        \ }

  let g:ref_source_webdict_sites.default = 'ej'

  " output filter
  function! g:ref_source_webdict_sites.ej.filter(output)
    let l:body = join(split(a:output, "\n")[16:], "\n")
    let l:body = tr(l:body, '《》〈〉【】［］（）', '<><>[][]()')
    let l:body = substitute(l:body, '[★▼●]', '', 'g')
    let l:body = substitute(l:body, '\n出典：\_.*\%$', '', 'g')
    return l:body
  endfunction

  function! g:ref_source_webdict_sites.je.filter(output)
    let l:body = join(split(a:output, "\n")[16:], "\n")
    let l:body = tr(l:body, '《》〈〉【】［］（）', '<><>[][]()')
    let l:body = substitute(l:body, '[★▼●]', '', 'g')
    let l:body = substitute(l:body, '\n出典：\_.*\%$', '', 'g')
    return l:body
  endfunction

  au myac FileType ref-webdict nnoremap <silent><buffer>q :quit<CR>

  command! -nargs=1 Wiki Ref webdict wiki <args>
  command! -nargs=1 Eng Ref webdict <args>
endif "}}}
