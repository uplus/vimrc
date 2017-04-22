" Dein.vim:

let s:dein_dir = expand('$CACHE/dein') . '/repos/github.com/Shougo/dein.vim'

let g:dein#install_progress_type = 'title'
let g:dein#enable_notification = 1

" setup dein "{{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_dir)
    call system('!git clone https://github.com/Shougo/dein.vim ' . s:dein_dir)
  endif
  execute ' set runtimepath^=' . s:dein_dir
  let g:loaded_neobundle = 1
endif "}}}

let s:path = expand('$CACHE/dein')
if dein#load_state(s:path)
  call dein#begin(s:path, expand('<sfile>'))
  call dein#load_toml('~/.vim/plugins.toml', {'lazy' : 0})
  call dein#load_toml('~/.vim/pluginslazy.toml', {'lazy' : 1})
  if filereadable(expand('~/.vim/trial.toml'))
    call dein#load_toml('~/.vim/trial.toml', {'lazy' : 0, 'merged': 0})
  endif
  call dein#load_toml('~/.vim/ftplugin.toml', {'lazy' : 0}) " after/ftplugin/ 扱い 要recache

  if dein#tap('deoplete.nvim') && has('nvim')
    call dein#disable('neocomplete.vim')
  endif

  call dein#end()
  call dein#save_state()
endif

au myac VimEnter * call dein#call_hook('source')
au myac VimEnter * call dein#call_hook('post_source')


"###################### plugin config ############################"
let g:netrw_nogx=1             " 不要なkeymapを無効
" let g:loaded_netrw             = 1
" let g:loaded_netrwPlugin       = 1
" let g:loaded_netrwSettings     = 1
" let g:loaded_netrwFileHandlers = 1
let g:solarized_termcolors=256 " solarizedをCUIで使うため

" vim-operator taps "{{{
if dein#tap('vim-operator-user') "{{{
  nmap <Space>k <Plug>(operator-jump-head-out)a
  nmap <Space>j <Plug>(operator-jump-tail-out)a

  nmap se <Plug>(operator-evalruby)
  nmap seL <Plug>(operator-evalruby)<Plug>(textobj-line-a)
  xmap se <Plug>(operator-evalruby)

  call operator#user#define('space-fold', 'vimrc#operator_space_fold')
  call operator#user#define('blank2void', 'vimrc#operator_blank2void')

  " 行末にスペースを一つ追加する
  nmap zf <Plug>(operator-space-fold)
  xmap zf <Plug>(operator-space-fold)

  nmap d <Plug>(operator-blank2void)
  xmap d <Plug>(operator-blank2void)
  nmap <silent>dd :exec "normal \<Plug>(vim-original-visualline)d"<cr>
  " TODO cバージョン作るのむずい 削除した場所をピンポイントで編集させるの難しい
endif "}}}

if dein#tap('vim-operator-replace')
  nmap gz <Plug>(operator-replace)
  xmap gz <Plug>(operator-replace)
  for c in split("\" ' ` ( { [ <")
    exe 'nmap gz' . c "<Plug>(operator-replace)i" . c
  endfor
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
  let g:caw_dollarpos_sp_left = " "
  let g:caw_dollarpos_startinsert = 1

  " for context_filetype and precious
  au myac FileType * let b:caw_oneline_comment = substitute(&commentstring, '\s*%s', '', '')

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

  nmap g<space> gcc
  xmap g<space> gc

  if dein#tap('vim-operator-exec_command')
    nmap <silent><expr>gy operator#exec_command#mapexpr_v_keymapping("\<Plug>(comment-toggle-yank)")
  endif
endif
"}}}

if dein#tap('vimshell.vim') "{{{
  nnoremap <space>sh :VimShellTab<CR>
  " Initialize execute file list.
  let g:vimshell_execute_file_list = {}

  if !exists('g:vimshell_interactive_interpreter_commands')
      let g:vimshell_interactive_interpreter_commands = {}
  endif
  let g:vimshell_interactive_interpreter_commands.python = 'ipython'
  let g:vimshell_interactive_interpreter_commands.ruby   = 'pry'
endif "}}}

if dein#tap('neocomplete.vim') "{{{
  let g:loaded_deoplete = 1
  let g:neocomplete#enable_at_startup = 1
  let g:neopairs#enable = 1

  inoremap <expr><s-tab> pumvisible()? "\<c-p>" : "\<s-tab>"
  " inoremap <expr><space> pumvisible()? "\<c-y>" : "\<space>"
  " inoremap <expr><c-h> neocomplete#smart_close_popup() . "\<c-h>"
  " inoremap <expr><bs> neocomplete#smart_close_popup() . "\<c-h>"
endif "}}}

if dein#tap('neosnippet.vim') "{{{
  let g:neosnippet#enable_snipmate_compatibility = 0
  let g:neosnippet#snippets_directory = '~/.vim/snippets'
  let g:neosnippet#enable_complete_done = 1
  let g:neosnippet#expand_word_boundary = 1
  let g:neosnippet#scope_aliases = {}
  let g:neosnippet#scope_aliases['ruby'] = 'ruby,ruby-rails'
  au myac InsertLeave * NeoSnippetClearMarkers
  " let g:neosnippet#enable_auto_clear_markers = 1 " Don't work for multi lines

  " imap <expr><tab> pumvisible()? "\<c-n>" : neosnippet#jumpable()? "\<Plug>(neosnippet_jump)" : "\<tab>"
  imap <c-l> <Plug>(neosnippet_expand_or_jump)
  smap <c-l> <Plug>(neosnippet_expand_or_jump)
  xmap <c-l> <Plug>(neosnippet_jump)

  if has('conceal')
    " set conceallevel=2 concealcursor=niv
  endif
endif "}}}

if dein#tap('unite.vim') "{{{
  " commands
  command! Prefix   Unite -auto-resize -start-insert -input=^... prefix
  command! Vgrep    Unite -auto-resize -no-quit -buffer-name=vimgrep vg
  command! Mes      Unite -auto-resize -buffer-name=message message
  command! Todo     Unite -auto-resize -ignorecase -buffer-name=todo grep:%::(todo|fix|xxx)\:
  command! Schemes  Unite -auto-resize -auto-preview colorscheme
  command! Status   Unite -auto-resize -no-empty -no-quit -buffer-name=git/status giti/status
  command! Quickfix Unite -auto-resize -no-empty -no-quit -direction=botright quickfix -buffer-name=quickfix
  command! -nargs=* Maps execute 'Unite -auto-resize -start-insert output:map\ ' . <q-args> . '|map!\ ' . <q-args>
  command! -nargs=+ Out execute 'Unite output:' . escape(<q-args>, ' ')


  " #keymap
  nnoremap <space>u :Unite<space>
  nnoremap <silent>;gs :Status<CR>
  nnoremap <silent>;q :Quickfix<CR>

  nnoremap <silent><Space>m :<C-U>Unite -auto-resize -no-empty -buffer-name=mark mark<CR>
  nnoremap <silent>;mb :<C-U>Unite -auto-resize -no-empty -buffer-name=bookmark bookmark<CR>
  nnoremap <silent>;ma :<C-U>UniteBookmarkAdd<CR>

  nnoremap <silent>;ut :<C-u>Unite tab    -auto-resize -select=`tabpagenr()-1` -buffer-name=tab<CR>
  nnoremap <silent>;uj :<C-u>Unite jump   -auto-resize -buffer-name=jump<CR>
  nnoremap <silent>;u <Nop>

  nnoremap <silent>\b :<C-u>Unite -start-insert -auto-resize -buffer-name=buffer buffer<CR>
  nnoremap <silent>\f :<C-U>Unite -start-insert file<CR>
  nnoremap <silent>\F :<C-U>Unite -start-insert file neomru/file<CR>
  nnoremap <silent><Space>r :<C-U>UniteResume -no-start-insert -force-redraw<CR>

  " search
  nnoremap <silent>s/ :<C-u>Unite -buffer-name=search%`bufnr('%')` -start-insert -auto-resize line:all<CR>
  nnoremap <silent>s? :<C-u>Vgrep<CR>
  nnoremap <silent>s* :<C-u>UniteWithCursorWord -buffer-name=search%`bufnr('%')` line:forward:wrap<CR>
  nnoremap <silent>s# :<C-u>UniteWithCursorWord -buffer-name=search%`bufnr('%')` line:backward:wrap<CR>
  nnoremap <silent>st :Unite -start-insert tag<CR>
  nnoremap <silent>sg :Unite grep/git:**:-i<CR>
  nmap     <silent>sn :<C-u>UniteResume search%`bufnr('%')` -no-start-insert -force-redraw<CR><Plug>(unite_loop_cursor_down)
  nnoremap <silent>sh :Unite -auto-resize -start-insert -buffer-name=headline headline<CR>
  nnoremap <silent>so :Unite -auto-resize -start-insert -resume -input= -buffer-name=outline outline<CR>
  nnoremap <silent>sT :Todo<CR>
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

  " au myac VimEnter * au myac BufWritePost * LocationList
endif "}}}

if dein#tap('syntastic') "{{{
  let g:syntastic_always_populate_loc_list = 1  " quickfixの表示を更新する
  let g:syntastic_loc_list_height = 10
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq   = 0
  let g:syntastic_enable_signs  = 0
  let g:syntastic_auto_jump     = 0 " default is 0
  let g:syntastic_ignore_files  = ['\m^/usr/include/', expand('~/Documents/note/')]
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
  "   au myac BufWritePost * LocationList
  " endfunction

endif "}}}

if dein#tap('vim-watchdogs') "{{{
  let g:watchdogs_check_BufWritePost_enable = 1
  " let g:watchdogs_check_BufWritePost_enables = { 'vim' : 0, }
  let g:watchdogs_check_CursorHold_enable = 0
  let g:watchdogs_check_BufWritePost_enable_on_wq = 0

  command! ShowWatchDogsDefault CaptureWin PP g:watchdogs#default_config
endif "}}}

if dein#tap('committia.vim') "{{{
  let g:committia_open_only_vim_starting = 1
  let g:committia_hooks = {}
  function! g:committia_hooks.edit_open(info)
    " Scroll the diff window from insert mode
    imap <buffer><m-k> <Plug>(committia-scroll-diff-up-half)
    imap <buffer><m-j> <Plug>(committia-scroll-diff-down-half)
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
  au myac ColorScheme * highlight YankRoundRegion cterm=italic
endif "}}}

if dein#tap('vim-easymotion') "{{{
  let g:EasyMotion_do_mapping       = 0
  let g:EasyMotion_keys             = 'asdghklqwertuiopzxcvbnmfj'
  let g:EasyMotion_use_upper        = 0
  let g:EasyMotion_smartcase        = 1
  let g:EasyMotion_leader_key       = ';'
  let g:EasyMotion_skipfoldedline   = 1
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
  nmap ;w <Plug>(easymotion-overwin-w)
  map ;b <Plug>(easymotion-b)

  " nmap <expr><tab> EasyMotion#is_active()? '<Plug>(easymotion-next)' : '<tab>'
endif "}}}

if dein#tap('vim-airline') "{{{
  " https://github.com/bling/vim-airline/wiki/Screenshots
  let g:airline_theme = 'kalisi'
  " 分割した時のファイル名とか見やすい
  " serene simple xtermlight kalisi badwolf light

  let g:airline_powerline_fonts = 1
  " let g:airline_left_sep = ' '
  " let g:airline_right_sep = ' '
  let g:airline#extensions#tabline#enabled     = 1
  let g:airline#extensions#tabline#show_tab_nr = 1
  let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
  " let g:airline#extensions#tabline#left_sep      = ' '
  " let g:airline#extensions#tabline#left_alt_sep  = ' '
  " let g:airline#extensions#tabline#right_sep     = ' '
  " let g:airline#extensions#tabline#right_alt_sep = ' '
  let g:airline#extensions#tabline#fnamemod    = ':t' " name in tabline. second argument of fnamemodify
endif "}}}

if dein#tap('hl_matchit.vim') "{{{
  let g:hl_matchit_enable_on_vim_startup = 1
  let g:hl_matchit_hl_groupname = 'Title'
  let g:hl_matchit_allow_ft     = 'html,vim,zsh,sh' " ruby上手くいかない
  let g:hl_matchit_cursor_wait  = 0.10              " 更新頻度
  let g:hl_matchit_hl_groupname = 'HlMatchit'
  au myac ColorScheme * hi HlMatchit cterm=bold,underline
endif "}}}

if dein#tap('alpaca_tags') "{{{
  let g:alpaca_tags#config = {
        \    '_' : '-R --sort=yes',
        \    'ruby': '--languages=+Ruby',
        \ }

  augroup AlpacaTags
    autocmd!
    " au myac FileWritePost,BufWritePost *       AlpacaTagsUpdate -style
    " au myac FileWritePost,BufWritePost Gemfile AlpacaTagsUpdateBundle
    " au myac FileReadPost,BufEnter      *       AlpacaTagsSet
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
  au myac ColorScheme * hi IncSearch ctermbg=39 ctermfg=56 guibg=#00afff guifg=#5f00d7 cterm=NONE gui=NONE
  au myac ColorScheme * hi Search    ctermfg=75 ctermbg=18 guifg=#5fafff guibg=#000087 cterm=NONE gui=NONE

  let g:incsearch#no_inc_hlsearch        = 0    " 他のwindowではハイライトしない
  let g:incsearch#auto_nohlsearch        = 1    " 自動でハイライトを消す
  let g:incsearch#consistent_n_direction = 0    " 1:nで常にforwardに移動
  let g:incsearch#magic                  = '\v' " very magic

  if dein#is_sourced('incsearch-index.vim')
    map / <Plug>(incsearch-index-/)
    map ? <Plug>(incsearch-index-?)
    map g/ <Plug>(incsearch-index-stay)
  else
    map / <Plug>(incsearch-forward)
    map ? <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)
  endif

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
  let g:clever_f_ignore_case       = 0
  let g:clever_f_smart_case        = 0
  let g:clever_f_use_migemo        = 0
  let g:clever_f_across_no_line    = 0
  let g:clever_f_chars_match_any_signs = 0 " ;で ({\"を代用
  let g:clever_f_fix_key_direction = 0 " 1だとどんな時でもfで後ろにFで前に移動する
  let g:clever_f_show_prompt       = 1
  let g:clever_f_timeout_ms        = 0

  let g:clever_f_repeat_last_char_inputs = ["\<CR>", "\<Tab>"]
  " <Plug>(clever-f-repeat-forward)
  " <Plug>(clever-f-repeat-back)
endif "}}}

if dein#tap('vim-jplus') "{{{
  nmap J <Plug>(jplus)
  xmap J <Plug>(jplus)

  " 任意の1文字+両端に空白を挿入して結合を行う
  nmap gJ <Plug>(jplus-getchar)
  xmap gJ <Plug>(jplus-getchar)

  " 複数文字を入力したい場合
  nmap <Space>gJ <Plug>(jplus-input)
  vmap <Space>gJ <Plug>(jplus-input)

  " ,での結合にスペースを挿入
  let g:jplus#input_config = {
        \	"," : { "delimiter_format" : "%d " }
        \}
endif "}}}

if dein#tap('vim-quickhl') "{{{
  let g:quickhl_manual_enable_at_startup = 1
  let g:quickhl_cword_enable_at_startup  = 0
  let g:quickhl_tag_enable_at_startup    = 0
  let g:quickhl_manual_keywords          = [] " Can use List and Dictionary

  nmap gh <Plug>(quickhl-manual-this)
  nmap gl <Plug>(operator-quickhl-manual-this-motion)<Plug>(textobj-line-i)
  nmap gm <Plug>(operator-quickhl-manual-this-motion)
  xmap gh <Plug>(quickhl-manual-this)

  nmap \hm <Plug>(quickhl-manual-reset)
  xmap \hm <Plug>(quickhl-manual-reset)
  nmap \ht <Plug>(quickhl-tag-toggle)
  nmap \hc <Plug>(quickhl-cword-toggle)

  let g:quickhl_manual_hl_priority = 100
  let g:quickhl_manual_colors = [
        \ 'term=reverse ctermfg=232 ctermbg=160 gui=bold guifg=Black guibg=Red',
        \ 'term=reverse ctermfg=232 ctermbg=128 gui=bold guifg=Black guibg=Purple',
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
  autocmd myac FileType python setlocal omnifunc=jedi#completions
  let g:jedi#completions_enabled    = 0
  let g:jedi#auto_vim_configuration = 0
endif "}}}

if dein#tap('open-browser.vim') "{{{
  nmap gss :<c-u>Wsearch<CR>
  " nmap gsc <Plug>(openbrowser-open)
  xmap gsc <Plug>(openbrowser-smart-search)
  nmap gsc :call <sid>smart_open()<cr>

  function! s:smart_open() abort
    let str = expand('<cWORD>')
    let str = substitute(str, '[,.]$', '', '')
    call openbrowser#smart_search(str)
  endfunction

  command! Wsearch :call <SID>www_search()
  nnoremap <Plug>(openbrowser-wwwsearch) :<c-u>call <SID>www_search()<CR>
  function! s:www_search()
    let l:search_word = input('Please input search word: ')
    if l:search_word != ''
      execute 'OpenBrowserSearch' escape(l:search_word, '"')
    endif
  endfunction
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

if dein#tap('CamelCaseMotion') "{{{
  map <silent> <space>w <plug>CamelCaseMotion_w
  map <silent> <space>b <plug>CamelCaseMotion_b
  map <silent> <space>e <plug>CamelCaseMotion_e
endif "}}}

if dein#tap('vim-gista') "{{{
  let g:gista#client#default_username = 'uplus'
endif "}}}

if dein#tap('vim-fugitive') "{{{
  command! Commit Gcommit -v
  command! Fix Gcommit --amend -v
endif "}}}

if dein#tap('linediff.vim') "{{{
  nnoremap <silent>gsd  :Linediff<cr>
  xnoremap <silent>gsd  :Linediff<cr>
  autocmd User LinediffBufferReady nnoremap <silent><buffer>q :quit<cr>

  let g:linediff_buffer_type = 'scratch'
  " let g:linediff_first_buffer_command  = 'new'
  " let g:linediff_further_buffer_command = 'vertical new'
  " let g:linediff_indent = 1
endif "}}}

if dein#tap('shaberu.vim') "{{{
  command! -nargs=1 Say ShaberuSay <args>
  let g:shaberu_user_define_say_command = 'jsay "%%TEXT%%"'
  let g:shaberu_is_mute = 0
endif "}}}

if dein#tap('vim-expand-region') "{{{
  xmap v <Plug>(expand_region_expand)
  xmap gm <Plug>(expand_region_shrink)
endif "}}}

if dein#tap('vim-milfeulle') "{{{
  nmap <C-o> <Plug>(milfeulle-prev)
  nmap <C-i> <Plug>(milfeulle-next)
  let g:milfeulle_default_kind = "window"
  let g:milfeulle_default_jumper_name = "win_tab_bufnr_pos_line"
endif "}}}

if dein#tap('vim-over') "{{{
  " let g:over_enable_auto_nohlsearch = 1
  let g:over_enable_cmd_window = 0
  " let g:over_command_line_prompt = "> "
  " let g:over_command_line_key_mappings = {}
  " <Plug>(over-cmdline-scroll-y)     |CTRL-y| 相当
  " <Plug>(over-cmdline-scroll-u)     |CTRL-u| 相当
  " <Plug>(over-cmdline-scroll-f)     |CTRL-f| 相当
  " <Plug>(over-cmdline-scroll-e)     |CTRL-e| 相当
  " <Plug>(over-cmdline-scroll-d)     |CTRL-d| 相当
  " <Plug>(over-cmdline-scroll-b)     |CTRL-b| 相当

  nnoremap ss :OverCommandLine %s/\v<CR>
  nnoremap sw :OverCommandLine %s/\v<<C-r><C-w>>/<CR>
  nnoremap sW :OverCommandLine %s/\v<<C-r><C-a>>/<CR>
  xnoremap ss :OverCommandLine s/\v<CR>
  xnoremap sw :OverCommandLine s/\v<<C-r><C-w>>/<CR>
  xnoremap sW :OverCommandLine s/\v<<C-r><C-a>>/<CR>
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
