let g:netrw_nogx = 1 " Disable unnecessary keymaps

" #vital
" NeoBundle 'osyo-manga/vital-unlocker' " オプションの値保存

" #textobj
" NeoBundle 'hchbaw/textobj-motionmotion.vim'   " am im 任意の2つの motion の間

" vim-textobj taps "{{{
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
"}}}

if dein#tap('incsearch.vim') && dein#tap('vim-asterisk') && dein#tap('vim-anzu') " {{{
  let g:incsearch#no_inc_hlsearch        = 0    " 他のwindowではハイライトしない
  let g:incsearch#auto_nohlsearch        = 1    " 自動でハイライトを消す
  let g:incsearch#consistent_n_direction = 1    " 1:nで常にforwardに移動
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
