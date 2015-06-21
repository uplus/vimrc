  "------------------"
  "Neobundle Settings"
  "------------------"
filetype off
filetype plugin indent off

function! s:meet_neocomplete_requirements()
    return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction

if has('vim_starting') "set the directory to be managed by the bundle
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'tacroe/unite-mark'

NeoBundle 'Shougo/vimproc.vim', { 'build' : {
                            \   'mac'   : 'make -f make_mac.mak',
                            \   'linux' : 'make',
                            \   'unix'  : 'make -f make_unix.mak',
                            \}, }

NeoBundle 'Shougo/vimshell'

" #view
NeoBundle 'powerman/vim-plugin-AnsiEsc'     " カラー情報を反映して表示
NeoBundle 'bronson/vim-trailing-whitespace' " 行末の半角スペースをハイライト
" NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'vim-scripts/Visual-Mark'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'AndrewRadev/linediff.vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'Yggdroot/indentLine'

NeoBundle 'kana/vim-submode'        " vimに独自のモードを作成
" NeoBundle 'tyru/vim-altercmd'       " :wとかの元からあるコマンドを書き換え
" NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'scrooloose/syntastic.git'
" NeoBundle 'osyo-manga/vim-watchdogs'
" NeoBundle 'dannyob/quickfixstatus'
" NeoBundle 'jceb/vim-hier'
NeoBundle 'Shougo/vinarise'

NeoBundle 'kannokanno/previm'       " Markdown Previewer
NeoBundle 'mattn/webapi-vim'
" NeoBundle 'qtmplsel.vim'            " テンプレートを挿入 バグる

" #rails and #ruby
NeoBundle 'tpope/vim-rails'         " Modelを表示したりできる
NeoBundle 'basyura/unite-rails'     " Unite上にrailsの情報を表示する

NeoBundle 'tpope/vim-fugitive'      " git
" NeoBundle 'airblade/vim-gitgutter'  " gitのdiffを行に表示
NeoBundle 'LeafCage/yankround.vim'  " round the yank history

" #search and #replace
" NeoBundle 'osyo-manga/vim-over'     " タブ補完が効く置き換えモード
NeoBundle 'osyo-manga/vim-anzu'     " show search point on the command-line
NeoBundle 'haya14busa/incsearch.vim' "サーチ時に全てをハイライト

NeoBundle 'tomtom/tcomment_vim'     " 他のも試したけどダメだった
NeoBundle 'kana/vim-smartchr'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'cohama/vim-smartinput-endwise' " 前のやつの方が良かったかも
NeoBundle 'kana/vim-smartword'
NeoBundle 'tpope/vim-surround'      " 囲んでるものに対しての処理
NeoBundle 'tpope/vim-speeddating'   " 年月日に加算できる
NeoBundle 'tpope/vim-repeat'        " surroundなどを.でリピートできる
NeoBundle 'AndrewRadev/switch.vim'  " ifとunlessを入れ替えたり
NeoBundle 'comeonly/php.vim-html-enhanced' " php,htmlのindentをきれいに

" #move
" NeoBundle 'deris/improvedft'        " ftFTで複数文字を入力できる
" NeoBundle 'rhysd/clever-f.vim'      " ftFTで,;の動作をする
" NeoBundle 'deris/vim-shot-f'        " ftFTで一発で飛べる位置を表示する
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'tpope/vim-unimpaired'      " :cnextとかのマッピングを提供 [p ]q

" #quickrun
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/unite-quickfix' " uniteにquickfixを出力
NeoBundle 'osyo-manga/shabadou.vim'   " 汎用的なquickrun-hook
" NeoBundle 'skwp/vim-rspec'

" #textobj #operator {{{
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'emonkak/vim-operator-comment'
" NoeBundle 'tyru/operator-camelize.vim'  " CamelCaseとsnake_caseを相互変換
NeoBundle 'emonkak/vim-operator-sort'
NeoBundle 'kana/vim-textobj-entire' " ae ie(先頭、末尾の空行なし)
NeoBundle 'kana/vim-textobj-syntax' " ay iy
" NeoBundle 'kana/vim-textobj-line'   " al il
NeoBundle 'kana/vim-textobj-function'   " af if
NeoBundle 'kana/vim-textobj-indent'     " al il カーソル位置と同じインデント
NeoBundle 'kana/vim-textobj-fold'       " az iz
NeoBundle 'thinca/vim-textobj-between'  " af if 任意の区切り文字
NeoBundle 'thinca/vim-textobj-comment'  "ac ic コメント
NeoBundle 'gilligan/textobj-lastpaste'  "ip 直前に変更またはヤンクされたテキスト
NeoBundle 'rhysd/vim-textobj-ruby' " arr brr Ruby のブロック

