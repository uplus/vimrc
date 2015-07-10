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

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    }
      \ }

NeoBundleLazy 'Shougo/vimshell.vim', { 'depends' : [ 'Shougo/vimproc.vim' ] }
NeoBundleLazy 'ujihisa/vimshell-ssh', { 'depends' : [ 'Shougo/vimshell.vim' ] }


" #unite "{{{
NeoBundle     'Shougo/unite.vim'
NeoBundleLazy 'Shougo/neomru.vim',                { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'Shougo/unite-build',               { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'Shougo/unite-help',                { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'Shougo/unite-outline',             { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'osyo-manga/unite-filetype',        { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'osyo-manga/unite-fold/',           { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'osyo-manga/unite-highlight',       { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'osyo-manga/unite-quickfix',        { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'osyo-manga/unite-quickrun_config', { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'osyo-manga/unite-vimpatches',      { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'osyo-manga/unite-vital-module',    { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'rhysd/unite-ruby-require.vim',     { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'tacroe/unite-alias',               { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'tacroe/unite-mark',                { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'taka84u9/unite-git',               { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'thinca/vim-unite-history',         { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'ujihisa/unite-colorscheme',        { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'ujihisa/unite-locate',             { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'zhaocai/unite-scriptnames',        { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'bundai223/unite-picktodo',         { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'kannokanno/unite-todo',            { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'mattn/unite-remotefile',           { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'supermomonga/unite-goimport.vim',  { 'depends' : [ 'Shougo/unite.vim', 'fatih/vim-go' ] }

"}}}

" #view "{{{
NeoBundle 'powerman/vim-plugin-AnsiEsc'     " カラー情報を反映して表示
NeoBundle 'bronson/vim-trailing-whitespace' " 行末の半角スペースをハイライト
" NeoBundle 'itchyny/lightline.vim'
NeoBundle 'bling/vim-airline'
" NeoBundle 'Yggdroot/indentLine'
"}}}

" #action "{{{
NeoBundle 'AndrewRadev/linediff.vim' " visual-modeで選択した2つの行をvimdiffで確認する
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'tpope/vim-unimpaired'     " :cnextとかのマッピングを提供 [p ]q
NeoBundle 'LeafCage/yankround.vim'   " round the yank history
NeoBundle 'kana/vim-submode'         " vimに独自のモードを作成
" NeoBundle 'tyru/vim-altercmd'       " :wとかの元からあるコマンドを書き換え
NeoBundle 'tpope/vim-repeat'
" NeoBundle 'kana/vim-repeat'
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
NeoBundleLazy 'Shougo/vimfiler.vim', { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundle 'scrooloose/syntastic.git'
" NeoBundle 'osyo-manga/vim-watchdogs'
" NeoBundle 'dannyob/quickfixstatus'
" NeoBundle 'jceb/vim-hier'
" NeoBundle 'Shougo/echodoc'
"}}}

" #quickrun"{{{
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/shabadou.vim'   " 汎用的なquickrun-hook
"}}}

" NeoBundle 'osyo-manga/vim-jplus'    " 任意の文字で行を結合する
NeoBundle 'Shougo/vinarise'         " バイナリを閲覧
NeoBundle 'rhysd/committia.vim'     " commitメッセージ表示をステキに
NeoBundle 'tpope/vim-speeddating'   " 年月日に加算できる
NeoBundle 'tomtom/tcomment_vim'     " 他のも試したけどダメだった
NeoBundle 'kannokanno/previm'       " Markdown Previewer
NeoBundleLazy 'osyo-manga/vim-stargate', { 'autoload' : {'filetypes' : ['c', 'cpp'] } }
NeoBundle 'comeonly/php.vim-html-enhanced' " php,htmlのindentをきれいに
NeoBundle 'tpope/vim-fugitive'      " git
" NeoBundle 'airblade/vim-gitgutter'  " gitのdiffを行に表示
NeoBundle 'LeafCage/foldCC.vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'mattn/excitetranslate-vim'
NeoBundle 'inotom/str2htmlentity'   " rangeをHTMLの実体参照に相互変換

" Library used in vimrc
NeoBundle 'vim-jp/vital.vim'
NeoBundle 'osyo-manga/vital-reunions'
NeoBundle 'osyo-manga/vital-over'
NeoBundle 'osyo-manga/vital-unlocker'

" #rails and #ruby"{{{
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'         " Modelを表示したりできる
NeoBundle 'basyura/unite-rails'     " Unite上にrailsの情報を表示する
" NeoBundle 'bbatsov/rubocop'
" NeoBundle 'todesking/ruby_hl_lvar.vim' "うまく動作しなかった
"}}}

" #tab and #ref "{{{
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'
NeoBundle 'szw/vim-tags'
NeoBundleLazy 'alpaca-tc/alpaca_tags', {
      \ 'depends': ['Shougo/vimproc.vim'],
      \ 'autoload' : {
      \    'commands' : [
      \       { 'name' : 'AlpacaTagsBundle', 'complete': 'customlist,alpaca_tags#complete_source' },
      \       { 'name' : 'AlpacaTagsUpdate', 'complete': 'customlist,alpaca_tags#complete_source' },
      \       'AlpacaTagsSet', 'AlpacaTagsCleanCache', 'AlpacaTagsEnable', 'AlpacaTagsDisable', 'AlpacaTagsKillProcess', 'AlpacaTagsProcessStatus',
      \    ],
      \ }
      \ }
"}}}

" #operator "{{{
NeoBundle 'kana/vim-operator-user'
NeoBundle 'tyru/operator-html-escape.vim',     { 'depends' : 'kana/vim-operator-user'           }
NeoBundle 'osyo-manga/vim-operator-blockwise', { 'depends' : 'osyo-manga/vim-textobj-blockwise' }
NeoBundle 'osyo-manga/vim-operator-block',     { 'depends' : 'kana/vim-textobj-user'            }
NeoBundle 'rhysd/vim-operator-evalruby'       " 選択したtextobjをRubyの式として評価する
NeoBundle 'emonkak/vim-operator-comment'
NeoBundle 'emonkak/vim-operator-sort'
NeoBundle 'rhysd/vim-operator-surround'
" NoeBundle 'tyru/operator-camelize.vim'  " CamelCaseとsnake_caseを相互変換
"}}}

" #textobj "{{{
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-entire',   { 'depends' : 'kana/vim-textobj-user' }
NeoBundle 'kana/vim-textobj-function', { 'depends' : 'kana/vim-textobj-user' }
NeoBundle 'kana/vim-textobj-indent',   { 'depends' : 'kana/vim-textobj-user' }
NeoBundle 'rhysd/vim-textobj-ruby',    { 'depends' : 'kana/vim-textobj-user' } " arr brr Ruby のブロック
NeoBundle 'osyo-manga/vim-textobj-multiblock',   { 'depends': 'kana/vim-textobj-user' } " sb なんらかの括弧
NeoBundle 'osyo-manga/vim-textobj-multitextobj', { 'depends': 'kana/vim-textobj-user' }
NeoBundle 'osyo-manga/vim-textobj-blockwise',    { 'depends': 'kana/vim-textobj-user' }

NeoBundle 'kana/vim-textobj-syntax'           " ay iy
NeoBundle 'kana/vim-textobj-fold'             " az iz
" NeoBundle 'kana/vim-textobj-line'   " al il
NeoBundle 'thinca/vim-textobj-between'        " af if 任意の区切り文字
NeoBundle 'thinca/vim-textobj-comment'        "ac ic コメント
NeoBundle 'gilligan/textobj-lastpaste'        "ip 直前に変更またはヤンクされたテキスト

" NeoBundle 'thinca/vim-textobj-function-javascript'  " af if JavaScript の関数内
" NeoBundle 'thinca/vim-textobj-function-perl'  " af if Perl の関数内
NeoBundle 'saihoooooooo/vim-textobj-space'    " aS iS 連続したスペース
NeoBundle 'rhysd/vim-textobj-lastinserted'    " au iu textobjとして最後に挿入された範囲
" NeoBundle 'h1mesuke/textobj-wiw'    " a,w, i,w snake_case 上のword  ,がリマップされる
" NeoBundle 'sgur/vim-textobj-parameter'  " a i 関数の引数
NeoBundle 'akiyan/vim-textobj-xml-attribute'  " axa ixa XML の属性
NeoBundle 'anyakichi/vim-textobj-xbrackets'   " axb ixb x() や x<> など
NeoBundle 'hchbaw/textobj-motionmotion.vim'   " am im 任意の2つの motion の間
NeoBundle 'osyo-manga/vim-textobj-context'    " icx 別のfiletype のコンテキスト

NeoBundle 'glts/vim-textobj-indblock'         " ao io インデントの空白行
NeoBundle 'deris/vim-textobj-enclosedsyntax'  " aq iq Perl や Ruby の正規表現
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

NeoBundleLazy 'kana/vim-smartinput'
NeoBundleLazy 'cohama/vim-smartinput-endwise', { 'depends' : [ 'kana/vim-smartinput' ] }
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

function! g:CR_mapping()
  if neosnippet#expandable()
    return neosnippet#mappings#_expand_target()
  else
    return neocomplete#close_popup()
  endif
endfunction

" neosnippet and neocomplete compatible
if neobundle#tap('vim-smartinput-endwise')
  function! neobundle#tapped.hooks.on_post_source(bundle)
    call smartinput#map_to_trigger('i', '<Plug>(vimrc_cr)', '<Enter>', '<Enter>')
    call s:define_rule_ruby()

    imap <silent><expr><CR> !pumvisible() ? "\<Plug>(vimrc_cr)" : g:CR_mapping() . '<CR>'
  endfunction
  call neobundle#untap()
endif
"}}}

call neobundle#end()
filetype plugin indent on " Required
"###################### plugin config ############################"

let g:netrw_nogx = 1                " 不要なkeymapを無効
let g:rsenseUseOmniFunc=1
let g:no_cecutil_maps=1             " AnsiEsc の中で変なマッピングをしないようにする
let g:solarized_termcolors=256      " solarizedをCUIで使うため
let g:vinarise_enable_auto_detect=1 " バイナリを検出して自動で開いてくれる?

command! -range Trans :<line1>,<line2>:ExciteTranslate


function! s:define_rule_ruby()
  let l:pattern = '\%(^\s*#.*\)\@<!do\s*\%(|.*|\)\?\s*\%#'
  call smartinput#define_rule({
        \ 'at' : l:pattern, 'char': '<CR>',
        \ 'input': '<CR>' .  'end' . '<Esc>O',
        \ 'filetype': ['ruby']
        \ })
endfunction

" #unite "{{{
command! Uscheme :Unite colorscheme -auto-preview
command! Umap :Unite output:map|map!|lmap

nnoremap [unite]   <Nop>
nmap ; [unite]
nnoremap [unite]m :Unite mark<CR>
nnoremap [unite]b :Unite buffer<CR>
nnoremap [unite]k :Unite bookmark<CR>
nnoremap [unite]f :Unite file -start-insert<CR>
nnoremap [unite]r :UniteResume

" unite-grep {{{
  let g:unite_source_grep_max_candidates = 200
  if executable('ag')
      " Use ag in unite grep source.
      let g:unite_source_grep_command = 'ag'
      let g:unite_source_grep_recursive_opt = 'HRn'
      let g:unite_source_grep_default_opts =
      \ '--line-numbers --nocolor --nogroup --hidden --ignore ' .
      \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  endif

  " unite-grepのキーマップ 選択した文字列をunite-grep
  vnoremap /g y:Unite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>
" }}}

"}}}

" #airline"{{{
  " https://github.com/bling/vim-airline/wiki/Screenshots
  let g:airline_powerline_fonts = 1
  let g:airline_theme           = "dark"
  let g:airline_left_sep        = ''
  let g:airline#extensions#tabline#enabled  = 1
  let g:airline#extensions#tabline#left_sep = ''
"}}}

" #indentLine
  nmap <silent>\i :<C-u>IndentLinesToggle<CR>
  let g:indentLine_faster = 1
  let g:indentLine_fileTypeExclude = ['help', 'calendar']

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

" #easymotion"{{{
"Todo: マップを整える
  " let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvb'
  let g:EasyMotion_leader_key=";"
  " let g:EasyMotion_grouping=1       " 1 ストローク選択を優先する
  " map <Space>j <Plug>(easymotion-j)
  " map <Space>k <Plug>(easymotion-k)
  " map <Space>w <Plug>(easymotion-w)
  " map <Space>f <Plug>(easymotion-fl)
  " map <Space>t <Plug>(easymotion-tl)
  " map <Space>F <Plug>(easymotion-Fl)
  " map <Space>T <Plug>(easymotion-Tl)
"}}}

" #surround "{{{
  " () {} はab aB で表す 他は記号
  " srのaは srab を srbとするため
  map <silent>sa <Plug>(operator-surround-append)
  map <silent>sd <Plug>(operator-surround-delete)
  map <silent>sr <Plug>(operator-surround-replace)a

  " if you use vim-textobj-multiblock
  nmap <silent>sdd <Plug>(operator-surround-delete)<Plug>(textobj-multiblock-a)
  nmap <silent>srr <Plug>(operator-surround-replace)<Plug>(textobj-multiblock-a)

  " if you use vim-textobj-between
  " nmap <silent>sdb <Plug>(operator-surround-delete)<Plug>(textobj-between-a)
  " nmap <silent>srb <Plug>(operator-surround-replace)<Plug>(textobj-between-a)

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

" #committa "{{{
  let g:committia_open_only_vim_starting = 1
  let g:committia_hooks = {}
  function! g:committia_hooks.edit_open(info)
    set nofoldenable
    set foldopen=all
    setlocal spell

    " If no commit message, start with insert mode
    " if a:info.vcs ==# 'git' && getline(1) ==# ''
    "     startinsert
    " end

    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
    goto 1
  endfunction
"}}}

RcSource 'easyalign'
RcSource 'switch'
RcSource 'vimfiler'
RcSource 'quickrun'

if s:meet_neocomplete_requirements()
  RcSource 'complete'
endif
if !exists('loaded_matchit') " rubyとかでdef~endの移動をしてくれる
  runtime macros/matchit.vim
endif
