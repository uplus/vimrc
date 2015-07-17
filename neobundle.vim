" NeoBundle:
" gs をkeymapのtoggleプレフィックスに割り当てる

if !isdirectory($HOME . '/.vim/bundle/neobundle.vim/')
  silent! !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
endif

if has('vim_starting')
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

NeoBundleLazy 'Shougo/vimshell.vim',  { 'commands' : ['VimShell'], 'depends' : [ 'Shougo/vimproc.vim'  ] }
NeoBundleLazy 'ujihisa/vimshell-ssh', { 'commands' : ['VimShell'], 'depends' : [ 'Shougo/vimshell.vim' ] }

" Unite: "{{{
NeoBundle     'Shougo/unite.vim'
NeoBundle     'Shougo/neomru.vim',                { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'Shougo/unite-build',               { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'Shougo/unite-help',                { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'Shougo/unite-outline',             { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'osyo-manga/unite-filetype',        { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'osyo-manga/unite-fold',            { 'depends' : [ 'Shougo/unite.vim' ] }
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
NeoBundle 'Shougo/vinarise'             " バイナリを閲覧
NeoBundle 'rhysd/committia.vim'         " commitメッセージ表示をステキに
NeoBundle 'powerman/vim-plugin-AnsiEsc' " カラー情報を反映して表示
" NeoBundle 'bronson/vim-trailing-whitespace' " 行末の半角スペースをハイライト
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
NeoBundle 'kana/vim-niceblock'
NeoBundle 't9md/vim-choosewin'
"}}}

" #search and #replace "{{{
NeoBundle 'osyo-manga/vim-anzu'      " show search point on the command-line
NeoBundle 'haya14busa/incsearch.vim' " サーチ時に全てをハイライト
NeoBundle 'haya14busa/vim-asterisk'  " Todo: これの設定をする
NeoBundle 'tpope/vim-abolish'
" NeoBundle 'osyo-manga/vim-over'     " タブ補完が効く置き換えモード
"}}}

" #move"{{{
NeoBundle 'bkad/CamelCaseMotion'      " textobjも持ってる ,w ,b ,e
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'kana/vim-smartword'
" NeoBundle 'deris/improvedft'        " ftFTで複数文字を入力できる
NeoBundle 'rhysd/clever-f.vim'      " ftFTで,;の動作をする
" NeoBundle 'deris/vim-shot-f'        " ftFTで一発で飛べる位置を表示する
"}}}

" #syntaxchecker"{{{
NeoBundle 'scrooloose/syntastic.git'
" NeoBundle 'osyo-manga/vim-watchdogs'
" NeoBundle 'dannyob/quickfixstatus'
" NeoBundle 'jceb/vim-hier'
"}}}

" #quickrun "{{{
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/shabadou.vim'   " 汎用的なquickrun-hook
"}}}

" vital Library used in vimrc "{{{
NeoBundle 'vim-jp/vital.vim'
NeoBundle 'osyo-manga/vital-reunions'
NeoBundle 'osyo-manga/vital-over'
NeoBundle 'osyo-manga/vital-unlocker'
"}}}

" #ruby"{{{
NeoBundleLazy 'vim-ruby/vim-ruby',   { 'filetypes' : ['ruby'] }
NeoBundleLazy 'tpope/vim-rails',     { 'filetypes' : ['ruby'] } " Modelを表示したりできる
NeoBundleLazy 'basyura/unite-rails', { 'filetypes' : ['ruby'] } " Unite上にrailsの情報を表示する
" NeoBundle 'bbatsov/rubocop'
" NeoBundle 'todesking/ruby_hl_lvar.vim' "うまく動作しなかった
"}}}

" #python
NeoBundleLazy 'hdima/python-syntax',  { 'filetypes' : ['python'] }
NeoBundleLazy 'jpythonfold.vim',      { 'filetypes' : ['python'] } " 折りたたみの設定
NeoBundleLazy 'davidhalter/jedi-vim', { 'filetypes' : ['python'] }

" #tag and #ref "{{{
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
" http://qiita.com/rbtnn/items/a47ed6684f1f0bc52906

" operatorをLazyにすると読み込まない
NeoBundle 'kana/vim-operator-user'
NeoBundle 'osyo-manga/vim-operator-blockwise', { 'depends' : 'osyo-manga/vim-textobj-blockwise' }
NeoBundle 'osyo-manga/vim-operator-block',     { 'depends' : 'kana/vim-operator-user' }
NeoBundle 'rhysd/vim-operator-surround',       { 'depends' : 'kana/vim-operator-user' }
NeoBundle 'rhysd/vim-operator-evalruby',       { 'depends' : 'kana/vim-operator-user' } " textobjをRubyの式として評価
NeoBundle 'rhysd/vim-clang-format',            { 'depends' : 'kana/vim-operator-user' }
NeoBundle 'emonkak/vim-operator-sort',         { 'depends' : 'kana/vim-operator-user' }
NeoBundle 'tyru/operator-html-escape.vim',     { 'depends' : 'kana/vim-operator-user' }
NeoBundle 'tyru/operator-camelize.vim',        { 'depends' : 'kana/vim-operator-user' } " CamelCaseとsnake_caseを相互変換
NeoBundle 'kana/vim-operator-replace',         { 'depends' : 'kana/vim-operator-user' }
NeoBundle 'thinca/vim-operator-sequence',      { 'depends' : 'kana/vim-operator-user' } " Do two ro more operators
" NeoBundle '',         { 'depends' : 'kana/vim-operator-user' }

" 任意のcmdを実行するoperator
NeoBundle 'osyo-manga/vim-operator-exec_command', { 'depends' : 'kana/vim-operator-user' }
"}}}

" #textobj "{{{
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-entire',   { 'depends' : 'kana/vim-textobj-user' } " e buffer全体
NeoBundle 'kana/vim-textobj-indent',   { 'depends' : 'kana/vim-textobj-user' } " l
NeoBundle 'kana/vim-textobj-syntax',   { 'depends' : 'kana/vim-textobj-user' } " y syntax-highlightされてる部分
NeoBundle 'kana/vim-textobj-fold',     { 'depends' : 'kana/vim-textobj-user' } " z
NeoBundle 'kana/vim-textobj-line',     { 'depends' : 'kana/vim-textobj-user' } " l -> L current-lineの行末を除いた
NeoBundle 'mattn/vim-textobj-url',     { 'depends' : 'kana/vim-textobj-user' } " u
NeoBundle 'h1mesuke/textobj-wiw',      { 'depends' : 'kana/vim-textobj-user' } " ,w  CamelCaseMotionと併用
NeoBundle 'thinca/vim-textobj-comment',          { 'depends' : 'kana/vim-textobj-user' } " c コメント
NeoBundle 'gilligan/textobj-lastpaste',          { 'depends' : 'kana/vim-textobj-user' } " p 最後にペーストしたtextobj
NeoBundle 'thinca/vim-textobj-between',          { 'depends' : 'kana/vim-textobj-user' } " f{char} 任意の区切り文字
NeoBundle 'osyo-manga/vim-textobj-multiblock',   { 'depends' : 'kana/vim-textobj-user' } " sb なんらかの括弧
NeoBundle 'osyo-manga/vim-textobj-blockwise',    { 'depends' : 'kana/vim-textobj-user' } " 連続したtextobjを矩形選択 ciw -> cIw
NeoBundle 'osyo-manga/vim-textobj-from_regexp',  { 'depends' : 'kana/vim-textobj-user' } " regexで自分でtextobjが作れる
NeoBundle 'deris/vim-textobj-enclosedsyntax',    { 'depends' : 'kana/vim-textobj-user' } " q 任意のsyntax /../ '..'

NeoBundle 'osyo-manga/vim-textobj-multitextobj', { 'depends' : 'kana/vim-textobj-user' } " 複数のtextobjを一つにまとめる
NeoBundle 'kana/vim-textobj-function', { 'depends' : 'kana/vim-textobj-user' } " f -> F に変更

" , { 'depends' : 'kana/vim-textobj-user' }
" t9md/vim-textobj-function-ruby
" NeoBundle 'akiyan/vim-textobj-xml-attribute'  " axa ixa XML の属性
" NeoBundle 'hchbaw/textobj-motionmotion.vim'   " am im 任意の2つの motion の間
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
" NeoBundle 'Colour-Sampler-Pack' " 大量のcolorschemeセット
"}}}

" #input-support "{{{
NeoBundle 'Shougo/neocomplete.vim'
" NeoBundle 'marcus/rsense' :helpが使えなくなる
NeoBundle 'NigoroJr/rsense'
NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', { 'depends' : ['Shougo/neocomplete']}
NeoBundleLazy 'Rip-Rip/clang_complete',        { 'filetypes' : ['c', 'cpp'] }
NeoBundleLazy 'kana/vim-smartinput',           { 'autoload' : { 'insert' : 1 }}
NeoBundleLazy 'cohama/vim-smartinput-endwise', { 'depends' : [ 'kana/vim-smartinput' ] }
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets', { 'depends' : [ 'Shougo/neosnippet.vim' ] }
"}}}

" #other "{{{
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tyru/caw.vim'

NeoBundle 'Shougo/context_filetype.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'kannokanno/previm'       " Markdown Previewer
NeoBundle 'comeonly/php.vim-html-enhanced' " php,htmlのindentをきれいに
NeoBundle 'osyo-manga/vim-jplus'    " 任意の文字で行を結合する
" NeoBundle 'tpope/vim-fugitive'      " git
" NeoBundle 'airblade/vim-gitgutter'  " gitのdiffを行に表示
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/excitetranslate-vim'
NeoBundleLazy 'tyru/open-browser.vim', { 'autoload' : {
      \     'commands' : [ 'OpenBrowser', 'OpenBrowserSearch', 'OpenBrowserSmartSearch' ],
      \     'function_prefix' : 'openbrowser',
      \   }  }
NeoBundle 'tyru/open-browser-github.vim', { 'depends' : ['tyru/open-browser.vim'] }

NeoBundle 'inotom/str2htmlentity'   " rangeをHTMLの実体参照に相互変換
" NeoBundle 'itchyny/screensaver.vim'
NeoBundleLazy 'matchit.zip', { 'mappings' : ['%', 'g%'] }
NeoBundle 'vimtaku/hl_matchit.vim'
NeoBundle 't9md/vim-quickhl'
NeoBundleLazy 'osyo-manga/vim-stargate', { 'autoload' : {'filetypes' : ['c', 'cpp'] }}
NeoBundleLazy 'Shougo/echodoc',           { 'autoload' : { 'insert' : 1 }}

"}}}

"###################### plugin config ############################"
let g:netrw_nogx=1             " 不要なkeymapを無効
let g:no_cecutil_maps=1        " AnsiEsc の中で変なマッピングをしないようにする
let g:solarized_termcolors=256 " solarizedをCUIで使うため
let python_highlight_all = 1
command! -range Trans :<line1>,<line2>:ExciteTranslate

" vim-operator taps "{{{
if neobundle#tap('vim-operator-user')

  call neobundle#untap()
endif

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

 "}}}

" vim-textobj taps "{{{
if neobundle#tap('vim-textobj-user')
  " let g:textobj_enclosedsyntax_no_default_key_mappings = 1
  call neobundle#untap()
endif

if neobundle#tap('vim-textobj-indent') "{{{
  vmap il <Plug>(textobj-indent-i)
  vmap al <Plug>(textobj-indent-a)
  omap il <Plug>(textobj-indent-i)
  omap al <Plug>(textobj-indent-a)
  call neobundle#untap()
endif "}}}

if neobundle#tap('h1mesuke/textobj-wiw') "{{{
  " bkad/CamelCaseMotionと組み合わせれば意図した通りに動く
  let g:textobj_wiw_no_default_key_mappings = 1
  omap a,w <Plug>(textobj-wiw-a)
  omap i,w <Plug>(textobj-wiw-i)
  xmap a,w <Plug>(textobj-wiw-a)
  xmap i,w <Plug>(textobj-wiw-i)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-textobj-line') "{{{
  let g:textobj_line_no_default_key_mappings = 1
  omap aL <Plug>(textobj-line-a)
  omap iL <Plug>(textobj-line-i)

  " whitout <Space> <CR>...
  nmap yY y<Plug>(textobj-line-i)
  nmap dD y<Plug>(textobj-line-i)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-textobj-function') "{{{
  let g:textobj_function_no_default_key_mappings = 1
  omap iF <Plug>(textobj-function-i)
  omap aF <Plug>(textobj-function-a)
  vmap iF <Plug>(textobj-function-i)
  vmap aF <Plug>(textobj-function-a)

  " I A でvisual-blockの挿入ができない
  " omap IF <Plug>(textobj-function-I)
  " omap AF <Plug>(textobj-function-A)
  " vmap IF <Plug>(textobj-function-I)
  " vmap AF <Plug>(textobj-function-A)
  "
  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-textobj-multiblock') "{{{
  " omap ib <Plug>(textobj-multiblock-i)
  " omap ab <Plug>(textobj-multiblock-a)
  " vmap ib <Plug>(textobj-multiblock-i)
  " vmap ab <Plug>(textobj-multiblock-a)

let g:textobj_multiblock_search_limit = 20
let g:textobj_multiblock_blocks = [
      \   ['(', ')', 1],
      \   ['[', ']', 1],
      \   ['{', '}', 1],
      \   ['<', '>', 1],
      \   ['"', '"', 1],
      \   ["'", "'", 1],
      \   ['`', '`', 1],
      \   ['|', '|', 1],
      \ ]

  call neobundle#untap()
endif "}}}
"}}}

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
  let neobundle#hooks.on_source = '~/.vim/rc/complete.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('unite.vim') "{{{
  command! Uscheme :Unite colorscheme -auto-preview
  command! Umap :Unite output:map|map!|lmap

  let g:unite_enable_start_insert = 0

  nnoremap [unite] <Nop>
  xnoremap [unite] <Nop>
  nmap ;u [unite]
  xmap ;u [unite]

  " Todo: auto-resize
  nnoremap <silent><Space>m :<C-U>Unite mark -auto-resize<CR>
  nnoremap <silent><Space>b :<C-U>Unite buffer -auto-resize<CR>
  nnoremap <silent><Space>t :<C-u>Unite tab -auto-resize -select=`tabpagenr()-1` <CR>
  nnoremap <silent><Space>a :<C-U>Unite bookmark -auto-resize<CR>
  nnoremap <silent><Space>f :<C-U>Unite file -auto-resize -start-insert<CR>
  nnoremap <silent><Space>o :<C-U>Unite outline -auto-resize -no-start-insert -resume<CR>
  nnoremap <silent><Space>r :<C-U>UniteResume<CR>

  " grep {{{
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

  " search "{{{
  " nnoremap <silent> / :<C-u>Unite -buffer-name=search%`bufnr('%')` -start-insert line:forward:wrap<CR>
  " nnoremap <silent> ? :<C-u>Unite -buffer-name=search%`bufnr('%')` -start-insert line:backward<CR>
  " nnoremap <silent> * :<C-u>UniteWithCursorWord -buffer-name=search%`bufnr('%')` line:forward:wrap<CR>
  " nnoremap [Alt]/       /
  " nnoremap [Alt]?       ?

  " nnoremap <silent> n
  "       \ :<C-u>UniteResume search%`bufnr('%')`
  "       \  -no-start-insert -force-redraw<CR>
  "}}}

  function! neobundle#tapped.hooks.on_post_source(bundle)
    call unite#custom#default_action("source/vimpatches/*", "openbuf")
  endfunction

  " alias {{{
  " For unite-alias.
  let g:unite_source_alias_aliases = {}
  let g:unite_source_alias_aliases.test = {
        \ 'source' : 'file_rec',
        \ 'args'   : '~/',
        \ }
  let g:unite_source_alias_aliases.line_migemo = 'line'
  let g:unite_source_alias_aliases.calc = 'kawaii-calc'
  let g:unite_source_alias_aliases.l = 'launcher'
  let g:unite_source_alias_aliases.kill = 'process'
  let g:unite_source_alias_aliases.message = {
        \ 'source' : 'output',
        \ 'args'   : 'message',
        \ }
  let g:unite_source_alias_aliases.mes = {
        \ 'source' : 'output',
        \ 'args'   : 'message',
        \ }
  let g:unite_source_alias_aliases.scriptnames = {
        \ 'source' : 'output',
        \ 'args'   : 'scriptnames',
        \ }
  "}}}

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
    imap <buffer><C-e> <Plug>(committia-scroll-diff-up-half)
    imap <buffer><C-y> <Plug>(committia-scroll-diff-down-half)
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
  " 検索で <C-r>が使えなくなる
  " cmap <C-r> <Plug>(yankround-insert-register)
  " cmap <C-y> <Plug>(yankround-pop)

  let g:yankround_use_region_hl = 1
  let g:yankround_dir = "~/.vim/tmp/"
  au uAutoCmd ColorScheme * highlight YankRoundRegion cterm=italic

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-easymotion') "{{{
  let g:EasyMotion_keys             = 'asdghklqwertyuiopzxcvbnmfj'
  let g:EasyMotion_use_upper        = 0
  let g:EasyMotion_leader_key       = ';'
  let g:EasyMotion_enter_jump_first = 1 " Enter jump to first match
  let g:EasyMotion_space_jump_first = 0 " Space jump to first match
  let g:EasyMotion_smartcase        = 1

  map <Space>j <Plug>(easymotion-j)
  map <Space>k <Plug>(easymotion-k)
  map ;j <Plug>(easymotion-sol-j)
  map ;k <Plug>(easymotion-sol-k)

  " On the current-line f F t and T
  map ;f <Plug>(easymotion-fl)
  map ;F <Plug>(easymotion-Fl)
  map ;t <Plug>(easymotion-tl)
  map ;T <Plug>(easymotion-Tl)

  " On the current line
  map ;l <Plug>(easymotion-bd-fl)
  map ;L <Plug>(easymotion-bd-tl)

  " 2 chars motion
  map ;s <Plug>(easymotion-s2)
  map ;x <Plug>(easymotion-s)

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
  let g:airline#extensions#tabline#show_tab_nr = 1
  let g:airline#extensions#tabline#left_sep = ''

  " Todo:
  " タブに表示する名前（fnamemodifyの第二引数）
  let g:airline#extensions#tabline#fnamemod = ':t'
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

if neobundle#tap('hl_matchit.vim') "{{{
  let g:hl_matchit_enable_on_vim_startup = 1
  let g:hl_matchit_hl_groupname = 'Title'
  let g:hl_matchit_allow_ft     = 'html,vim,zsh,sh' " ruby上手くいかない
  let g:hl_matchit_cursor_wait  = 0.10              " 更新頻度
  let g:hl_matchit_hl_groupname = 'HlMatchit'
  au uAutoCmd ColorScheme * hi HlMatchit cterm=bold,underline

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

if neobundle#tap('vim-asterisk') "{{{
  " let g:asterisk#keeppos = 1
  call neobundle#untap()
endif "}}}

if neobundle#tap('incsearch.vim') " {{{
  au uAutoCmd ColorScheme * hi IncSearch term=NONE ctermfg=39 ctermbg=56
  au uAutoCmd ColorScheme * hi Search    term=NONE ctermbg=18 ctermfg=75

  let g:incsearch#no_inc_hlsearch                   = 0    " 他のwindowではハイライトしない
  let g:incsearch#auto_nohlsearch                   = 1    " 自動でハイライトを消す
  let g:incsearch#consistent_n_direction            = 0    " 1:nで常にforwardに移動
  let g:incsearch#do_not_save_error_message_history = 1
  let g:incsearch#magic                             = '\v' " very magic

  map g/ <Plug>(incsearch-stay)
  map / <Plug>(incsearch-forward)
  map ? <Plug>(incsearch-backward)

  map * <Plug>(incsearch-nohl)<Plug>(anzu-star)
  map # <Plug>(incsearch-nohl)<Plug>(anzu-sharp)
  map g* <Plug>(incsearch-nohl)<Plug>(asterisk-g*)<Plug>(anzu-update-search-status-with-echo)
  map g# <Plug>(incsearch-nohl)<Plug>(asterisk-g#)<Plug>(anzu-update-search-status-with-echo)

  map z* <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)<Plug>(anzu-update-search-status-with-echo)
  map z# <Plug>(incsearch-nohl0)<Plug>(asterisk-z#)<Plug>(anzu-update-search-status-with-echo)
  map gz* <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)<Plug>(anzu-update-search-status-with-echo)
  map gz# <Plug>(incsearch-nohl0)<Plug>(asterisk-gz#)<Plug>(anzu-update-search-status-with-echo)

  map  n <Plug>(incsearch-nohl-n)
  map  N <Plug>(incsearch-nohl-N)
  nmap n <Plug>(incsearch-nohl)<Plug>(anzu-n)zzzv
  nmap N <Plug>(incsearch-nohl)<Plug>(anzu-N)zzzv

  " g系は選択範囲を検索 zはstay asteriskはsmartcaseで*検索する
  " nohlとnohl0の違いはたぶんCursorMovedがあるかないか
  " map *   <Plug>(incsearch-nohl)<Plug>(asterisk-*)
  " map #   <Plug>(incsearch-nohl)<Plug>(asterisk-#)
  call neobundle#untap()
endif "}}}

if neobundle#tap('caw.vim') "{{{
  let g:caw_no_default_keymappings = 1
  xmap gc <Plug>(caw:i:toggle)

  call neobundle#untap()
endif "}}}

if neobundle#tap('nerdcommenter') "{{{
  let g:NERDCreateDefaultMappings = 0
  let g:NERDSpaceDelims = 1

  " 上下で反転させるならこれが必要
  nmap gcj 2<Plug>NERDCommenterInvert
  nmap gck k2<Plug>NERDCommenterInvertj

  " line-toggleはこっちのじゃないと先頭に数字指定できない
  " foldをまとめてtoggleするため
  nmap gcc v<Plug>NERDCommenterToggle
  nmap gyy <Plug>NERDCommenterYank

  " Aじゃないとmotionのaが使えない
  nmap gcA <Plug>NERDCommenterAppend
  xmap gy <Plug>NERDCommenterYank

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-operator-exec_command') && neobundle#tap('nerdcommenter') && neobundle#tap('caw.vim') "{{{
  nmap <silent><expr> <Plug>(operator-comment-toggle)
        \ operator#exec_command#mapexpr_v_keymapping("\<Plug>(caw:i:toggle)")

  "NERDCommenterの方だとコメントアウトしても #が揃わない
  nmap <silent><expr> <Plug>(operator-comment-yank-toggle)
        \ operator#exec_command#mapexpr_v_keymapping("\<Plug>NERDCommenterYank")

  nmap gc <Plug>(operator-comment-toggle)
  nmap gy <Plug>(operator-comment-yank-toggle)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-anzu') " {{{
  " let g:anzu_enable_CursorHold_AnzuUpdateSearchStatus = 1
  " Treat folding well
  " nnoremap <expr> n anzu#mode#mapexpr('n', '', 'zzzv')
  " nnoremap <expr> N anzu#mode#mapexpr('N', '', 'zzzv')

  " clear status
  " nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
endif " }}}

if neobundle#tap('vim-over') "{{{
  let g:over#command_line#enable_move_cursor = 1
  let g:over_command_line_prompt = "> "
  " let g:over_enable_auto_nohlsearch = 1
  " let g:over_enable_cmd_window = 1
  " let g:over#command_line#search#enable_incsearch = 1
  " let g:over#command_line#search#enable_move_cursor = 1


  call neobundle#untap()
endif "}}}

if neobundle#tap('rhysd/clever-f.vim') "{{{
  let g:clever_f_across_no_line    = 0
  let g:clever_f_ignore_case       = 0
  let g:clever_f_smart_case        = 0
  let g:clever_f_fix_key_direction = 0 " 1だとどんな時でもfで後ろにFで前に移動する
  let g:clever_f_show_prompt       = 1

  "Todo: 設定135までよんだ
  " f<CR> で前回のf検索を繰り返せる
  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-jplus') "{{{
  " 行継続文字などを消して結合
  nmap J <Plug>(jplus)
  xmap J <Plug>(jplus)

  " 任意の1文字を入力して結合を行う
  nmap g<Space>J <Plug>(jplus-getchar)
  xmap g<Space>J <Plug>(jplus-getchar)

  " 複数文字を入力したい場合は <Plug>(jplus-input) を使用する
  " nmap g<Space>J <Plug>(jplus-input)
  " vmap g<Space>J <Plug>(jplus-input)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-quickhl') "{{{
  let g:quickhl_manual_enable_at_startup = 1
  let g:quickhl_cword_enable_at_startup  = 0
  let g:quickhl_tag_enable_at_startup    = 0
  let g:quickhl_manual_keywords          = [] " Can use List and Dictionary

  nmap gh <Plug>(quickhl-manual-this)
  xmap gh <Plug>(quickhl-manual-this)
  nmap gsm <Plug>(quickhl-manual-reset)
  xmap gsm  <Plug>(quickhl-manual-reset)
  nmap gsc <Plug>(quickhl-cword-toggle)
  " nmap <Plug>(quickhl-tag-toggle)
  " map  <Plug>(operator-quickhl-manual-this-motion)

  let g:quickhl_manual_colors = [
        \ 'gui=bold ctermfg=16  ctermbg=153 guifg=#ffffff guibg=#0a7383',
        \ 'gui=bold ctermfg=0   ctermbg=1   guibg=#a07040 guifg=#ffffff',
        \ 'gui=bold ctermfg=0   ctermbg=2   guibg=#4070a0 guifg=#ffffff',
        \ 'gui=bold ctermfg=0   ctermbg=3   guibg=#40a070 guifg=#ffffff',
        \ 'gui=bold ctermfg=0   ctermbg=4   guibg=#70a040 guifg=#ffffff',
        \ 'gui=bold ctermfg=0   ctermbg=5   guibg=#0070e0 guifg=#ffffff',
        \ 'gui=bold ctermfg=0   ctermbg=6   guibg=#007020 guifg=#ffffff',
        \ 'gui=bold ctermfg=0   ctermbg=21  guibg=#d4a00d guifg=#ffffff',
        \ 'gui=bold ctermfg=0   ctermbg=22  guibg=#06287e guifg=#ffffff',
        \ 'gui=bold ctermfg=0   ctermbg=45  guibg=#5b3674 guifg=#ffffff',
        \ 'gui=bold ctermfg=0   ctermbg=16  guibg=#4c8f2f guifg=#ffffff',
        \ 'gui=bold ctermfg=0   ctermbg=50  guibg=#1060a0 guifg=#ffffff',
        \ 'gui=bold ctermfg=0   ctermbg=56  guibg=#a0b0c0 guifg=black']

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-niceblock') "{{{
  xmap I  <Plug>(niceblock-I)
  xmap A  <Plug>(niceblock-A)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-choosewin') "{{{
  nmap g<C-w>  <Plug>(choosewin)
  let g:choosewin_overlay_enable          = 1
  let g:choosewin_overlay_clear_multibyte = 1
  let g:choosewin_blink_on_land           = 0 " 頼むから着地時にカーソル点滅をさせないでくれ！
  " let g:choosewin_statusline_replace      = 0 " どうかステータスラインリプレイスしないで下さい!
  " let g:choosewin_tabline_replace         = 0 " どうかタブラインもリプレイスしないでいただきたい！

  call neobundle#untap()
endif "}}}

if neobundle#tap('jedi-vim') "{{{
  autocmd uAutoCmd FileType python setlocal omnifunc=jedi#completions
  let g:jedi#completions_enabled    = 0
  let g:jedi#auto_vim_configuration = 0

  call neobundle#untap()
endif "}}}

if neobundle#tap('open-browser.vim') "{{{
  " nmap gs <Plug>(open-browser-wwwsearch)

  function! neobundle#hooks.on_source(bundle)
    command Wsearch :call <SID>www_search()
    nnoremap <Plug>(open-browser-wwwsearch) :<C-u>call <SID>www_search()<CR>
    function! s:www_search()
      let l:search_word = input('Please input search word: ')
      if l:search_word != ''
        execute 'OpenBrowserSearch' escape(l:search_word, '"')
      endif
    endfunction
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('echodoc.vim') "{{{
  let g:echodoc_enable_at_startup = 1

  call neobundle#untap()
endif "}}}

" if neobundle#tap('') "{{{
"
"   call neobundle#untap()
" endif "}}}

call neobundle#end()