" NeoBundle 'thinca/vim-textobj-function-javascript'  " af if JavaScript の関数内
" NeoBundle 'thinca/vim-textobj-function-perl'  " af if Perl の関数内
NeoBundle 'saihoooooooo/vim-textobj-space'  " aS iS 連続したスペース
NeoBundle 'rhysd/vim-textobj-lastinserted'  " au iu textobjとして最後に挿入された範囲
" NeoBundle 'h1mesuke/textobj-wiw'    " a,w, i,w snake_case 上のword  ,がリマップされる
" NeoBundle 'sgur/vim-textobj-parameter'  " a i 関数の引数

NeoBundle 'osyo-manga/vim-textobj-multiblock' " asb isb 任意の複数の括弧のいずれか
NeoBundle 'akiyan/vim-textobj-xml-attribute'  " axa ixa XML の属性
NeoBundle 'anyakichi/vim-textobj-xbrackets' " axb ixb x() や x<> など
NeoBundle 'hchbaw/textobj-motionmotion.vim' " am im 任意の2つの motion の間
NeoBundle 'osyo-manga/vim-textobj-context'  " icx 別のfiletype のコンテキスト

NeoBundle 'glts/vim-textobj-indblock'   " ao io インデントの空白行
NeoBundle 'deris/vim-textobj-enclosedsyntax'  " aq iq Perl や Ruby の正規表現
NeoBundle 'rhysd/vim-operator-evalruby' " 選択したtextobjをRubyの式として評価する
" }}}

