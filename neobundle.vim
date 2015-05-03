";とか押した時整形されるようにする
"syntasticをquickfixに出す
" 保存した時に随時更新されるようにする
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

" View
NeoBundle 'bronson/vim-trailing-whitespace' " 行末の半角スペースをハイライト
NeoBundle 'powerman/vim-plugin-AnsiEsc'     " ANSIカラー情報を反映して表示する
" NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'vim-scripts/Visual-Mark'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'AndrewRadev/linediff.vim'


NeoBundle 'kana/vim-submode'        " vimに独自のモードを作成できる
" NeoBundle 'tyru/vim-altercmd'       " :wとかの元からあるコマンドを書き換える
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic.git'
" NeoBundle 'osyo-manga/vim-watchdogs'
" NeoBundle 'dannyob/quickfixstatus'
" NeoBundle 'jceb/vim-hier'

NeoBundle 'kannokanno/previm'       " Markdown Previewer
NeoBundle 'mattn/webapi-vim'
" NeoBundle 'qtmplsel.vim'            " テンプレートを挿入 バグる

" rails and ruby
NeoBundle 'tpope/vim-rails'         " Modelを表示したりできる
NeoBundle 'basyura/unite-rails'     " Unite上にrailsの情報を表示する

NeoBundle 'tpope/vim-fugitive'      " git
NeoBundle 'LeafCage/yankround.vim'  " round the yank history

" search and replace
NeoBundle 'osyo-manga/vim-over'     " タブ補完が効く置き換えモード
NeoBundle 'osyo-manga/vim-anzu'     " show search point to command line
NeoBundle 'haya14busa/incsearch.vim' "サーチ時に全てをハイライト

NeoBundle 'tomtom/tcomment_vim'     " 他のも試したけどダメだった
NeoBundle 'kana/vim-smartchr'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'cohama/vim-smartinput-endwise'
NeoBundle 'tpope/vim-surround'      " 囲んでるものに対しての処理
NeoBundle 'AndrewRadev/switch.vim'  " ifとunlessを入れ替えたり

" Move
" NeoBundle 'deris/improvedft'        " ftFTで複数文字を入力できる
" NeoBundle 'rhysd/clever-f.vim'      " ftFTで,;の動作をする
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'deris/vim-shot-f'        " ftFTで一発で飛べる位置を表示する

" QuickRun
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/unite-quickfix' " uniteにquickfixを出力
NeoBundle 'osyo-manga/shabadou.vim'   " 汎用的なquickrun-hook

" textobj operator {{{
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'emonkak/vim-operator-comment'
" NoeBundle 'tyru/operator-camelize.vim'  " CamelCaseとsnake_caseを相互変換
NeoBundle 'emonkak/vim-operator-sort'
NeoBundle 'kana/vim-textobj-entire' " ae ie(先頭、末尾の空行なし)
NeoBundle 'kana/vim-textobj-syntax' " ay iy
NeoBundle 'kana/vim-textobj-line'   " al, il
NeoBundle 'kana/vim-textobj-function' " af, if
NeoBundle 'kana/vim-textobj-indent' " al, il カーソル位置と同じインデント
NeoBundle 'kana/vim-textobj-fold' " az, iz
NeoBundle 'thinca/vim-textobj-between' " af, if 任意の区切り文字
NeoBundle 'thinca/vim-textobj-comment' " ac, ic コメント
NeoBundle 'rhysd/vim-textobj-ruby' " arr, brr Ruby のブロック

