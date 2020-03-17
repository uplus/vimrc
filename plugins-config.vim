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

" #vital
" NeoBundle 'osyo-manga/vital-unlocker' " オプションの値保存

" #untie
" NeoBundleLazy 'mattn/unite-remotefile',           { 'depends' : [ 'Shougo/unite.vim' ] }

" #textobj
" NeoBundle 'hchbaw/textobj-motionmotion.vim'   " am im 任意の2つの motion の間

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