" #colorscheme"{{{
NeoBundle 'croaker/mustang-vim'
NeoBundle 'vim-scripts/Lucius'
NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'djjcast/mirodark'
NeoBundle 'vim-scripts/BusyBee'
NeoBundle '1player/lettuce.vim'
NeoBundle 'altercation/vim-colors-solarized'
"}}}

if s:meet_neocomplete_requirements()
  NeoBundle 'Shougo/neocomplete'
endif
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Rip-Rip/clang_complete'
NeoBundleLazy 'osyo-manga/vim-stargate', {
      \ 'autoload' : {'filetypes' : ['c', 'cpp'] } }

" <CR>mapping config "{{{
if neobundle#tap('vim-smartinput')
  call neobundle#config({ 'autoload' : { 'insert' : 1 }})

  function! neobundle#tapped.hooks.on_post_source(bundle)
    call smartinput_endwise#define_default_rules()
  endfunction

  call neobundle#untap()
endif

" neosnippet and neocomplete compatible
" C-r=のマップでもimapにすれば平気かも
if neobundle#tap('vim-smartinput-endwise')
  function! neobundle#tapped.hooks.on_post_source(bundle)
    call smartinput#map_to_trigger('i', '<Plug>(vimrc_cr)', '<Enter>', '<Enter>')
    imap <expr><CR> !pumvisible() ? "\<Plug>(vimrc_cr)" :
          \ neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" :
          \ neocomplete#close_popup()
  endfunction
  call neobundle#untap()
endif
"}}}

call neobundle#end()
filetype plugin indent on " Required

"###################### plugin config ############################"
let g:no_cecutil_maps=1 " AnsiEsc の中で変なマッピングをしないようにする
let g:solarized_termcolors=256 "solarizedをCUIで使うため
let g:vinarise_enable_auto_detect=1
" call smartinput_endwise#define_default_rules()

" #easyalign"{{{
  vmap <Enter> <Plug>(EasyAlign)
  vmap <Space><Enter> <Plug>(LiveEasyAlign)
  " nmap ga <Plug>(EasyAlign)
  let g:easy_align_ignore_groups = ['Comment', 'String']

  let g:easy_align_delimiters = {
  \ '>': { 'pattern': '>>\|=>\|>' },
  \ '/': {
  \     'pattern':         '//\+\|/\*\|\*/',
  \     'delimiter_align': 'l',
  \     'ignore_groups':   ['!Comment'] },
  \ ']': {
  \     'pattern':       '[[\]]',
  \     'left_margin':   0,
  \     'right_margin':  0,
  \     'stick_to_left': 0
  \   },
  \ ')': {
  \     'pattern':       '[()]',
  \     'left_margin':   0,
  \     'right_margin':  0,
  \     'stick_to_left': 0
  \   },
  \ 'd': {
  \     'pattern':      ' \(\S\+\s*[;=]\)\@=',
  \     'left_margin':  0,
  \     'right_margin': 0
  \   }
  \ }
"}}}

" #indentLine
  nmap <silent><Leader>i :<C-u>IndentLinesToggle<CR>
  let g:indentLine_faster = 1
  " let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'calendar', 'thumbnail', 'tweetvim']

" #over
  let g:over#command_line#enable_move_cursor = 1
  let g:over_command_line_prompt = "> "
  " let g:over_enable_auto_nohlsearch = 1
  " let g:over_enable_cmd_window = 1
  " let g:over#command_line#search#enable_incsearch = 1
  " let g:over#command_line#search#enable_move_cursor = 1

" #anzu&incsearch マッチした数&自動ハイライト&オフ
  set hlsearch
  let g:incsearch#auto_nohlsearch = 1 "自動でハイライトを消す
  map / <Plug>(incsearch-forward)
  map ? <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  map n <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)
  map N <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)
  map * <Plug>(anzu-n-with-echo)
  map # <Plug>(anzu-N-with-echo)
  map * <Plug>(incsearch-nohl-*)
  map # <Plug>(incsearch-nohl-#)

" #vimfiler
  let g:vimfiler_as_default_explorer = 1
  " -find    指定するとカレントバッファと入れ替える
  " -no-quit ファイルを開いても終了しない
  " -simple  日付などを表示しない
  " command Vf VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit
  command! Vf VimFilerExplorer -split -simple -find -winwidth=26 -focus
  "セーフモードを無効にした状態で起動する
  " let g:vimfiler_safe_mode_by_default = 0
  " let g:vimfiler_edit_action = 'edit'
  let g:vimfiler_expand_jump_to_first_child=0

  "VimFilerを起動してからじゃないと関数が読み込まれない
  function! Get_sid()
    silent! redir => commands
    silent! scriptnames
    silent! redir END
    let l:line = matchstr(commands, '\d*:\D*vimfiler\/mappings.vim')
    let l:sid  = matchstr(l:line, '^\d*')
    let @a = l:line
    let @b = l:sid
    echo @a
    echo @b

    " nnoremap <buffer><silent><expr> <Plug>(vimfiler_unexpand_tree)
          " \ ":\<C-u>call \<SNR>" . l:sid . "_unexpand_tree()\<CR>"
  endfunction

  "VimFilerを起動してからじゃないと関数が読み込まれない
  function! Get_func_names()
    silent! redir => funcs
    silent! function
    silent! redir END
    let g:func_names = funcs
    let @a = g:func_names
  endfunction

  au FileType vimfiler call s:vimfiler_settings()
  function! s:vimfiler_settings()
    " nnoremap <buffer><silent> <Plug>(vimfiler_unexpand_tree)
    "       \ :<C-u>call <SID>unexpand_tree()<CR>

    nmap     <buffer><expr><Cr> vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)", "\<Plug>(vimfiler_edit_file)")
    " nmap     <buffer>h <Plug>(vimfiler_expand_tree)
    nmap     <buffer>l <Plug>(vimfiler_expand_tree)
    " nmap     <buffer>l<Plug>(vimfiler_cd)
    nnoremap <buffer>s          :call vimfiler#mappings#do_action('my_split')<CR>
    nnoremap <buffer>v          :call vimfiler#mappings#do_action('my_vsplit')<CR>

    nmap <buffer><Tab> atabopen<CR>
    " nmap <buffer>s <Plug>(vimfiler_split_edit_file)
    nnoremap <buffer>\ \
    nmap <buffer>- <Plug>(vimfiler_switch_to_root_directory)

    " 最後に残っても終了する
    nmap <buffer><nowait>q :quit<CR>
    " nmap <buffer><nowait>q <Plug>(vimfiler_exit)
    " nmap <buffer> Q <Plug>(vimfiler_hide)
  endfunction

  let s:my_action = { 'is_selectable' : 1 }
  function! s:my_action.func(candidates)
    wincmd p
    exec 'split '. a:candidates[0].action__path
  endfunction
  call unite#custom_action('file', 'my_split', s:my_action)

  let s:my_action = { 'is_selectable' : 1 }
  function! s:my_action.func(candidates)
    wincmd p
    exec 'vsplit '. a:candidates[0].action__path
  endfunction
  call unite#custom_action('file', 'my_vsplit', s:my_action)

" #nerdtree
  "0ならそのまま開いとく, 1なら閉じる
  " let g:NERDTreeQuitOnOpen=0 "//defo 0
  "let g:NERDTreeShowHidden=0 "//defo 0
  let g:NERDTreeWinSize=26  "//defo 31

" #easymotion"{{{
  let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvb'
  let g:EasyMotion_leader_key="mm"
  " let g:EasyMotion_grouping=1       " 1 ストローク選択を優先する
  map <Space>j <Plug>(easymotion-j)
  map <Space>k <Plug>(easymotion-k)
  map <Space>w <Plug>(easymotion-w)
  map <Space>f <Plug>(easymotion-fl)
  map <Space>t <Plug>(easymotion-tl)
  map <Space>F <Plug>(easymotion-Fl)
  map <Space>T <Plug>(easymotion-Tl)
  " nmap s <Plug>(easymotion-s2)
  " xmap s <Plug>(easymotion-s2)
  " surround.vimと被らないように
  " omap z <Plug>(easymotion-s2)
"}}}

" #smartword 記号を含まず消したい時がある
  " map w  <Plug>(smartword-w)
  " map b  <Plug>(smartword-b)
  " map e  <Plug>(smartword-e)
  " map ge <Plug>(smartword-ge)

" #syntastic"{{{
  let g:syntastic_cpp_compiler = 'clang++'
  let g:syntastic_cpp_compiler_options = $CPP_COMP_OPT
  let g:syntastic_always_populate_loc_list = 1  " quickfixの表示を更新する
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_enable_signs = 0
  " let g:syntastic_debug = 1
"}}}

" #quickrun"{{{
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'hook/close_unite_quickfix/enable_hook_loaded' : 1,
      \ 'hook/unite_quickfix/enable_failure' : 1,
      \ 'hook/close_quickfix/enable_exit' : 1,
      \ 'hook/close_buffer/enable_failure' : 1,
      \ 'hook/close_buffer/enable_empty_data' : 1,
      \ 'outputter' : 'multi:buffer:quickfix',
      \ 'hook/shabadoubi_touch_henshin/enable' : 1,
      \ 'hook/shabadoubi_touch_henshin/wait' : 20,
      \ 'outputter/buffer/split' : ':botright 8sp',
      \ 'runner' : 'vimproc',
      \ 'runner/vimproc/updatetime' : 40,
      \ }

let g:quickrun_config.cpp = {
      \ 'command' : '/usr/bin/clang++',
      \ 'cmdopt'  : $CPP_COMP_OPT
      \ }

let g:quickrun_config.c = {
      \ 'command' : '/usr/bin/clang',
      \ 'cmdopt'  : $C_COMP_OPT
      \ }
let g:quickrun_config.markdown = {
      \ 'type': 'markdown/pandoc',
      \ 'cmdopt': '-s',
      \ 'outputter': 'browser'
      \ }

let g:quickrun_no_default_key_mappings = 1

" RSpec実行
function! RSpec_run()
  write
  !rspec %
endfunction
command! Spec :call RSpec_run()

autocmd BufWinEnter,BufNewFile *_spec.rb nnoremap <buffer>\r :call RSpec_run()<CR>

"}}}

" #yankround"{{{
  nmap p <Plug>(yankround-p)
  xmap p <Plug>(yankround-p)
  nmap P <Plug>(yankround-P)
  nmap gp <Plug>(yankround-gp)
  xmap gp <Plug>(yankround-gp)
  nmap gP <Plug>(yankround-gP)
  nmap <C-p> <Plug>(yankround-prev)
  nmap <C-n> <Plug>(yankround-next)
  " round対象のうちはハイライトする
  let g:yankround_use_region_hl = 1
  let g:yankround_max_history = 20
  let g:yankround_dir = "~/.vim/tmp/"
"}}}

call Source_rc('switch.rc.vim')
if s:meet_neocomplete_requirements()
  call Source_rc('complete.rc.vim')
endif
if !exists('loaded_matchit') " rubyとかでdef~endの移動をしてくれる
  runtime macros/matchit.vim
endif
NeoBundleCheck