NeoBundle 'thinca/vim-textobj-function-javascript'  " af, if JavaScript の関数内
NeoBundle 'rhysd/vim-textobj-continuous-line' " av, iv 行継続を用いている行
NeoBundle 'osyo-manga/vim-textobj-multiblock' " asb, isb 任意の複数の括弧のいずれか
NeoBundle 'thinca/vim-textobj-function-perl'  " af, if Perl の関数内
NeoBundle 'akiyan/vim-textobj-xml-attribute'  " axa, ixa XML の属性
NeoBundle 'deris/vim-textobj-enclosedsyntax'  " aq, iq Perl や Ruby の正規表現
NeoBundle 'deris/vim-textobj-headwordofline'  " ah, ih 行の先頭の word
NeoBundle 'anyakichi/vim-textobj-xbrackets' " axb, ixb x() や x<> など
NeoBundle 'hchbaw/textobj-motionmotion.vim' " am, im 任意の2つの motion の間
NeoBundle 'saihoooooooo/vim-textobj-space'  " aS, iS 連続したスペース
NeoBundle 'rhysd/vim-textobj-lastinserted'  " au, iu textobjとして最後に挿入された範囲
NeoBundle 'osyo-manga/vim-textobj-context'  " icx 別のfiletype のコンテキスト
NeoBundle 'deton/textobj-mbboundary.vim'    " am, im ASCIIとmultibyte文字の境界を区切り
NeoBundle 'gilligan/textobj-lastpaste'  " ip 直前に変更またはヤンクされたテキスト 標準である?
NeoBundle 'sgur/vim-textobj-parameter'  " a, i, 関数の引数
NeoBundle 'glts/vim-textobj-indblock'   " ao, io インデントの空白行
NeoBundle 'akiyan/vim-textobj-php'  " aP, iP phpタグに囲まれた部分
NeoBundle 'mattn/vim-textobj-cell'  " ac, ic 前後のスペースを取り除いたカーソル行
NeoBundle 'bps/vim-textobj-python'  " af, if Python
NeoBundle 'mattn/vim-textobj-url'   " au, iu URL
NeoBundle 'h1mesuke/textobj-wiw'    " a,w, i,w snake_case 上の word

NeoBundle 'rhysd/vim-operator-trailingspace-killer'  " textobjの末尾のホワイトスペースを削除
NeoBundle 'rhysd/vim-operator-evalruby' " 選択したtextobjをRubyの式として評価する
" }}}

" colorscheme"{{{
NeoBundle 'croaker/mustang-vim'
NeoBundle 'vim-scripts/Lucius'
NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'djjcast/mirodark'
NeoBundle 'vim-scripts/BusyBee'
NeoBundle '1player/lettuce.vim'
"}}}

if s:meet_neocomplete_requirements()
  NeoBundle 'Shougo/neocomplete'
endif
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Rip-Rip/clang_complete'
NeoBundleLazy 'osyo-manga/vim-stargate', {
      \ 'autoload' : {'filetypes' : ['c', 'cpp'] } }

" <CR> config "{{{
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

" colorscheme config
function s:set_colorscheme()
  if &filetype == 'cpp' || &filetype == 'c'
    colorscheme lettuce
  elseif &filetype == 'ruby' || &filetype == 'gitcommit'
    colorscheme railscasts_u10
  else
    colorscheme molokai
  endif
endfunction
au FileType * call s:set_colorscheme()

" #over
let g:over#command_line#enable_move_cursor = 1
let g:over_command_line_prompt = "> "
" let g:over_enable_auto_nohlsearch = 1
" let g:over_enable_cmd_window = 1
" let g:over#command_line#search#enable_incsearch = 1
" let g:over#command_line#search#enable_move_cursor = 1

"# anzu&incsearch マッチした数&自動ハイライト&オフ
" set incsearch set hlsearchいらない
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

" #nerdtree
"0ならそのまま開いとく, 1なら閉じる
" let g:NERDTreeQuitOnOpen=0 "//defo 0
"let g:NERDTreeShowHidden=0 "//defo 0
let g:NERDTreeWinSize=26  "//defo 31

" #easymotion
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
let g:EasyMotion_leader_key="mm"
let g:EasyMotion_grouping=1       " 1 ストローク選択を優先する
nmap <Space>j mmj
nmap <Space>k mmk

" #syntastic
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = $CPP_COMP_OPT
let g:syntastic_always_populate_loc_list = 1  " quickfixの表示を更新する
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 0
" let g:syntastic_debug = 1

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
"}}}

" #yankround
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
let g:yankround_max_history = 50
let g:yankround_dir = "~/.vim/tmp/"


call Source_rc('switch.rc.vim')
if s:meet_neocomplete_requirements()
  call Source_rc('complete.rc.vim')
endif
if !exists('loaded_matchit') " rubyとかでdef~endの移動をしてくれる
  runtime macros/matchit.vim
endif
NeoBundleCheck
