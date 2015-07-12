" Neobundle:

if !isdirectory($HOME . '/.vim/bundle/neobundle.vim/')
  silent! !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
endif

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


" Unite: "{{{
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
NeoBundleLazy 'Kocha/vim-unite-tig' ,             { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'thinca/vim-unite-history',         { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'ujihisa/unite-colorscheme',        { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'ujihisa/unite-locate',             { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'zhaocai/unite-scriptnames',        { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'bundai223/unite-picktodo',         { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'kannokanno/unite-todo',            { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'mattn/unite-remotefile',           { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'supermomonga/unite-goimport.vim',  { 'depends' : [ 'Shougo/unite.vim', 'fatih/vim-go' ] }

"}}}

" View: "{{{
NeoBundle 'Shougo/vinarise'         " バイナリを閲覧
NeoBundle 'rhysd/committia.vim'     " commitメッセージ表示をステキに
NeoBundle 'powerman/vim-plugin-AnsiEsc'     " カラー情報を反映して表示
NeoBundle 'bronson/vim-trailing-whitespace' " 行末の半角スペースをハイライト
" NeoBundle 'itchyny/lightline.vim'
NeoBundle 'bling/vim-airline'
" NeoBundle 'Yggdroot/indentLine'
"}}}

" Action: "{{{
NeoBundle 'AndrewRadev/linediff.vim' " visual-modeで選択した2つの行をvimdiffで確認する
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'tpope/vim-unimpaired'     " :cnextとかのマッピングを提供 [p ]q ぐちゃくちゃ多すぎる
NeoBundle 'LeafCage/yankround.vim'   " round the yank history
NeoBundle 'kana/vim-submode'         " vimに独自のモードを作成
" NeoBundle 'tyru/vim-altercmd'       " :wとかの元からあるコマンドを書き換え
NeoBundle 'tpope/vim-repeat'
" NeoBundle 'kana/vim-repeat'
NeoBundle 'AndrewRadev/switch.vim'   " ifとunlessを入れ替えたり
NeoBundle 'tpope/vim-speeddating'    " 年月日に加算できる
NeoBundle 'LeafCage/foldCC.vim'
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
NeoBundle 'scrooloose/syntastic.git'
" NeoBundle 'osyo-manga/vim-watchdogs'
" NeoBundle 'dannyob/quickfixstatus'
" NeoBundle 'jceb/vim-hier'
" NeoBundle 'Shougo/echodoc'
"}}}

" Quickrun: "{{{
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/shabadou.vim'   " 汎用的なquickrun-hook
"}}}

NeoBundle 'Shougo/context_filetype.vim'
" NeoBundle 'osyo-manga/vim-jplus'    " 任意の文字で行を結合する
NeoBundle 'Shougo/vimfiler.vim'     " Lazy にするとデフォルトのブラウザにできない
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'kannokanno/previm'       " Markdown Previewer
NeoBundle 'comeonly/php.vim-html-enhanced' " php,htmlのindentをきれいに
NeoBundle 'tpope/vim-fugitive'      " git
" NeoBundle 'airblade/vim-gitgutter'  " gitのdiffを行に表示
NeoBundle 'mattn/webapi-vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'mattn/excitetranslate-vim'
NeoBundle 'inotom/str2htmlentity'   " rangeをHTMLの実体参照に相互変換
NeoBundleLazy 'matchit.zip', { 'mappings' : ['nxo', '%', 'g%'] }
NeoBundleLazy 'osyo-manga/vim-stargate', { 'autoload' : {'filetypes' : ['c', 'cpp'] } }

" vital Library used in vimrc
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
NeoBundle 'Shougo/neocomplete'
" NeoBundle 'marcus/rsense' :helpが使えなくなる
NeoBundle 'NigoroJr/rsense'
NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', { 'depends' : ['Shougo/neocomplete']}

NeoBundleLazy 'kana/vim-smartinput', { 'autoload' : { 'insert' : 1 }}
NeoBundleLazy 'cohama/vim-smartinput-endwise', { 'depends' : [ 'kana/vim-smartinput' ] }
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Rip-Rip/clang_complete'
"}}}

"###################### plugin config ############################"
let g:netrw_nogx=1             " 不要なkeymapを無効
let g:no_cecutil_maps=1        " AnsiEsc の中で変なマッピングをしないようにする
let g:solarized_termcolors=256 " solarizedをCUIで使うため
command! -range Trans :<line1>,<line2>:ExciteTranslate


if neobundle#tap('vim-smartinput') "{{{
  function! neobundle#tapped.hooks.on_post_source(bundle)
    call smartinput_endwise#define_default_rules()
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-smartinput-endwise') "{{{
  function! neobundle#tapped.hooks.on_post_source(bundle)
    call smartinput#map_to_trigger('i', '<Plug>(vimrc_cr)', '<Enter>', '<Enter>')

    " ruby
    call smartinput#define_rule({
          \ 'at' : '\%(^\s*#.*\)\@<!do\s*\%(|.*|\)\?\s*\%#', 'char': '<CR>',
          \ 'input': '<CR>' .  'end' . '<Esc>O',
          \ 'filetype': ['ruby']
          \ })

    " neosnippet and neocomplete compatible
    imap <expr><CR> !pumvisible() ? "\<Plug>(vimrc_cr)" :
          \ neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" :
          \ neocomplete#close_popup()
  endfunction
  call neobundle#untap()
endif "}}}

if neobundle#tap('neocomplete.vim') && has('lua') "{{{
  let g:rsenseUseOmniFunc=1
  let g:neocomplete#enable_at_startup = 1
  " let neobundle#hooks.on_source = '~/.vim/rc/complete.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('unite.vim') "{{{
  command! Uscheme :Unite colorscheme -auto-preview
  command! Umap :Unite output:map|map!|lmap

  nnoremap [unite] <Nop>
  xnoremap [unite] <Nop>
  nmap ;u [unite]
  xmap ;u [unite]

  nnoremap <silent><Space>m :<C-U>Unite mark<CR>
  nnoremap <silent><Space>b :<C-U>Unite buffer -auto-resize<CR>
  nnoremap <silent><Space>t :<C-u>Unite tab -auto-resize -select=`tabpagenr()-1` <CR>
  nnoremap <silent><Space>k :<C-U>Unite bookmark<CR>
  nnoremap <silent><Space>f :<C-U>Unite file -start-insert<CR>
  nnoremap <silent><Space>o :<C-U>Unite outline -auto-resize -no-start-insert -resume<CR>
  nnoremap <silent><Space>r :<C-U>UniteResume<CR>

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

  call neobundle#untap()
endif "}}}

if neobundle#tap('vinarise.vim') "{{{
  let g:vinarise_enable_auto_detect = 1

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-quickrun') "{{{
  let neobundle#hooks.on_source = '~/.vim/rc/quickrun.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('vimfiler.vim') "{{{
  let neobundle#hooks.on_source = '~/.vim/rc/vimfiler.rc.vim'
  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-easy-align') "{{{
  let neobundle#hooks.on_source = '~/.vim/rc/easyalign.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('syntastic') "{{{
  let g:syntastic_always_populate_loc_list = 1  " quickfixの表示を更新する
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq   = 0
  let g:syntastic_enable_signs  = 0
  " let g:syntastic_debug = 1

  let g:syntastic_cpp_compiler = 'clang++'
  let g:syntastic_cpp_compiler_options = $CPP_COMP_OPT
  let g:syntastic_ruby_mri_args = "-W1"

  call neobundle#untap()
endif "}}}

if neobundle#tap('committia.vim') "{{{
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

  call neobundle#untap()
endif "}}}

if neobundle#tap('yankround.vim') "{{{
	nmap p <Plug>(yankround-p)
	xmap p <Plug>(yankround-p)
	nmap P <Plug>(yankround-P)
	nmap gp <Plug>(yankround-gp)
	xmap gp <Plug>(yankround-gp)
	nmap gP <Plug>(yankround-gP)
	nmap <C-p> <Plug>(yankround-prev)
	nmap <C-n> <Plug>(yankround-next)

  " cmdlineで<C-y>押せばレジストリが遡れる
	cmap <C-r> <Plug>(yankround-insert-register)
	cmap <C-y> <Plug>(yankround-pop)

  let g:yankround_use_region_hl = 1
  let g:yankround_dir = "~/.vim/tmp/"
  highlight YankRoundRegion cterm=italic

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-operator-surround') "{{{
  " () {} はab aB で表す 他は記号
  " srのaは srab を srbとするため
  map <silent>sa <Plug>(operator-surround-append)
  map <silent>sd <Plug>(operator-surround-delete)
  map <silent>sr <Plug>(operator-surround-replace)a

  " if you use vim-textobj-multiblock
  nmap <silent>sdd <Plug>(operator-surround-delete)<Plug>(textobj-multiblock-a)
  nmap <silent>srr <Plug>(operator-surround-replace)<Plug>(textobj-multiblock-a)

  " if you use vim-textobj-between srbはsrabと被る
  " nmap <silent>sdb <Plug>(operator-surround-delete)<Plug>(textobj-between-a)
  " nmap <silent>srb <Plug>(operator-surround-replace)<Plug>(textobj-between-a)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-easymotion') "{{{
  "Todo: マップを整える
  let g:EasyMotion_leader_key=";"
  " let g:EasyMotion_grouping=1       " 1 ストローク選択を優先する
  " map <Space>j <Plug>(easymotion-j)
  " map <Space>k <Plug>(easymotion-k)

  call neobundle#untap()
endif "}}}

if neobundle#tap('switch.vim') "{{{
  let neobundle#hooks.on_source = '~/.vim/rc/switch.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-airline') "{{{
  " https://github.com/bling/vim-airline/wiki/Screenshots
  let g:airline_powerline_fonts = 1
  let g:airline_theme           = "dark"
  let g:airline_left_sep        = ''
  let g:airline#extensions#tabline#enabled  = 1
  let g:airline#extensions#tabline#left_sep = ''

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-textobj-user') "{{{
  omap ab <Plug>(textobj-multiblock-a)
  omap ib <Plug>(textobj-multiblock-i)
  xmap ab <Plug>(textobj-multiblock-a)
  xmap ib <Plug>(textobj-multiblock-i)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-submode') "{{{
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:submode_keep_leaving_key = 1
    " tab moving
    call submode#enter_with('changetab', 'n', '', 'gt', 'gt')
    call submode#enter_with('changetab', 'n', '', 'gT', 'gT')
    call submode#map('changetab', 'n', '', 't', 'gt')
    call submode#map('changetab', 'n', '', 'T', 'gT')
    " undo/redo
    call submode#enter_with('undo/redo', 'n', '', '<C-r>', '<C-r>')
    call submode#enter_with('undo/redo', 'n', '', 'u', 'u')
    call submode#map('undo/redo', 'n', '', '<C-r>', '<C-r>')
    call submode#map('undo/redo', 'n', '', 'u', 'u')
    " move between fold
    call submode#enter_with('movefold', 'n', '', 'zj', 'zjzMzvzz')
    call submode#enter_with('movefold', 'n', '', 'zk', 'zkzMzv[zzz')
    call submode#map('movefold', 'n', '', 'j', 'zjzMzvzz')
    call submode#map('movefold', 'n', '', 'k', 'zkzMzv[zzz')
    " resize window
    call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
    call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
    call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
    call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
    call submode#map('winsize', 'n', '', '>', '<C-w>>')
    call submode#map('winsize', 'n', '', '<', '<C-w><')
    call submode#map('winsize', 'n', '', '+', '<C-w>+')
    call submode#map('winsize', 'n', '', '-', '<C-w>-')
  endfunction
endif "}}}

if neobundle#tap('matchit.zip') "{{{
  function! neobundle#hooks.on_post_source(bundle)
    silent! execute 'doautocmd Filetype' &filetype
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('alpaca_tags') "{{{
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

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-speeddating') "{{{
  function! neobundle#hooks.on_post_source(bundle)
    SpeedDatingFormat! %v
    SpeedDatingFormat! %^v
  endfunction

  call neobundle#untap()
endif "}}}

" if neobundle#tap('') "{{{
"
"   call neobundle#untap()
" endif "}}}
"
" if neobundle#tap('') "{{{
"
"   call neobundle#untap()
" endif "}}}

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

call neobundle#end()
