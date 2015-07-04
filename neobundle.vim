  "------------------"
  "Neobundle Settings"
  "------------------"
filetype off
filetype plugin indent off

if !isdirectory($HOME . '/.vim/bundle/neobundle.vim/')
  silent! !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
endif

function! s:meet_neocomplete_requirements()
    return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction

if has('vim_starting') "set the directory to be managed by the bundle
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle'))

NeoBundle 'Shougo/vimproc.vim', { 'build' : {
      \   'mac'   : 'make -f make_mac.mak',
      \   'linux' : 'make',
      \   'unix'  : 'make -f make_unix.mak',
      \}, }
NeoBundle 'Shougo/vimshell'
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'tacroe/unite-mark'
NeoBundle 'Shougo/unite-help' " Unite で検索できる

" #view "{{{
NeoBundle 'powerman/vim-plugin-AnsiEsc'     " カラー情報を反映して表示
NeoBundle 'bronson/vim-trailing-whitespace' " 行末の半角スペースをハイライト
" NeoBundle 'itchyny/lightline.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'Yggdroot/indentLine'
"}}}

" #action "{{{
NeoBundle 'AndrewRadev/linediff.vim' " visual-modeで選択した2つの行をvimdiffで確認する
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'tpope/vim-unimpaired'     " :cnextとかのマッピングを提供 [p ]q
NeoBundle 'LeafCage/yankround.vim'   " round the yank history
NeoBundle 'kana/vim-submode'         " vimに独自のモードを作成
" NeoBundle 'tyru/vim-altercmd'       " :wとかの元からあるコマンドを書き換え
NeoBundle 'tpope/vim-surround'       " 囲んでるものに対しての処理
NeoBundle 'tpope/vim-repeat'         " surroundなどを.でリピートできる
NeoBundle 'AndrewRadev/switch.vim'   " ifとunlessを入れ替えたり
"}}}

" #search and #replace "{{{
NeoBundle 'osyo-manga/vim-anzu'      " show search point on the command-line
NeoBundle 'haya14busa/incsearch.vim' "サーチ時に全てをハイライト
" NeoBundle 'osyo-manga/vim-over'     " タブ補完が効く置き換えモード
"}}}

" #move"{{{
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'kana/vim-smartword'
" NeoBundle 'deris/improvedft'        " ftFTで複数文字を入力できる
" NeoBundle 'rhysd/clever-f.vim'      " ftFTで,;の動作をする
" NeoBundle 'deris/vim-shot-f'        " ftFTで一発で飛べる位置を表示する
"}}}

" #syntaxchecker"{{{
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'scrooloose/syntastic.git'
" NeoBundle 'osyo-manga/vim-watchdogs'
" NeoBundle 'dannyob/quickfixstatus'
" NeoBundle 'jceb/vim-hier'
" NeoBundle 'Shougo/echodoc'
"}}}

" #quickrun"{{{
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/unite-quickfix' " uniteにquickfixを出力
NeoBundle 'osyo-manga/shabadou.vim'   " 汎用的なquickrun-hook
"}}}

NeoBundle 'Shougo/vinarise'         " バイナリを閲覧
NeoBundle 'tpope/vim-speeddating'   " 年月日に加算できる
NeoBundle 'tomtom/tcomment_vim'     " 他のも試したけどダメだった
NeoBundle 'kannokanno/previm'       " Markdown Previewer
NeoBundle 'mattn/webapi-vim'
NeoBundleLazy 'osyo-manga/vim-stargate', { 'autoload' : {'filetypes' : ['c', 'cpp'] } }
NeoBundle 'comeonly/php.vim-html-enhanced' " php,htmlのindentをきれいに
NeoBundle 'tpope/vim-fugitive'      " git
" NeoBundle 'airblade/vim-gitgutter'  " gitのdiffを行に表示

" #rails and #ruby"{{{
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'         " Modelを表示したりできる
NeoBundle 'basyura/unite-rails'     " Unite上にrailsの情報を表示する
NeoBundle 'bbatsov/rubocop'
" NeoBundle 'todesking/ruby_hl_lvar.vim' "うまく動作しなかった
"}}}

" #tab and #ref "{{{
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'
NeoBundle 'szw/vim-tags'
NeoBundleLazy 'alpaca-tc/alpaca_tags', {
      \ 'depends': ['Shougo/vimproc'],
      \ 'autoload' : {
      \    'commands' : [
      \       { 'name' : 'AlpacaTagsBundle', 'complete': 'customlist,alpaca_tags#complete_source' },
      \       { 'name' : 'AlpacaTagsUpdate', 'complete': 'customlist,alpaca_tags#complete_source' },
      \       'AlpacaTagsSet', 'AlpacaTagsCleanCache', 'AlpacaTagsEnable', 'AlpacaTagsDisable', 'AlpacaTagsKillProcess', 'AlpacaTagsProcessStatus',
      \    ],
      \ }
      \ }
"}}}

" #textobj #operator {{{
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'emonkak/vim-operator-comment'
" NoeBundle 'tyru/operator-camelize.vim'  " CamelCaseとsnake_caseを相互変換
NeoBundle 'emonkak/vim-operator-sort'
NeoBundle 'kana/vim-textobj-entire'           " ae ie(先頭、末尾の空行なし)
NeoBundle 'kana/vim-textobj-syntax'           " ay iy
" NeoBundle 'kana/vim-textobj-line'   " al il
NeoBundle 'kana/vim-textobj-function'         " af if
NeoBundle 'kana/vim-textobj-indent'           " al il カーソル位置と同じインデント
NeoBundle 'kana/vim-textobj-fold'             " az iz
NeoBundle 'thinca/vim-textobj-between'        " af if 任意の区切り文字
NeoBundle 'thinca/vim-textobj-comment'        "ac ic コメント
NeoBundle 'gilligan/textobj-lastpaste'        "ip 直前に変更またはヤンクされたテキスト
NeoBundle 'rhysd/vim-textobj-ruby'            " arr brr Ruby のブロック

" NeoBundle 'thinca/vim-textobj-function-javascript'  " af if JavaScript の関数内
" NeoBundle 'thinca/vim-textobj-function-perl'  " af if Perl の関数内
NeoBundle 'saihoooooooo/vim-textobj-space'    " aS iS 連続したスペース
NeoBundle 'rhysd/vim-textobj-lastinserted'    " au iu textobjとして最後に挿入された範囲
" NeoBundle 'h1mesuke/textobj-wiw'    " a,w, i,w snake_case 上のword  ,がリマップされる
" NeoBundle 'sgur/vim-textobj-parameter'  " a i 関数の引数
NeoBundle 'osyo-manga/vim-textobj-multiblock' " asb isb 任意の複数の括弧のいずれか
NeoBundle 'akiyan/vim-textobj-xml-attribute'  " axa ixa XML の属性
NeoBundle 'anyakichi/vim-textobj-xbrackets'   " axb ixb x() や x<> など
NeoBundle 'hchbaw/textobj-motionmotion.vim'   " am im 任意の2つの motion の間
NeoBundle 'osyo-manga/vim-textobj-context'    " icx 別のfiletype のコンテキスト

NeoBundle 'glts/vim-textobj-indblock'         " ao io インデントの空白行
NeoBundle 'deris/vim-textobj-enclosedsyntax'  " aq iq Perl や Ruby の正規表現
NeoBundle 'rhysd/vim-operator-evalruby'       " 選択したtextobjをRubyの式として評価する
" }}}

" #colorscheme"{{{
NeoBundle 'freeo/vim-kalisi'
NeoBundle 'croaker/mustang-vim'
NeoBundle 'vim-scripts/Lucius'
NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'djjcast/mirodark'
NeoBundle 'vim-scripts/BusyBee'
NeoBundle '1player/lettuce.vim'
NeoBundle 'altercation/vim-colors-solarized'
"}}}

" #input-support"{{{
if s:meet_neocomplete_requirements()
  NeoBundle 'Shougo/neocomplete'
  " NeoBundle 'marcus/rsense' :helpが使えなくなる
  NeoBundle 'NigoroJr/rsense'
  NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', {
        \ 'autoload' : { 'insert' : 1, 'filetype' : 'ruby', } }
endif

NeoBundle 'kana/vim-smartinput'
NeoBundle 'kana/vim-smartchr'
NeoBundle 'cohama/vim-smartinput-endwise' "ブロック引数を複数とるとendが入力されない
" NeoBundle 'tpope/vim-endwise' " CRのマップをとられるとうまく動作しない
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Rip-Rip/clang_complete'
"}}}

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
    call s:define_rule_ruby()

    imap <expr><CR> !pumvisible() ? "\<Plug>(vimrc_cr)" :
          \ neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" :
          \ neocomplete#close_popup()
  endfunction
  call neobundle#untap()
endif
"}}}

call neobundle#end()
filetype plugin indent on " Required
NeoBundleCheck
"###################### plugin config ############################"

let g:rsenseUseOmniFunc = 1
let g:no_cecutil_maps=1 " AnsiEsc の中で変なマッピングをしないようにする
let g:solarized_termcolors=256 "solarizedをCUIで使うため
let g:vinarise_enable_auto_detect=1
" call smartinput_endwise#define_default_rules()

function! s:define_rule_ruby()
  let l:pattern = '\%(^\s*#.*\)\@<!do\s*\%(|.*|\)\?\s*\%#'
  call smartinput#define_rule({
        \ 'at' : l:pattern, 'char': '<CR>',
        \ 'input': '<CR>' .  'end' . '<Esc>O',
        \ 'filetype': ['ruby']
        \ })
endfunction

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

" #airline"{{{
let g:airline_theme     = "dark"
let g:airline_left_sep  = ""
let g:airline_right_sep = ""
let g:airline#extensions#tabline#enabled      = 1
let g:airline#extensions#tabline#left_sep     = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
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

" #anzu&incsearch マッチした数&自動ハイライト&オフ"{{{
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
"}}}

" #alpaca_tags"{{{
  let g:alpaca_tags#config = {
                         \    '_' : '-R --sort=yes',
                         \    'ruby': '--languages=+Ruby',
                         \ }
  augroup AlpacaTags
    autocmd!
    if exists(':Tags')
      autocmd BufWritePost Gemfile TagsBundle
      autocmd BufEnter * TagsSet
      " 毎回保存と同時更新する場合はコメントを外す
      " autocmd BufWritePost * TagsUpdate
    endif
  augroup END
"}}}

" #vimfiler"{{{
  " https://github.com/Shougo/vimfiler.vim/blob/master/doc/vimfiler.txt
  let g:vimfiler_as_default_explorer = 1
  " let g:vimfiler_safe_mode_by_default = 0
  " let g:vimfiler_edit_action = 'edit'

  " -no-quit ファイルを開いても終了しない カレントバッファと入れ替える
  " command! Vf VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit
  command! Vfe VimFiler -split -simple -find -winwidth=26 -no-quit
  command! Vfs VimFiler -split -simple
  command! Vfn VimFiler
  command! Vf Vfe

  "VimFilerを起動してからじゃないと関数が読み込まれない
  function! s:set_vimfiler_unexpand_tree() "{{{
    if hasmapto("<Plug>(vimfiler_unexpand_tree)")
      return
    endif

    " 名前を取得
    Capture function /\d+*_unexpand_tree\(\)$
    let l:func_name = substitute(g:capture, '^function ', '', '')

    if empty(l:func_name)
      return
    endif

    execute 'nnoremap <buffer><silent> <Plug>(vimfiler_unexpand_tree) :<C-u>call' l:func_name '<CR>'
  endfunction "}}}

  au FileType vimfiler call s:vimfiler_settings()
  function! s:vimfiler_settings() "{{{
    setlocal nobuflisted
    call s:set_vimfiler_unexpand_tree()

    nmap <silent><buffer>h <Plug>(vimfiler_unexpand_tree)
    nmap <silent><buffer>l <Plug>(vimfiler_expand_tree)
    nmap <silent><buffer><CR> <Plug>(vimfiler_cd_or_edit)
    " nmap <silent><buffer><CR> <Plug>(vimfiler_expand_or_edit)

    " vimfilerのsplitは水平じゃなくて垂直 時々VimFilerWindがリサイズされる
    " nmap <buffer>v <Plug>(vimfiler_split_edit_file)
    nnoremap <buffer>s :call vimfiler#mappings#do_action('my_split')<CR>
    nnoremap <buffer>v :call vimfiler#mappings#do_action('my_vsplit')<CR>

    nnoremap <buffer><Tab> :call vimfiler#mappings#do_action('tabopen')<CR>
    nnoremap <buffer>\ \
    nmap <buffer>- <Plug>(vimfiler_switch_to_root_directory)

    " 最後のバッファでも終了
    " nnoremap <buffer><nowait>q :quit<CR>
  endfunction "}}}

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
"}}}

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
  let g:syntastic_always_populate_loc_list = 1  " quickfixの表示を更新する
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq   = 0
  let g:syntastic_enable_signs  = 0
  " let g:syntastic_debug = 1

  let g:syntastic_cpp_compiler = 'clang++'
  let g:syntastic_cpp_compiler_options = $CPP_COMP_OPT
  let g:syntastic_ruby_mri_args = "-W1"
"}}}

" #quickrun "{{{
  let g:quickrun_no_default_key_mappings = 1
  nnoremap <Leader>r :write<CR>:QuickRun -mode n<CR>
  xnoremap <Leader>r :write<CR>:QuickRun -mode v<CR>

  " Config {{{
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
  "}}}

  " Languages {{{
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
  "}}}

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
