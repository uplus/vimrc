" Dein.vim:

let s:dein_dir = expand('$CACHE/dein') . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif
  execute ' set runtimepath^=' . s:dein_dir
  let g:loaded_neobundle = 1
endif

let s:path = expand('$CACHE/dein')
if dein#load_state(s:path)
  let s:toml_path = '~/.vim/dein.toml'
  let s:toml_lazy_path = '~/.vim/deinlazy.toml'

  call dein#begin(s:path, [expand('<sfile>'), s:toml_path, s:toml_lazy_path])
  call dein#load_toml(s:toml_path, {'lazy': 0})
  call dein#load_toml(s:toml_lazy_path, {'lazy' : 1})
  call dein#end()
  call dein#save_state()

  if has('vim_starting') && dein#check_install()
    call dein#install()
  endif
endif

"###################### plugin config ############################"
let g:netrw_nogx=1             " 不要なkeymapを無効
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
let g:no_cecutil_maps=1        " AnsiEsc の中で変なマッピングをしないようにする
let g:solarized_termcolors=256 " solarizedをCUIで使うため
let python_highlight_all = 1

" vim-operator taps "{{{
if dein#tap('vim-operator-user') "{{{
  nmap <Space>k <Plug>(operator-jump-head-out)a
  nmap <Space>j <Plug>(operator-jump-tail-out)a
  nmap gr <Plug>(operator-replace)
  xmap gr <Plug>(operator-replace)

  nmap se <Plug>(operator-evalruby)
  nmap seL <Plug>(operator-evalruby)<Plug>(textobj-line-a)
  xmap se <Plug>(operator-evalruby)
endif "}}}

if dein#tap('vim-operator-surround') "{{{
  " () {} はab aB で表す 他は記号 でもb Bは使わないかな
  map <silent>sa <Plug>(operator-surround-append)
  map <silent>sd <Plug>(operator-surround-delete)a
  map <silent>sr <Plug>(operator-surround-replace)a

  " if you use vim-textobj-multiblock
  nmap <silent>sdd <Plug>(operator-surround-delete)<Plug>(textobj-multiblock-a)
  nmap <silent>srr <Plug>(operator-surround-replace)<Plug>(textobj-multiblock-a)

  nmap S <Plug>(vim-basic-visual)<Plug>(vim-basic-tail)<Plug>(operator-surround-append)
  nmap saw saaw
  nmap saW saaW
endif "}}}

if dein#tap('vim-clang-format') "{{{
  let g:clang_format#command = 'clang-format'
  if !executable(g:clang_format#command)
    let g:clang_format#command = 'clang-format-3.6'
  endif

  let g:clang_format#code_style = "Google"
  let g:clang_format#style_options = {
        \ 'AllowShortIfStatementsOnASingleLine' : 'true',
        \ 'AllowShortLoopsOnASingleLine'        : 'true',
        \ 'AllowShortFunctionsOnASingleLine'    : 'true',
        \ 'AlwaysBreakTemplateDeclarations'     : 'true',
        \ 'AccessModifierOffset' : -4,
        \ 'ColumnLimit'          : 0,
        \ 'Standard'             : 'C++11',
        \ 'BreakBeforeBraces'    : 'Attach',
        \ }
endif "}}}
"}}}

" vim-textobj taps "{{{
if dein#tap('vim-textobj-user')
  " let g:textobj_enclosedsyntax_no_default_key_mappings = 1
endif

if dein#tap('textobj-lastpaste') "{{{
  let g:textobj_lastpaste_no_default_key_mappings = 1
  omap p <Plug>(textobj-lastpaste-i)
  omap ,v <Plug>(textobj-lastpaste-i)
endif "}}}

if dein#tap('textobj-wiw') "{{{
  " bkad/CamelCaseMotionと組み合わせれば意図した通りに動く
  let g:textobj_wiw_no_default_key_mappings = 1
  omap a,w <Plug>(textobj-wiw-a)
  omap i,w <Plug>(textobj-wiw-i)
  xmap a,w <Plug>(textobj-wiw-a)
  xmap i,w <Plug>(textobj-wiw-i)
endif "}}}

if dein#tap('vim-textobj-line') "{{{
  let g:textobj_line_no_default_key_mappings = 1
  omap aL <Plug>(textobj-line-a)
  omap iL <Plug>(textobj-line-i)

  " whitout last <Space> <CR>...
  nmap yY y<Plug>(textobj-line-i)
  nmap dD d<Plug>(textobj-line-i)
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

if dein#tap('vim-textobj-multiblock') "{{{
  omap ib <Plug>(textobj-multiblock-i)
  xmap ib <Plug>(textobj-multiblock-i)
  omap ab <Plug>(textobj-multiblock-a)
  xmap ab <Plug>(textobj-multiblock-a)

  let g:textobj#multiblock#enable_block_in_cursor = 50
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

" commentout taps "{{{
if dein#tap('caw.vim')
  let g:caw_no_default_keymappings = 1
  let g:caw_dollarpos_sp_left = " "
  let g:caw_dollarpos_startinsert = 1

  " 回数指定は gc2jみたいにやる
  nmap gcc <Plug>(caw:hatpos:toggle)
  nmap gcj <Plug>(caw:hatpos:toggle)j<PLug>(caw:hatpos:toggle)k
  nmap gck <Plug>(caw:hatpos:toggle)k<PLug>(caw:hatpos:toggle)j
  " Aじゃないとobjectのaと被る
  nmap gcA <Plug>(caw:dollarpos:toggle)
  nmap gyy yy<Plug>(caw:hatpos:toggle)

  xmap <Plug>(comment-toggle-yank) ygv<Plug>(caw:i:toggle)
  xmap gy <Plug>(comment-toggle-yank)
  xmap gc <Plug>(caw:hatpos:toggle)

  nmap gc <Plug>(operator-caw-hatpos-toggle)

  if dein#tap('vim-operator-exec_command')
    nmap <silent><expr>gy operator#exec_command#mapexpr_v_keymapping("\<Plug>(comment-toggle-yank)")
  endif
endif
"}}}

if dein#tap('vimshell.vim') "{{{
  nnoremap <space>sh :VimShellTab<CR>
endif "}}}

if dein#tap('vim-smartinput-endwise') "{{{
  let g:smartinput_endwise_avoid_neocon_conflict =  0

  imap <silent><expr><CR> neosnippet#expandable()? "\<Plug>(neosnippet_expand)" :
        \ pumvisible()? "\<C-y>" :
        \ "\<Plug>(smartinput_cr)"
endif "}}}

if dein#tap('neocomplete.vim') && has('lua') "{{{
  let g:loaded_deoplete = 1
  let g:neocomplete#enable_at_startup = 1

  inoremap <expr><S-TAB> pumvisible()? "\<C-p>" : "\<S-TAB>"
  imap <expr><TAB> pumvisible()? "\<C-n>" :
        \ neosnippet#jumpable()? "\<Plug>(neosnippet_jump)" :
        \ "\<TAB>"

  inoremap <Plug>(insert-lasttext) <C-a>
  imap <expr><C-l> neosnippet#jumpable()? "\<Plug>(neosnippet_jump)" : "\<Plug>(insert-lasttext)"
endif "}}}

if dein#tap('orig_rsense') "{{{
  let g:rsenseUseOmniFunc = 1
  let g:rsenseHome = dein#_plugins['orig_rsense'].path
endif "}}}

if dein#tap('neosnippet.vim') "{{{
  let g:neosnippet#enable_snipmate_compatibility = 1
endif "}}}

if dein#tap('unite.vim') "{{{
  " commands "{{{
  command! Prefix   Unite -auto-resize -start-insert -input=^... prefix
  command! Bundle   Unite -auto-resize -start-insert neobundle
  command! Update   Unite -auto-resize -no-quit -buffer-name=neobundle neobundle/update
  command! Vgrep    Unite -auto-resize -no-quit -buffer-name=vimgrep vg
  command! Mes      Unite -auto-resize -buffer-name=message message
  command! Todo     Unite -auto-resize -ignorecase -buffer-name=todo grep:%::(todo|fix|xxx)\:
  command! Outline  Unite -auto-resize -start-insert -resume -input= -buffer-name=outline outline
  command! Headline Unite -auto-resize -start-insert -buffer-name=headline headline
  command! Schemes  Unite -auto-resize -auto-preview colorscheme
  command! Status   Unite -auto-resize -no-empty -no-quit -buffer-name=git/status giti/status
  command! Quickfix Unite -auto-resize -no-empty -no-quit -direction=botright quickfix -buffer-name=quickfix
  command! -nargs=* Maps execute 'Unite -auto-resize -start-insert output:map\ ' . <q-args> . '|map!\ ' . <q-args>
  command! -nargs=+ Out execute 'Unite output:' . escape(<q-args>, ' ')
  "}}}

  " keymap "{{{
  nnoremap <silent>,gs :Status<CR>

  nnoremap <silent><Space>m :<C-U>Unite -auto-resize -no-empty -buffer-name=mark mark<CR>
  nnoremap <silent>;mb :<C-U>Unite -auto-resize -no-empty -buffer-name=bookmark bookmark<CR>
  nnoremap <silent>;ma :<C-U>UniteBookmarkAdd<CR>

  nnoremap <silent>;ub :<C-u>Unite buffer -auto-resize -buffer-name=buffer<CR>
  nnoremap <silent>;ut :<C-u>Unite tab    -auto-resize -select=`tabpagenr()-1` -buffer-name=tab<CR>
  nnoremap <silent>;uj :<C-u>Unite jump   -auto-resize -buffer-name=jump<CR>
  nnoremap <silent>;u <Nop>

  nnoremap <silent>\f :<C-U>Unite -start-insert file<CR>
  nnoremap <silent>\F :<C-U>Unite -start-insert file neomru/file<CR>
  nnoremap <silent><Space>r :<C-U>UniteResume -no-start-insert -force-redraw<CR>

  " search
  nnoremap <silent>s/ :<C-u>Unite -buffer-name=search%`bufnr('%')` -start-insert line:all<CR>
  nnoremap <silent>s? :<C-u>Vgrep<CR>
  nnoremap <silent>s* :<C-u>UniteWithCursorWord -buffer-name=search%`bufnr('%')` line:forward:wrap<CR>
  nnoremap <silent>s# :<C-u>UniteWithCursorWord -buffer-name=search%`bufnr('%')` line:backward:wrap<CR>
  nnoremap <silent>st :Unite -start-insert tag<CR>
  nnoremap <silent>sg :Unite -start-insert grep/git:**:-i<CR>
  nmap <silent>sn :<C-u>UniteResume search%`bufnr('%')` -no-start-insert -force-redraw<CR><Plug>(unite_loop_cursor_down)

  " outline
  nnoremap <silent>sh  :Headline<CR>
  nnoremap <silent>;o  :Outline<CR>
  nnoremap <silent>sot :Todo<CR>
  "}}}

  " unite_config "{{{
  function! s:unite_config()
    nmap <buffer>I 1gg<Plug>(unite_insert_head)
    nmap <buffer>A 1gg<Plug>(unite_append_end)
    nnoremap <buffer>cc ggcc
    inoremap <buffer><C-e> <C-o>$
    inoremap <buffer><C-d> <Del>
    inoremap <buffer><C-b> <Left>
    inoremap <buffer><C-f> <Right>
    nnoremap <silent><buffer>q  :call <SID>unite_smart_close()<CR>

    " TDOO: unite#get_current_unite()を使うべき
    let context = unite#get_context()

    " unite-quickfixの設定色々
    if context.buffer_name == 'quickrun-hook-unite-quickfix' || context.buffer_name == 'quickfix'
      let b:win_entered = 0
      au uAutoCmd WinEnter <buffer> if b:win_entered != 1 | 0 | let b:win_entered = 1 | endif
      au uAutoCmd WinEnter <buffer> if winnr('$') == 1 | quit | endif
      au uAutoCmd BufHidden <buffer> bdelete
      nnoremap <silent><buffer>k :call <SID>unite_move_pos(1)<CR>
      nnoremap <silent><buffer>j :call <SID>unite_move_pos(0)<CR>
    elseif context.buffer_name == 'location_list'
      au uAutoCmd WinEnter <buffer> if winnr('$') == 1 | quit | endif
    elseif context.buffer_name ==# 'buffer'
      nnoremap <silent><buffer><expr><nowait>s unite#do_action('split')
      nnoremap <silent><buffer><expr><nowait>v unite#do_action('vsplit')
      nnoremap <silent><buffer><expr><nowait>t unite#do_action('tabopen')
    elseif context.buffer_name =~# '^search'
      nnoremap <silent><buffer><expr>r unite#do_action('replace')
      nmap <silent><buffer>R *r

      let s:action = { 'is_selectable' : 0 }
      function! s:action.func(candidates)
        let @/ = unite#get_input()
        call feedkeys(a:candidates.action__line . 'gg')
      endfunction
      call unite#custom#action('jump_list', 'search_jump', s:action)
      unlet s:action

      call unite#custom#default_action('source/line/*', 'search_jump')
    endif
  endfunction "}}}

  " smart_close "{{{
  " active-bufferならquit
  " auto_highlightを消す
  function! s:unite_smart_close()
    let context = unite#get_context()

    if ActiveBufferCount() == 0
      quit
    elseif context.auto_highlight == 1
      if context.quit == 0
        call feedkeys("\<Plug>(unite_exit)")
      endif
      call feedkeys("\<Plug>(unite_do_default_action)")
    else
      call feedkeys("\<Plug>(unite_exit)")
    endif
  endfunction "}}}

  " unie_move_pos unite-quickfixで賢く移動する "{{{
  function! s:unite_move_pos(is_up)
    call cursor(0, a:is_up? 1 : col('$'))
    call search('|\d\+\D*\d*|', a:is_up? 'wb' : 'w')
    normal! ^
  endfunction "}}}

  au uAutoCmd FileType unite call s:unite_config()
endif "}}}

if dein#tap('unite-quickfix') "{{{
  command! LocationList call s:OpenLocationList()

  functio! s:OpenLocationList()
    let l:bufnum = winbufnr(unite#get_unite_winnr('location_list'))
    echomsg bufnum
    if bufnum != -1
      echomsg "delete " . l:bufnum
      execute "bwipeout" l:bufnum
    endif

    " -silent つかないと起動時にメッセージが出て止まる
    " -create  意図した通りに動作するがhide-bufferが大量生成される
    "          ないとFileTypeでのマップがうまくいかなかったり、色がつかなかったり
    Unite location_list -buffer-name=location_list -auto-resize -no-quit -no-empty -no-focus -create -direction=below -silent
  endfunction

  " au uAutoCmd VimEnter * au uAutoCmd BufWritePost * LocationList
endif "}}}

if dein#tap('vinarise') "{{{
  let g:vinarise_enable_auto_detect = 0
endif "}}}

if dein#tap('vimfiler.vim') "{{{
  " command! Vf VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit
  command! Vfe VimFiler -split -simple -find -winwidth=26 -no-quit
  command! Vfs VimFilerSplit
  command! Vft VimFilerTab
  command! Vf VimFiler
  command! Vimfiler Vf
  nnoremap <silent><C-W>e :Vfe<CR>
  nnoremap <Space>ff :VimFiler<CR>
  nnoremap <Space>ft :VimFilerTab<CR>
  nnoremap <Space>fs :VimFilerSplit<CR>
  nnoremap <Space>fe :Vfe<CR>
endif "}}}

if dein#tap('vim-easy-align') "{{{
  nmap sl <Plug>(EasyAlign)
  vmap sl <Plug>(EasyAlign)
  nmap <Space>sl <Plug>(LiveEasyAlign)
  vmap <Space>sl <Plug>(LiveEasyAlign)
endif "}}}

if dein#tap('syntastic') "{{{
  let g:syntastic_always_populate_loc_list = 1  " quickfixの表示を更新する
  let g:syntastic_loc_list_height = 10
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq   = 0
  let g:syntastic_enable_signs  = 0
  let g:syntastic_auto_jump     = 0 " default is 0
  let g:syntastic_ignore_files  = ['\m^/usr/include/', expand('~/Documents/memo/')]
  " let g:syntastic_debug = 1

  let g:syntastic_error_symbol   = "✗"
  let g:syntastic_warning_symbol = "⚠"

  let g:syntastic_cpp_compiler         = 'clang++'
  let g:syntastic_cpp_compiler_options = $CPP_COMP_OPT
  let g:syntastic_ruby_mri_args        = "-W1"

  nmap \ts :SyntasticToggleMode<CR>
  nmap gas :call SyntasticLoclistHide()<CR>

  " TODO
  " wrteで開く
  " readで開くのはafter/plugin/の中にある
  " function! dein#tapped.hooks.on_post_source(bundle)
  "   au uAutoCmd BufWritePost * LocationList
  " endfunction

endif "}}}

" TODO: vim-hier.
" if dein#tap('vim-hier') "{{{
"   call s:post_source('call s:post_source_hier()')
"   function! s:post_source_hier()
"     au uAutoCmd BufWritePost * HierUpdate
"   endfunction
" endif "}}}

if dein#tap('committia.vim') "{{{
  let g:committia_open_only_vim_starting = 1
  let g:committia_hooks = {}
  function! g:committia_hooks.edit_open(info)
    " Scroll the diff window from insert mode
    imap <buffer><C-k> <Plug>(committia-scroll-diff-up-half)
    imap <buffer><C-j> <Plug>(committia-scroll-diff-down-half)
  endfunction
endif "}}}

if dein#tap('yankround.vim') "{{{
  nmap p <Plug>(yankround-p)
  xmap p <Plug>(yankround-p)
  nmap P <Plug>(yankround-P)
  nmap gp <Plug>(yankround-gp)
  xmap gp <Plug>(yankround-gp)
  nmap gP <Plug>(yankround-gP)
  nmap <C-n> <Plug>(yankround-next)

  nmap <expr><C-p> <SID>smart_previous()
  function! s:smart_previous()
    if yankround#is_active()
      return "\<Plug>(yankround-prev)"
    else
      return ":\<C-p>"
    endif
  endfunction

  let g:yankround_max_history   = 30
  let g:yankround_dir           = '~/.vim/tmp/yankround_history'
  let g:yankround_use_region_hl = 1
  highlight YankRoundRegion cterm=italic
  au uAutoCmd ColorScheme * highlight YankRoundRegion cterm=italic
endif "}}}

if dein#tap('vim-easymotion') "{{{
  let g:EasyMotion_do_mapping       = 0
  let g:EasyMotion_keys             = 'asdghklqwertuiopzxcvbnmfj'
  let g:EasyMotion_use_upper        = 0
  let g:EasyMotion_leader_key       = ';'
  let g:EasyMotion_enter_jump_first = 1 " Enter jump to first match
  let g:EasyMotion_space_jump_first = 1 " Space jump to first match
  let g:EasyMotion_smartcase        = 1
  let g:EasyMotion_add_search_history = 0

  function! s:easymotion_highlight()
    hi EasyMotionTarget ctermfg=40

    " highlight of first char when 2loop.
    hi EasyMotionTarget2First ctermfg=220

    " highlight of second char when 2loop.
    hi EasyMotionTarget2Second ctermfg=220
  endfunction

  call s:easymotion_highlight()
  au uAutoCmd ColorScheme * call s:easymotion_highlight()

  " <Plug>(easymotion-sn) 複数文字入力で絞り込み
  " <Plug>(easymotion-lineanywhere) current line上のwordの初めと終わりを選択して飛ぶ
  " <Plug>(easymotion-jumptoanywhere) スクリーン上のwordの初めと終わりを選択して飛ぶ

  map ;j <Plug>(easymotion-j)
  map ;k <Plug>(easymotion-k)
  map ;; <Plug>(easymotion-s2)
  map ;f <Plug>(easymotion-sl2)
  map ;t <Plug>(easymotion-repeat)
  map ;w <Plug>(easymotion-w)
  map ;b <Plug>(easymotion-b)
endif "}}}

if dein#tap('vim-airline') "{{{
  " https://github.com/bling/vim-airline/wiki/Screenshots
  let g:airline_powerline_fonts = 1
  let g:airline_theme = 'dark'
  let g:airline_left_sep = ' '
  let g:airline_right_sep = ' '
  let g:airline#extensions#tabline#enabled     = 1
  let g:airline#extensions#tabline#show_tab_nr = 1
  let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
  let g:airline#extensions#tabline#left_sep    = ' '
  let g:airline#extensions#tabline#right_sep   = ' '
  let g:airline#extensions#tabline#fnamemod    = ':t' " name in tabline. second argument of fnamemodify
endif "}}}

if dein#tap('hl_matchit.vim') "{{{
  let g:hl_matchit_enable_on_vim_startup = 1
  let g:hl_matchit_hl_groupname = 'Title'
  let g:hl_matchit_allow_ft     = 'html,vim,zsh,sh' " ruby上手くいかない
  let g:hl_matchit_cursor_wait  = 0.10              " 更新頻度
  let g:hl_matchit_hl_groupname = 'HlMatchit'
  au uAutoCmd ColorScheme * hi HlMatchit cterm=bold,underline
endif "}}}

if dein#tap('alpaca_tags') "{{{
  let g:alpaca_tags#config = {
        \    '_' : '-R --sort=yes',
        \    'ruby': '--languages=+Ruby',
        \ }

  augroup AlpacaTags
    autocmd!
    " au uAutoCmd FileWritePost,BufWritePost *       AlpacaTagsUpdate -style
    " au uAutoCmd FileWritePost,BufWritePost Gemfile AlpacaTagsUpdateBundle
    " au uAutoCmd FileReadPost,BufEnter      *       AlpacaTagsSet
  augroup END
endif "}}}

if dein#tap('vim-anzu') " {{{
  " let g:anzu_enable_CursorHold_AnzuUpdateSearchStatus = 1
  " Treat folding well
  " nnoremap <expr> n anzu#mode#mapexpr('n', '', 'zzzv')
  " nnoremap <expr> N anzu#mode#mapexpr('N', '', 'zzzv')

  " clear status
  " nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
endif " }}}

if dein#tap('vim-asterisk') "{{{
  " let g:asterisk#keeppos = 1
endif "}}}

if dein#tap('incsearch.vim') " {{{
  au uAutoCmd ColorScheme * hi IncSearch term=NONE ctermfg=39 ctermbg=56
  au uAutoCmd ColorScheme * hi Search    term=NONE ctermbg=18 ctermfg=75

  let g:incsearch#no_inc_hlsearch        = 0    " 他のwindowではハイライトしない
  let g:incsearch#auto_nohlsearch        = 1    " 自動でハイライトを消す
  let g:incsearch#consistent_n_direction = 0    " 1:nで常にforwardに移動
  let g:incsearch#magic                  = '\v' " very magic

  map g/ <Plug>(incsearch-stay)
  map / <Plug>(incsearch-forward)
  map ? <Plug>(incsearch-backward)

  map * <Plug>(incsearch-nohl-*)<Plug>(anzu-update-search-status-with-echo)
  map # <Plug>(incsearch-nohl-#)<Plug>(anzu-update-search-status-with-echo)
  map g* <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)<Plug>(anzu-update-search-status-with-echo)
  map g# <Plug>(incsearch-nohl0)<Plug>(asterisk-z#)<Plug>(anzu-update-search-status-with-echo)

  xmap * <Plug>(incsearch-nohl)<Plug>(asterisk-g*)<Plug>(anzu-update-search-status-with-echo)
  xmap # <Plug>(incsearch-nohl)<Plug>(asterisk-g#)<Plug>(anzu-update-search-status-with-echo)
  xmap g* <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)<Plug>(anzu-update-search-status-with-echo)
  xmap g# <Plug>(incsearch-nohl0)<Plug>(asterisk-gz#)<Plug>(anzu-update-search-status-with-echo)

  map  n <Plug>(incsearch-nohl-n)
  map  N <Plug>(incsearch-nohl-N)
  nmap n <Plug>(incsearch-nohl)<Plug>(anzu-n)zzzv
  nmap N <Plug>(incsearch-nohl)<Plug>(anzu-N)zzzv

  " g系は選択範囲を検索 zはstay asteriskはsmartcaseで*検索する
  " nohlとnohl0の違いはたぶんCursorMovedがあるかないか
  " map *   <Plug>(incsearch-nohl)<Plug>(asterisk-*)
  " map #   <Plug>(incsearch-nohl)<Plug>(asterisk-#)
endif "}}}

if dein#tap('clever-f.vim') "{{{
  let g:clever_f_across_no_line    = 0
  let g:clever_f_ignore_case       = 0
  let g:clever_f_smart_case        = 0
  let g:clever_f_fix_key_direction = 0 " 1だとどんな時でもfで後ろにFで前に移動する
  let g:clever_f_show_prompt       = 1
  let g:clever_f_use_migemo        = 0

  let g:clever_f_repeat_last_char_inputs = ["\<CR>", "\<Tab>"]
  " <Plug>(clever-f-repeat-forward)
  " <Plug>(clever-f-repeat-back)
endif "}}}

if dein#tap('vim-jplus') "{{{
  nmap J <Plug>(jplus)
  xmap J <Plug>(jplus)

  " 任意の1文字+両端に空白を挿入して結合を行う
  nmap gJ <Plug>(jplus-getchar-with-space)
  xmap gJ <Plug>(jplus-getchar-with-space)

  " 複数文字を入力したい場合
  nmap <Space>gJ <Plug>(jplus-input)
  vmap <Space>gJ <Plug>(jplus-input)
endif "}}}

if dein#tap('vim-quickhl') "{{{
  let g:quickhl_manual_enable_at_startup = 1
  let g:quickhl_cword_enable_at_startup  = 0
  let g:quickhl_tag_enable_at_startup    = 0
  let g:quickhl_manual_keywords          = [] " Can use List and Dictionary

  nmap gh <Plug>(quickhl-manual-this)
  nmap gl <Plug>(operator-quickhl-manual-this-motion)iL
  nmap gm <Plug>(operator-quickhl-manual-this-motion)
  xmap gh <Plug>(quickhl-manual-this)

  nmap \hm <Plug>(quickhl-manual-reset)
  xmap \hm <Plug>(quickhl-manual-reset)
  nmap \ht <Plug>(quickhl-tag-toggle)
  nmap \hc <Plug>(quickhl-cword-toggle)

  let g:quickhl_manual_hl_priority = 100
  let g:quickhl_manual_colors = [
        \ 'term=reverse ctermfg=232 ctermbg=160 gui=bold guifg=Black guibg=Red',
        \ 'term=reverse ctermfg=232 ctermbg=135 gui=bold guifg=Black guibg=Purple',
        \ 'term=reverse ctermfg=232 ctermbg=63  gui=bold guifg=Black guibg=SlateBlue',
        \ 'term=reverse ctermfg=232 ctermbg=33  gui=bold guifg=Black guibg=Blue',
        \ 'term=reverse ctermfg=232 ctermbg=34  gui=bold guifg=Black guibg=Green',
        \ 'term=reverse ctermfg=232 ctermbg=226 gui=bold guifg=Black guibg=Yellow',
        \ 'term=reverse ctermfg=232 ctermbg=202 gui=bold guifg=Black guibg=Orange',
        \ 'term=reverse ctermfg=0   ctermbg=207',
        \ 'term=reverse ctermfg=0   ctermbg=201',
        \ 'term=reverse ctermfg=0   ctermbg=117',
        \ 'term=reverse ctermfg=0   ctermbg=75',
        \ 'term=reverse ctermfg=0   ctermbg=43',
        \ 'term=reverse ctermfg=0   ctermbg=190',
        \ 'term=reverse ctermfg=0   ctermbg=69',
        \ 'term=reverse ctermfg=0   ctermbg=85',
        \ 'term=reverse ctermfg=0   ctermbg=183',
        \ ]
endif "}}}

if dein#tap('vim-niceblock') "{{{
  xmap I  <Plug>(niceblock-I)
  xmap A  <Plug>(niceblock-A)
endif "}}}

if dein#tap('vim-choosewin') "{{{
  nmap \w <Plug>(choosewin)
  let g:choosewin_overlay_enable          = 1
  let g:choosewin_overlay_clear_multibyte = 1
  let g:choosewin_overlay_font_size       = 'small'
  let g:choosewin_blink_on_land           = 0
  let g:choosewin_statusline_replace      = 0
  let g:choosewin_tabline_replace         = 0
endif "}}}

if dein#tap('jedi-vim') "{{{
  autocmd uAutoCmd FileType python setlocal omnifunc=jedi#completions
  let g:jedi#completions_enabled    = 0
  let g:jedi#auto_vim_configuration = 0
endif "}}}

if dein#tap('open-browser.vim') "{{{
  nmap gss :<c-u>Wsearch<CR>
  nmap gsc <Plug>(openbrowser-smart-search)
  xmap gsc <Plug>(openbrowser-smart-search)

  command Wsearch :call <SID>www_search()
  nnoremap <Plug>(openbrowser-wwwsearch) :<C-u>call <SID>www_search()<CR>
  function! s:www_search()
    let l:search_word = input('Please input search word: ')
    if l:search_word != ''
      execute 'OpenBrowserSearch' escape(l:search_word, '"')
    endif
  endfunction
endif "}}}

if dein#tap('echodoc.vim') "{{{
  let g:echodoc_enable_at_startup = 1
endif "}}}

if dein#tap('rainbowcyclone.vim') "{{{
  let g:rainwbow_cyclone_colors = [
        \ 'term=reverse ctermfg=232 ctermbg=196 gui=bold guifg=Black guibg=Red',
        \ 'term=reverse ctermfg=232 ctermbg=129 gui=bold guifg=Black guibg=Purple',
        \ 'term=reverse ctermfg=232 ctermbg=63  gui=bold guifg=Black guibg=SlateBlue',
        \ 'term=reverse ctermfg=232 ctermbg=27  gui=bold guifg=Black guibg=Blue',
        \ 'term=reverse ctermfg=232 ctermbg=40  gui=bold guifg=Black guibg=Green',
        \ 'term=reverse ctermfg=232 ctermbg=226 gui=bold guifg=Black guibg=Yellow',
        \ 'term=reverse ctermfg=232 ctermbg=202 gui=bold guifg=Black guibg=Orange',
        \ ]

  nmap co/ <Plug>(rc_search_forward)
  nmap co? <Plug>(rc_search_backward)
  nmap co* <Plug>(rc_search_forward_with_cursor)
  nmap co# <Plug>(rc_search_backward_with_cursor)
  nmap con <Plug>(rc_search_forward_with_last_pattern)
  nmap coN <Plug>(rc_search_backward_with_last_pattern)

  " nmap c/ <Plug>(rc_highlight)
  " nmap c* <Plug>(rc_highlight_with_cursor)
  " nmap cn <Plug>(rc_highlight_with_last_pattern)
  " nmap * <Plug>(rc_search_forward_with_cursor_complete)
endif "}}}

if dein#tap('colorizer') "{{{
  let g:colorizer_nomap   = 1
  let g:colorizer_startup = 0
  nmap \hz <Plug>Colorizer
endif "}}}

if dein#tap('indentLine') "{{{
  let g:indentLine_enabled              = 0
  let g:indentLine_faster               = 1
  let g:indentLine_showFirstIndentLevel = 1
  let g:indentLine_color_term           = 208
  nmap <silent>\tl :IndentLinesToggle<CR>
endif "}}}

if dein#tap('vim-hopping') "{{{
  let g:hopping#prompt     = "Input:> "
  nmap \H <Plug>(hopping-start)
  " let g:hopping#keymapping = {
  "   \ "\<C-n>" : "<Over>(hopping-next)",
  "   \ "\<C-p>" : "<Over>(hopping-prev)",
  "   \ "\<C-u>" : "<Over>(scroll-u)",
  "   \ "\<C-d>" : "<Over>(scroll-d)",
  "   \}
endif "}}}

if dein#tap('vim-abolish') "{{{
  nmap sc <plug>Coerce
endif "}}}

if dein#tap('CamelCaseMotion') "{{{
  map <silent> <Space>w <Plug>CamelCaseMotion_w
  map <silent> <Space>b <Plug>CamelCaseMotion_b
  map <silent> <Space>e <Plug>CamelCaseMotion_e
endif "}}}

if dein#tap('vim-gitgutter') "{{{
  let g:gitgutter_enabled         = 1
  let g:gitgutter_signs           = 0
  let g:gitgutter_highlight_lines = 0
  let g:gitgutter_escape_grep     = 1
  let g:gitgutter_map_keys        = 0
  " let g:gitgutter_diff_args = '-w'
  command! Stage GitGutterStageHunk
  command! Revert GitGutterRevertHunk

  nmap [h <Plug>GitGutterPrevHunkzMzvzz
  nmap ]h <Plug>GitGutterNextHunkzMzvzz
  nmap ,gp <Plug>GitGutterPreviewHunk
  nmap ,gadd <Plug>GitGutterStageHunk
  nmap ,grev <Plug>GitGutterRevertHunk
  nmap ,gh :GitGutterLineHighlightsToggle<CR>
  nmap ,gg :GitGutterSignsToggle<CR>

  " if use vim-submode, cannot use mappings to move tab(gt gT).
  au uAutoCmd VimEnter * au! gitgutter TabEnter,BufEnter
endif "}}}

if dein#tap('vim-gista') "{{{
  let g:gista#client#default_username = 'u10e10'
endif "}}}

if dein#tap('vim-fugitive') "{{{
  command! Commit Gcommit -v
  command! Fix Gcommit --amend -v
endif "}}}

if dein#tap('linediff.vim') "{{{
  nnoremap <silent>gsd  :Linediff<CR>
  xnoremap <silent>gsd  :Linediff<CR>

  let g:linediff_buffer_type = 'scratch'
  " let g:linediff_indent = 1 " onにするとqで一発終了できない
  " let g:linediff_first_buffer_command  = 'new'
  " let g:linediff_second_buffer_command = 'vertical new'
endif "}}}

if dein#tap('gundo.vim') "{{{
  let g:gundo_width            = 45
  let g:gundo_preview_height   = 15 " defo 15
  let g:gundo_preview_bottom   = 0
  let g:gundo_right            = 1
  let g:gundo_help             = 1
  let g:gundo_map_move_older   = "j"
  let g:gundo_map_move_newer   = "k"
  let g:gundo_close_on_revert  = 0
  let g:gundo_return_on_revert = 1
  let g:gundo_auto_preview     = 0 " defo 1
  let g:gundo_verbose_graph    = 1
  let g:gundo_playback_delay   = 1
  let g:gundo_mirror_graph     = 1
  let g:gundo_inline_graph     = 0

  nnoremap ,ug :GundoToggle<CR>
endif "}}}

if dein#tap('shaberu.vim') "{{{
  command! -nargs=1 Say ShaberuSay <args>
  let g:shaberu_user_define_say_command = 'jsay "%%TEXT%%"'
  let g:shaberu_is_mute = 0
endif "}}}

if dein#tap('nextfile.vim') "{{{
  let g:nf_map_next         = '[f'
  let g:nf_map_previous     = ']f'
  let g:nf_include_dotfiles = 0
  let g:nf_ignore_dir       = 1
  let g:nf_open_command     = 'edit'
endif "}}}

if dein#tap('vim-qfreplace') "{{{
  au uAutoCmd FileType qf nnoremap <buffer>r :<C-u>Qfreplace<CR>
  au uAutoCmd FileType qfreplace call s:qfreplace_config()

  function! s:qfreplace_config()
    setl nobuflisted
    nnoremap <buffer>q <C-w>q
  endfunction
endif "}}}

if dein#tap('vim-expand-region') "{{{
  xmap v <Plug>(expand_region_expand)
  xmap gm <Plug>(expand_region_shrink)
endif "}}}

if dein#tap('vim-threes') "{{{
  let g:threes#data_directory = expand('~/.vim/tmp')
  " let g:threes#start_with_higher_tile = 1
  command! Threes ThreesStart
endif "}}}

if dein#tap('rainbow') "{{{
  let g:rainbow_ctermfgs = ['blue', 'green', 'yellow', 'magenta', 'red', 'darkmagenta', 'darkblue', 'darkgreen', 'darkcyan']
endif "}}}

if dein#tap('vim-milfeulle') "{{{
  nmap <C-o> <Plug>(milfeulle-prev)
  nmap <C-i> <Plug>(milfeulle-next)
  let g:milfeulle_default_kind = "window"
  let g:milfeulle_default_jumper_name = "win_tab_bufnr_pos_line"
endif "}}}

if dein#tap('vim-over') "{{{
  " let g:over_enable_auto_nohlsearch = 1
  " let g:over_command_line_prompt = "> "
  " let g:over_command_line_key_mappings = {}
  " <Plug>(over-cmdline-scroll-y)     |CTRL-y| 相当
  " <Plug>(over-cmdline-scroll-u)     |CTRL-u| 相当
  " <Plug>(over-cmdline-scroll-f)     |CTRL-f| 相当
  " <Plug>(over-cmdline-scroll-e)     |CTRL-e| 相当
  " <Plug>(over-cmdline-scroll-d)     |CTRL-d| 相当
  " <Plug>(over-cmdline-scroll-b)     |CTRL-b| 相当

  nnoremap ss :OverCommandLine %s/\v<CR>
  nnoremap sw :OverCommandLine %s/\v<C-r><C-w>/<CR>
  nnoremap sW :OverCommandLine %s/\v<C-r><C-a>/<CR>
  xnoremap ss :OverCommandLine s/\v<CR>
  xnoremap sw :OverCommandLine s/\v<C-r><C-w>/<CR>
  xnoremap sW :OverCommandLine s/\v<C-r><C-a>/<CR>
endif "}}}

if dein#tap('vim-smartword') "{{{
  nmap w  <Plug>(smartword-w)
  nmap b  <Plug>(smartword-b)
  nmap e  <Plug>(smartword-e)
  nmap ge  <Plug>(smartword-ge)
  vmap w  <Plug>(smartword-w)
  vmap b  <Plug>(smartword-b)
  vmap e  <Plug>(smartword-e)
  vmap ge  <Plug>(smartword-ge)

  " word moveをCamelCase単位にする
  map <Plug>(smartword-basic-w)  <Plug>CamelCaseMotion_w
  map <Plug>(smartword-basic-b)  <Plug>CamelCaseMotion_b
  map <Plug>(smartword-basic-e)  <Plug>CamelCaseMotion_e
endif "}}}

if dein#tap('sudo.vim') "{{{
  command! Swrite SudoWrite %
  command! Sw SudoWrite %
endif "}}}

if dein#tap('webapi-vim') "{{{
  command! -nargs=* URIencode :call URIencode(<q-args>)
  command! -nargs=* URIdecode :call URIdecode(<q-args>)

  function! URIencode(...) abort
    if a:0 == 0 || '' ==# a:1
      let list = matchlist(getline('.'), '\v^(\s*)(.*)\s*$')[1:2]
      let url = webapi#http#encodeURI(list[1])
      call setline('.', list[0] . url)
    else
      echo webapi#http#encodeURI(a:1)
    endif
  endfunction

  function! URIdecode(...) abort
    if a:0 == 0 || '' ==# a:1
      let list = matchlist(getline('.'), '\v^(\s*)(.*)\s*$')[1:2]
      let url = webapi#http#decodeURI(list[1])
      call setline('.', list[0] . url)
    else
      echo webapi#http#decodeURI(a:1)
    endif
  endfunction
endif "}}}

if dein#tap('ruby_hl_lvar.vim') "{{{
  let g:ruby_hl_lvar_hl_group = 'rubyLocalVariable'
  au uAutoCmd ColorScheme * hi rubyLocalVariable ctermfg=38
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

  au uAutoCmd FileType ref-webdict nnoremap <silent><buffer>q :quit<CR>

  command! -nargs=1 Wiki Ref webdict wiki <args>
  command! -nargs=1 Eng Ref webdict <args>
endif "}}}

if dein#tap('previm') "{{{
  if executable('firefox')
    let g:previm_open_cmd='firefox'
  endif
endif "}}}

if dein#tap('excitetranslate-vim') "{{{
  command! -range Trans :<line1>,<line2>:ExciteTranslate

  autocmd BufNewFile ==Translate==* call s:trans_config()
  function! s:trans_config() abort
    setl nobuflisted
    nnoremap q :bd<CR>
  endfunction
endif "}}}

filetype plugin indent on
syntax on
autocmd uAutoCmd VimEnter * call dein#call_hook('source')
autocmd uAutoCmd VimEnter * call dein#call_hook('post_source')
