" NeoBundle:

if !isdirectory($HOME . '/.vim/bundle/neobundle.vim/')
  silent! !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
endif

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))

" neobundle vimproc vimshell "{{{
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \   'mac'  : 'make -f make_mac.mak',
      \   'unix' : 'make -f make_unix.mak',
      \    }
      \ }

NeoBundleLazy 'Shougo/vimshell.vim',{
      \ 'depends' : 'Shougo/vimproc.vim',
      \ 'autoload' : {
      \   'commands' : [{ 'name' : 'VimShell',
      \                   'complete' : 'customlist,vimshell#complete'},
      \                 'VimShellExecute', 'VimShellInteractive',
      \                 'VimShellTerminal', 'VimShellPop'],
      \   'mappings' : '<Plug>',
      \ }}

NeoBundleLazy 'ujihisa/vimshell-ssh', { 'filetypes' : ['vimshell'] }
"}}}

" Unite: "{{{
NeoBundle     'Shougo/unite.vim'
NeoBundle     'Shougo/neomru.vim',                { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundleLazy 'Shougo/unite-build',               { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundleLazy 'ujihisa/unite-font',               { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundleLazy 'sgur/unite-qf',                    { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundleLazy 'Shougo/unite-help',                { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'Shougo/unite-outline',             { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'osyo-manga/unite-filetype',        { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'osyo-manga/unite-fold',            { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundle     'osyo-manga/unite-highlight',       { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundle     'osyo-manga/unite-quickfix',        { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'osyo-manga/unite-quickrun_config', { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundleLazy 'osyo-manga/unite-vimpatches',      { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundleLazy 'osyo-manga/unite-vital-module',    { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'osyo-manga/unite-vimmer',          { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundleLazy 'osyo-manga/unite-boost-online-doc',{ 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundleLazy 'osyo-manga/unite-vim_hacks',       { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'rhysd/unite-ruby-require.vim',     { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'tacroe/unite-alias',               { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'tacroe/unite-mark',                { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'taka84u9/unite-git',               { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundleLazy 'Kocha/vim-unite-tig' ,             { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'thinca/vim-unite-history',         { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'ujihisa/unite-colorscheme',        { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'pasela/unite-webcolorname',        { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundleLazy 'ujihisa/unite-locate',             { 'depends' : [ 'Shougo/unite.vim' ] }
NeoBundleLazy 'basyura/unite-rails',              { 'depends' : [ 'Shougo/unite.vim' ], 'filetypes' : ['ruby'] }
" NeoBundleLazy 'mattn/unite-remotefile',           { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundleLazy 'supermomonga/unite-goimport.vim',  { 'depends' : [ 'Shougo/unite.vim', 'fatih/vim-go' ] }
NeoBundleLazy 'osyo-manga/unite-airline_themes',  { 'depends' : [ 'Shougo/unite.vim', 'fatih/vim-go' ] }
"}}}

" View: "{{{
NeoBundle 'Shougo/vinarise'
NeoBundle 'rhysd/committia.vim'
NeoBundle 'kannokanno/previm' " Markdown Previewer
NeoBundle 'powerman/vim-plugin-AnsiEsc'
NeoBundle 'bling/vim-airline'
" NeoBundle 'bronson/vim-trailing-whitespace'
" NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Yggdroot/indentLine'
"}}}

" Action: "{{{
NeoBundle 'AndrewRadev/linediff.vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'tyru/nextfile.vim'
" NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'u10e10/yankround.vim'
NeoBundle 'kana/vim-submode'
NeoBundle 'tyru/vim-altercmd'
" NeoBundle 'tpope/vim-repeat'
NeoBundle 'kana/vim-repeat'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'LeafCage/foldCC.vim'
NeoBundle 'kana/vim-niceblock'
NeoBundle 'osyo-manga/vim-jplus'
NeoBundle 't9md/vim-choosewin'

NeoBundle 'bkad/CamelCaseMotion'    " has textobj ,w ,b ,e
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'kana/vim-smartword'
NeoBundle 'rhysd/clever-f.vim'      " ftFTで,;
" NeoBundle 'deris/improvedft'      " ftFT can input many charactores
" NeoBundle 'deris/vim-shot-f'      " ftFT show oneshot jump points
"}}}

" #search and #replace "{{{
NeoBundle 'osyo-manga/vim-anzu'      " show search point on the command-line
NeoBundle 'haya14busa/incsearch.vim'
NeoBundle 'haya14busa/vim-asterisk'
NeoBundle 'tpope/vim-abolish'
" NeoBundle 'osyo-manga/vim-over'
NeoBundle 'osyo-manga/vim-hopping'
NeoBundle 'daisuzu/rainbowcyclone.vim'
NeoBundle 'rking/ag.vim'
NeoBundleLazy 'thinca/vim-qfreplace', { 'filetypes' : ['unite', 'quickfix'] } " quickfixの各行を編集、反映できる
"}}}

" #syntaxchecker"{{{
NeoBundle 'scrooloose/syntastic.git'
" NeoBundle 'osyo-manga/vim-watchdogs'
" NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'jceb/vim-hier'
"}}}

" #quickrun "{{{
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle "osyo-manga/quickrun-outputter-replace_region"
"}}}

" #vital "{{{
NeoBundle 'vim-jp/vital.vim'
NeoBundle 'osyo-manga/vital-reunions'
NeoBundle 'osyo-manga/vital-over'
NeoBundle 'osyo-manga/vital-unlocker'
"}}}

NeoBundle 'mbbill/undotree'
NeoBundle 'sjl/gundo.vim'

" #Ruby "{{{
NeoBundleLazy 'vim-ruby/vim-ruby',   { 'filetypes' : ['ruby'] }
NeoBundleLazy 'tpope/vim-rails',     { 'filetypes' : ['ruby'] } " Displey model,action...
" NeoBundle 'bbatsov/rubocop'
" NeoBundle 'todesking/ruby_hl_lvar.vim' "うまく動作しなかった
"}}}

" #Python "{{{
NeoBundleLazy 'hdima/python-syntax',  { 'filetypes' : ['python'] }
NeoBundleLazy 'jpythonfold.vim',      { 'filetypes' : ['python'] } " fold config of python
NeoBundleLazy 'davidhalter/jedi-vim', { 'filetypes' : ['python'] }
"}}}

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
NeoBundle 'osyo-manga/vim-operator-blockwise', { 'depends' : 'osyo-manga/vim-textobj-blockwise' } " I A 系
NeoBundle 'osyo-manga/vim-operator-block',     { 'depends' : 'kana/vim-operator-user' }
NeoBundle 'rhysd/vim-operator-surround',       { 'depends' : 'kana/vim-operator-user' } " sa sd sr
NeoBundle 'rhysd/vim-operator-evalruby',       { 'depends' : 'kana/vim-operator-user' } " se evaluate textobj as expression of lambda of ruby
NeoBundle 'rhysd/vim-clang-format',            { 'depends' : 'kana/vim-operator-user', 'filetypes' : ['c', 'cpp'] } " command only
" NeoBundle 'emonkak/vim-operator-sort',         { 'depends' : 'kana/vim-operator-user' }
NeoBundle 'tyru/operator-html-escape.vim',     { 'depends' : 'kana/vim-operator-user' }
NeoBundle 'tyru/operator-camelize.vim',        { 'depends' : 'kana/vim-operator-user' } " CamelCase <=> snake_case
NeoBundle 'kana/vim-operator-replace',         { 'depends' : 'kana/vim-operator-user' } " gr
NeoBundle 'thinca/vim-operator-sequence',      { 'depends' : 'kana/vim-operator-user' } " Execute two or more operators
NeoBundle 'osyo-manga/vim-operator-jump_side', { 'depends' : 'kana/vim-operator-user' }
" NeoBundle '',         { 'depends' : 'kana/vim-operator-user' }

" 任意のcmdを実行するoperator
NeoBundle 'osyo-manga/vim-operator-exec_command', { 'depends' : 'kana/vim-operator-user' }
"}}}

" #textobj "{{{
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-entire',   { 'depends' : 'kana/vim-textobj-user' } " e buffer
NeoBundle 'kana/vim-textobj-indent',   { 'depends' : 'kana/vim-textobj-user' } " l
NeoBundle 'kana/vim-textobj-syntax',   { 'depends' : 'kana/vim-textobj-user' } " y syntax-highlight
NeoBundle 'kana/vim-textobj-fold',     { 'depends' : 'kana/vim-textobj-user' } " z
NeoBundle 'kana/vim-textobj-line',     { 'depends' : 'kana/vim-textobj-user' } " l -> L ignore last-char of current-line
NeoBundle 'mattn/vim-textobj-url',     { 'depends' : 'kana/vim-textobj-user' } " u
NeoBundle 'h1mesuke/textobj-wiw',      { 'depends' : 'kana/vim-textobj-user' } " ,w  use it with CamelCaseMotion
NeoBundle 'thinca/vim-textobj-comment',          { 'depends' : 'kana/vim-textobj-user' } " c
NeoBundle 'gilligan/textobj-lastpaste',          { 'depends' : 'kana/vim-textobj-user' } " ip last pasted textobj. don't have ap
NeoBundle 'thinca/vim-textobj-between',          { 'depends' : 'kana/vim-textobj-user' } " f{char} select a range between character
NeoBundle 'osyo-manga/vim-textobj-multiblock',   { 'depends' : 'kana/vim-textobj-user' } " sb some block
NeoBundle 'osyo-manga/vim-textobj-blockwise',    { 'depends' : 'kana/vim-textobj-user' } " 連続したtextobjを矩形選択 ciw -> cIw
NeoBundle 'osyo-manga/vim-textobj-from_regexp',  { 'depends' : 'kana/vim-textobj-user' } " Can make textobj by regex
NeoBundle 'deris/vim-textobj-enclosedsyntax',    { 'depends' : 'kana/vim-textobj-user' } " q some syntax /../ '..'

NeoBundle 'osyo-manga/vim-textobj-multitextobj', { 'depends' : 'kana/vim-textobj-user' } " 複数のtextobjを一つにまとめる
NeoBundle 'kana/vim-textobj-function', { 'depends' : 'kana/vim-textobj-user' } " change keymap f -> F
" NeoBundle 't9md/vim-textobj-function-ruby', { 'depends' : 'kana/vim-textobj-user' }
" osyo-manga/vim-operator-swap

" , { 'depends' : 'kana/vim-textobj-user' }
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
NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', { 'depends' : ['Shougo/neocomplete.vim']}
NeoBundleLazy 'Rip-Rip/clang_complete',              { 'filetypes' : ['c', 'cpp'] }
NeoBundleLazy 'kana/vim-smartinput',                 { 'autoload' : { 'insert' : 1 }}
NeoBundleLazy 'cohama/vim-smartinput-endwise',       { 'depends' : [ 'kana/vim-smartinput' ] }
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets',              { 'depends' : [ 'Shougo/neosnippet.vim' ] }
"}}}

" #other "{{{
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tyru/caw.vim'
NeoBundle 'terryma/vim-expand-region'

NeoBundleLazy 'matchit.zip',    { 'mappings' : ['%', 'g%'] }
NeoBundle 'vimtaku/hl_matchit.vim'
NeoBundle 't9md/vim-quickhl'
NeoBundleLazy 'Shougo/echodoc', { 'autoload' : { 'insert' : 1 }}

NeoBundleLazy 'Shougo/vimfiler.vim', {
      \ 'depends' : 'Shougo/unite.vim',
      \ 'autoload' : {
      \    'commands' : [{ 'name' : 'VimFiler',
      \                    'complete' : 'customlist,vimfiler#complete' },
      \                  'VimFilerExplorer',
      \                  'Edit', 'Read', 'Source', 'Write'],
      \    'mappings' : '<Plug>',
      \    'explorer' : 1,
      \ }
      \ }
NeoBundle 'Shougo/context_filetype.vim'
NeoBundle 'comeonly/php.vim-html-enhanced' " php,htmlのindentをきれいに

" #git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'  " gitのdiffを行に表示
NeoBundle 'idanarye/vim-merginal'   " git log --graph
NeoBundle 'cohama/agit.vim'         " git log
NeoBundle 'AndrewRadev/gapply.vim'  " git add -p

NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/excitetranslate-vim'
NeoBundle 'mattn/wwwrenderer-vim'
NeoBundle 'thinca/vim-openbuf'
NeoBundleLazy 'tyru/open-browser.vim', { 'autoload' : {
      \     'commands' : [ 'OpenBrowser', 'OpenBrowserSearch', 'OpenBrowserSmartSearch' ],
      \     'function_prefix' : 'openbrowser',
      \   }  }
NeoBundle 'tyru/open-browser-github.vim', { 'depends' : ['tyru/open-browser.vim'] }

NeoBundle 'inotom/str2htmlentity'   " rangeをHTMLの実体参照に相互変換
" NeoBundle 'itchyny/screensaver.vim'

NeoBundleLazy 'osyo-manga/vim-stargate', { 'autoload' : {'filetypes' : ['c', 'cpp'] }}

NeoBundle 'lilydjwg/colorizer'
NeoBundle 'colorsel.vim' " gui only
" NeoBundle 'cohama/vim-insert-linenr' " insert-modeでLineNrを反転

NeoBundleLazy 'supermomonga/shaberu.vim',  { 'autoload' : {
      \   'commands' : [ 'ShaberuSay', 'ShaberuMuteOn', 'ShaberuMuteOff', 'ShaberuMuteToggle' ]
      \ }}
"}}}

"###################### plugin config ############################"
let g:netrw_nogx=1             " 不要なkeymapを無効
let g:no_cecutil_maps=1        " AnsiEsc の中で変なマッピングをしないようにする
let g:solarized_termcolors=256 " solarizedをCUIで使うため
let python_highlight_all = 1
command! -range Trans :<line1>,<line2>:ExciteTranslate

if neobundle#tap('vimshell.vim') "{{{
  command! Vshell tabnew +VimShell
  call neobundle#untap()
endif "}}}

" vim-operator taps "{{{
if neobundle#tap('vim-operator-user')
  nmap <Space>k <Plug>(operator-jump-head-out)a
  nmap <Space>j <Plug>(operator-jump-tail-out)a
  nmap gr <Plug>(operator-replace)
  xmap gr <Plug>(operator-replace)

  nmap se <Plug>(operator-evalruby)
  xmap se <Plug>(operator-evalruby)

  call neobundle#untap()
endif

if neobundle#tap('vim-operator-surround') "{{{
  " () {} はab aB で表す 他は記号 でもb Bは使わないかな
  map <silent>sa <Plug>(operator-surround-append)
  map <silent>sd <Plug>(operator-surround-delete)a
  map <silent>sr <Plug>(operator-surround-replace)a

  " if you use vim-textobj-multiblock
  nmap <silent>sdd <Plug>(operator-surround-delete)<Plug>(textobj-multiblock-a)
  nmap <silent>srr <Plug>(operator-surround-replace)<Plug>(textobj-multiblock-a)

  " if you use vim-textobj-between srbはsrabと被る
  " nmap <silent>sdb <Plug>(operator-surround-delete)<Plug>(textobj-between-a)
  " nmap <silent>srb <Plug>(operator-surround-replace)<Plug>(textobj-between-a)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-clang-format') "{{{
  let g:clang_format#command = 'clang-format'
  if !executable(g:clang_format#command)
    let g:clang_format#command = 'clang-format-3.6'
  endif

  call neobundle#untap()
endif "}}}
"}}}

" vim-textobj taps "{{{
if neobundle#tap('vim-textobj-user')
  " let g:textobj_enclosedsyntax_no_default_key_mappings = 1
  call neobundle#untap()
endif

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

  " whitout last <Space> <CR>...
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
  omap ib <Plug>(textobj-multiblock-i)
  xmap ib <Plug>(textobj-multiblock-i)
  omap ab <Plug>(textobj-multiblock-a)
  xmap ab <Plug>(textobj-multiblock-a)

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

if neobundle#tap('vim-expand-region') "{{{
  xmap v <Plug>(expand_region_expand)
  xmap gm <Plug>(expand_region_shrink)

  call neobundle#untap()
endif "}}}

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
  command! Maps    Unite maps -auto-resize -start-insert
  command! Prefix  Unite prefix -auto-resize -start-insert -input=^...
  command! Bundle  Unite -auto-resize -start-insert neobundle
  command! Update  Unite -auto-resize neobundle/update
  command! Vgrep   Unite -auto-resize -no-empty -no-quit vimgrep
  command! Schemes Unite -auto-resize -auto-preview colorscheme
  command! Todo    Unite -auto-resize -auto-preview -no-empty -ignorecase grep:%::(todo|fix|xxx)\:
  command! Headline Unite headline -auto-resize -auto-preview -no-empty -start-insert
  command! High    Unite highlight
  command! Status  Unite -auto-resize -no-empty -no-quit git_modified git_untracked
  command! Quickfix Unite quickfix -no-empty -auto-resize -direction= -no-quit
  command! LocationList call g:OpenLocationList()

  functio! g:OpenLocationList() "{{{
    let num = unite#get_unite_winnr('location_list')
    if num != -1
      " unite_exitの実態はclose
      execute num . "windo quit"
    endif
    " -createつけると意図した通りに動作するがhide-bufferが大量生成される
    " つけないとFileTypeでのマップがうまくいかなかったり、色がつかなかったり
    " -silent つかないと起動時にメッセージが出て止まる
    Unite location_list -buffer-name=location_list -auto-resize -no-quit -no-empty -no-focus -create -direction=below -silent

  endfunctio "}}}

 " keymap "{{{
  nnoremap <silent>\gs :Status<CR>

  nnoremap <silent><Space>m :<C-U>Unite -auto-resize -no-empty mark<CR>
  nnoremap <silent>;mb :<C-U>Unite -auto-resize -no-empty bookmark<CR>
  nnoremap <silent>;ma :<C-U>UniteBookmarkAdd<CR>

  nnoremap <silent>;ub :<C-U>Unite buffer<CR>
  nnoremap <silent>;ut :<C-u>Unite -select=`tabpagenr()-1` tab<CR>

  nnoremap <silent>\f :<C-U>Unite -start-insert file<CR>
  nnoremap <silent>\F :<C-U>Unite -start-insert file neomru/file<CR>
  nnoremap <silent><Space>r :<C-U>UniteResume -no-start-insert -force-redraw<CR>

  " search
  nnoremap <silent>s/ :<C-u>Unite -buffer-name=search%`bufnr('%')` -start-insert line:forward:wrap<CR>
  nnoremap <silent>s? :<C-u>Unite -buffer-name=search%`bufnr('%')` -start-insert line:backward:wrap<CR>
  nnoremap <silent>s* :<C-u>UniteWithCursorWord -buffer-name=search%`bufnr('%')` line:forward:wrap<CR>
  nnoremap <silent>s# :<C-u>UniteWithCursorWord -buffer-name=search%`bufnr('%')` line:backward:wrap<CR>
  nnoremap <silent>sn :<C-u>UniteResume search%`bufnr('%')` -no-start-insert -force-redraw<CR>

  " outline系
  nnoremap <silent>soo :Unite outline -auto-resize -resume -auto-preview<CR>
  nnoremap <silent>soh :Headline<CR>
  nnoremap <silent>sot :Todo<CR>
"}}}

  au FileType unite call s:unite_config()
  function! s:unite_config()
    nnoremap <silent><buffer>q  :call <SID>unite_smart_close()<CR>
    let context = unite#get_context()

    " unite-quickfixの設定色々
    if context.buffer_name == 'quickrun-hook-unite-quickfix'
      au WinEnter <buffer> if winnr('$') == 1 | quit | endif
      nnoremap <silent><buffer>k :call <SID>unite_move_pos(1)<CR>
      nnoremap <silent><buffer>j :call <SID>unite_move_pos(0)<CR>
    endif

    if context.buffer_name == 'location_list'
      au WinEnter <buffer> if winnr('$') == 1 | quit | endif
    endif
  endfunction

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
  endfunction "}}}

  let neobundle#hooks.on_source = '~/.vim/rc/unite.rc.vim'

  function! neobundle#tapped.hooks.on_post_source(bundle)
    call unite#custom#default_action("source/vimpatches/*", "openbuf")
  endfunction

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
  " command! Vf VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit
  command! Vfe VimFiler -split -simple -find -winwidth=26 -no-quit
  command! Vfs VimFilerSplit
  command! Vft VimFilerTab
  command! Vf VimFiler
  command! Vimfiler Vf
  nnoremap <silent><C-W>e :Vfe<CR>

  let neobundle#hooks.on_source = '~/.vim/rc/vimfiler.rc.vim'
  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-easy-align') "{{{
  let neobundle#hooks.on_source = '~/.vim/rc/easyalign.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('syntastic') "{{{
  let g:syntastic_always_populate_loc_list = 1  " quickfixの表示を更新する
  let g:syntastic_loc_list_height = 10
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq   = 0
  let g:syntastic_enable_signs  = 0
  let g:syntastic_auto_jump     = 3 " default is 0
  let g:syntastic_ignore_files  = ['\m^/usr/include/', expand('~/Documents/memo/')]
  " let g:syntastic_debug = 1

  let g:syntastic_error_symbol   = "✗"
  let g:syntastic_warning_symbol = "⚠"

  let g:syntastic_cpp_compiler         = 'clang++'
  let g:syntastic_cpp_compiler_options = $CPP_COMP_OPT
  let g:syntastic_ruby_mri_args        = "-W1"

  nmap \ts :SyntasticToggleMode<CR>
  nmap \sh :call SyntasticLoclistHide()<CR>

  " wrteで開く
  " readで開くのはafter/plugin/の中にある
  function! neobundle#tapped.hooks.on_post_source(bundle)
    au uAutoCmd BufWritePost * call g:OpenLocationList()
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-hier') "{{{
  function! neobundle#tapped.hooks.on_post_source(bundle)
    au uAutoCmd BufWritePost * HierUpdate
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('committia.vim') "{{{
  let g:committia_open_only_vim_starting = 1
  let g:committia_hooks = {}
  function! g:committia_hooks.edit_open(info)
    setlocal spell

    " If no commit message, start with insert mode
    " if a:info.vcs ==# 'git' && getline(1) ==# ''
    "     startinsert
    " end

    " Scroll the diff window from insert mode
    imap <buffer><C-k> <Plug>(committia-scroll-diff-up-half)
    imap <buffer><C-j> <Plug>(committia-scroll-diff-down-half)
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

  " cmdlineで<C-y>押せばレジストリが遡れる 検索で <C-r>が使えなくなる
  " cmap <C-r> <Plug>(yankround-insert-register)
  " cmap <C-y> <Plug>(yankround-pop)

  let g:yankround_max_history   = 30
  let g:yankround_file          = "~/.vim/tmp/yankround_history"
  let g:yankround_use_region_hl = 1
  au uAutoCmd ColorScheme * highlight YankRoundRegion cterm=italic

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-easymotion') "{{{
  let g:EasyMotion_do_mapping       = 0
  let g:EasyMotion_keys             = 'asdghklqwertyuiopzxcvbnmfj'
  let g:EasyMotion_use_upper        = 0
  let g:EasyMotion_leader_key       = ';'
  let g:EasyMotion_enter_jump_first = 1 " Enter jump to first match
  let g:EasyMotion_space_jump_first = 0 " Space jump to first match
  let g:EasyMotion_smartcase        = 1

  map ;j <Plug>(easymotion-j)
  map ;k <Plug>(easymotion-k)

  " on the current-line f f t and t
  map ;f <plug>(easymotion-fl)
  map ;F <plug>(easymotion-Fl)
  map ;t <plug>(easymotion-tl)
  map ;T <plug>(easymotion-Tl)

  " 2 chars motion
  map ;s <Plug>(easymotion-s2)
  map ;x <Plug>(easymotion-sl2)

  " other keymap. default
  map ;w <Plug>(easymotion-w)
  map ;W <Plug>(easymotion-W)
  map ;b <Plug>(easymotion-b)
  map ;B <Plug>(easymotion-B)
  map ;e <Plug>(easymotion-e)
  map ;E <Plug>(easymotion-E)
  map ;ge <Plug>(easymotion-ge)
  map ;gE <Plug>(easymotion-gE)

  " map ;n <Plug>(easymotion-n)
  " map ;N <Plug>(easymotion-N)

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
  let g:airline#extensions#tabline#enabled     = 1
  let g:airline#extensions#tabline#show_tab_nr = 1
  let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
  let g:airline#extensions#tabline#left_sep    = ''
  let g:airline#extensions#tabline#fnamemod    = ':t' " name in tabline. second argument of fnamemodify
  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-submode') "{{{
  let neobundle#hooks.on_source = '~/.vim/rc/submode.rc.vim'

  call neobundle#untap()
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

if neobundle#tap('vim-anzu') " {{{
  " let g:anzu_enable_CursorHold_AnzuUpdateSearchStatus = 1
  " Treat folding well
  " nnoremap <expr> n anzu#mode#mapexpr('n', '', 'zzzv')
  " nnoremap <expr> N anzu#mode#mapexpr('N', '', 'zzzv')

  " clear status
  " nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
endif " }}}

if neobundle#tap('vim-asterisk') "{{{
  " let g:asterisk#keeppos = 1
  call neobundle#untap()
endif "}}}

if neobundle#tap('incsearch.vim') " {{{
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
  map z* <Plug>(incsearch-nohl)<Plug>(asterisk-g*)<Plug>(anzu-update-search-status-with-echo)
  map z# <Plug>(incsearch-nohl)<Plug>(asterisk-g#)<Plug>(anzu-update-search-status-with-echo)
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

" commentout taps "{{{
if neobundle#tap('caw.vim')
  let g:caw_no_default_keymappings = 1
  xmap gc <Plug>(caw:i:toggle)
  xmap <Plug>(comment-toggle-yank) ygv<Plug>(caw:i:toggle)
  xmap gy <Plug>(comment-toggle-yank)

  call neobundle#untap()
endif

if neobundle#tap('nerdcommenter')
  let g:NERDCreateDefaultMappings = 0
  let g:NERDSpaceDelims = 1

  " 上下で反転させるならこれが必要
  nmap gcj 2<Plug>NERDCommenterInvert
  nmap gck k2<Plug>NERDCommenterInvertj

  " vを付けないとこっちのじゃないと先頭に回数指定できない
  " vを先頭につけると回数指定の動作が変わる
  nmap gcc <Plug>NERDCommenterToggle
  nmap gyy <Plug>NERDCommenterYank

  " Aじゃないとmotionのaが使えない
  nmap gcA <Plug>NERDCommenterAppend

  call neobundle#untap()
endif

if neobundle#tap('vim-operator-exec_command') && neobundle#tap('nerdcommenter') && neobundle#tap('caw.vim')
  nmap <silent><expr> <Plug>(operator-comment-toggle)
        \ operator#exec_command#mapexpr_v_keymapping("\<Plug>(caw:i:toggle)")

  nmap <silent><expr> <Plug>(operator-comment-yank-toggle)
        \ operator#exec_command#mapexpr_v_keymapping("\<Plug>(comment-toggle-yank)")

  nmap gc <Plug>(operator-comment-toggle)
  nmap gy <Plug>(operator-comment-yank-toggle)

  call neobundle#untap()
endif
"}}}

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

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-jplus') "{{{
  nmap J <Plug>(jplus)
  xmap J <Plug>(jplus)

  " 任意の1文字+両端に空白を挿入して結合を行う
  nmap gJ <Plug>(jplus-getchar-with-space)
  xmap gJ <Plug>(jplus-getchar-with-space)

  " 複数文字を入力したい場合
  nmap <Space>gJ <Plug>(jplus-input)
  vmap <Space>gJ <Plug>(jplus-input)

  let g:jplus#config = {
  \   "ruby" : {
  \       "right_matchstr_pattern" : '^\s*#*\s*\zs.*',
  \   }
  \}

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-quickhl') "{{{
  let g:quickhl_manual_enable_at_startup = 1
  let g:quickhl_cword_enable_at_startup  = 0
  let g:quickhl_tag_enable_at_startup    = 0
  let g:quickhl_manual_keywords          = [] " Can use List and Dictionary

  nmap gh <Plug>(quickhl-manual-this)
  xmap gh <Plug>(quickhl-manual-this)
  map  gH <Plug>(operator-quickhl-manual-this-motion)

  nmap \hm <Plug>(quickhl-manual-reset)
  xmap \hm <Plug>(quickhl-manual-reset)
  nmap \ht <Plug>(quickhl-tag-toggle)
  nmap \hc <Plug>(quickhl-cword-toggle)

  let g:quickhl_manual_hl_priority = 100
  let g:quickhl_manual_colors = [
        \ 'term=reverse ctermfg=232 ctermbg=196 gui=bold guifg=Black guibg=Red',
        \ 'term=reverse ctermfg=232 ctermbg=129 gui=bold guifg=Black guibg=Purple',
        \ 'term=reverse ctermfg=232 ctermbg=63  gui=bold guifg=Black guibg=SlateBlue',
        \ 'term=reverse ctermfg=232 ctermbg=27  gui=bold guifg=Black guibg=Blue',
        \ 'term=reverse ctermfg=232 ctermbg=40  gui=bold guifg=Black guibg=Green',
        \ 'term=reverse ctermfg=232 ctermbg=226 gui=bold guifg=Black guibg=Yellow',
        \ 'term=reverse ctermfg=232 ctermbg=202 gui=bold guifg=Black guibg=Orange',
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
        \ 'gui=bold ctermfg=0   ctermbg=56  guibg=#a0b0c0 guifg=black',
        \ ]

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-niceblock') "{{{
  xmap I  <Plug>(niceblock-I)
  xmap A  <Plug>(niceblock-A)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-choosewin') "{{{
  nmap \w <Plug>(choosewin)
  let g:choosewin_overlay_enable          = 1
  let g:choosewin_overlay_clear_multibyte = 1
  let g:choosewin_overlay_font_size       = 'small'
  let g:choosewin_blink_on_land           = 0
  let g:choosewin_statusline_replace      = 0
  let g:choosewin_tabline_replace         = 0

  call neobundle#untap()
endif "}}}

if neobundle#tap('jedi-vim') "{{{
  autocmd uAutoCmd FileType python setlocal omnifunc=jedi#completions
  let g:jedi#completions_enabled    = 0
  let g:jedi#auto_vim_configuration = 0

  call neobundle#untap()
endif "}}}

if neobundle#tap('open-browser.vim') "{{{
  nmap ,os <Plug>(openbrowser-wwwsearch)
  nmap ,oa <Plug>(openbrowser-smart-search)

  function! neobundle#hooks.on_source(bundle)
    command Wsearch :call <SID>www_search()
    nnoremap <Plug>(openbrowser-wwwsearch) :<C-u>call <SID>www_search()<CR>
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

if neobundle#tap('rainbowcyclone.vim') "{{{
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
  call neobundle#untap()
endif "}}}

if neobundle#tap('colorizer') "{{{
  let g:colorizer_nomap   = 1
  let g:colorizer_startup = 0
  nmap \hz <Plug>Colorizer

  call neobundle#untap()
endif "}}}

if neobundle#tap('indentLine') "{{{
  let g:indentLine_enabled              = 0
  let g:indentLine_faster               = 1
  let g:indentLine_showFirstIndentLevel = 1
  let g:indentLine_color_term           = 208
  nmap <silent>\tl :IndentLinesToggle<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-hopping') "{{{
  let g:hopping#prompt     = "Input:> "
  nmap \H <Plug>(hopping-start)
  " let g:hopping#keymapping = {
  "   \	"\<C-n>" : "<Over>(hopping-next)",
  "   \	"\<C-p>" : "<Over>(hopping-prev)",
  "   \	"\<C-u>" : "<Over>(scroll-u)",
  "   \	"\<C-d>" : "<Over>(scroll-d)",
  "   \}
  "
  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-altercmd') "{{{
  let neobundle#tapped.hooks.on_post_source = '~/.vim/rc/altercmd.rc.vim'
  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-abolish') "{{{
  " Downer snake case
  nmap crd crsguaw

  call neobundle#untap()
endif "}}}

if neobundle#tap('CamelCaseMotion') "{{{
    map <silent> <Space>w <Plug>CamelCaseMotion_w
    map <silent> <Space>b <Plug>CamelCaseMotion_b
    map <silent> <Space>e <Plug>CamelCaseMotion_e

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-gitgutter') "{{{
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
  nmap \gp <Plug>GitGutterPreviewHunk
  nmap \gadd <Plug>GitGutterStageHunk
  nmap \grev <Plug>GitGutterRevertHunk
  nmap \th :GitGutterLineHighlightsToggle<CR>
  nmap \tg :GitGutterSignsToggle<CR>

  function! neobundle#tapped.hooks.on_post_source(bundle)
    hi GitGutterChangeDefault ctermfg=226
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-fugitive') "{{{

  call neobundle#untap()
endif "}}}

if neobundle#tap('linediff.vim') "{{{
  nnoremap <silent>gsd  :Linediff<CR>
  xnoremap <silent>gsd  :Linediff<CR>

  let g:linediff_buffer_type = 'scratch'
  " let g:linediff_indent = 1 " onにするとqで一発終了できない
  " let g:linediff_first_buffer_command  = 'new'
  " let g:linediff_second_buffer_command = 'vertical new'

  call neobundle#untap()
endif "}}}

if neobundle#tap('gundo.vim') "{{{
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

  call neobundle#untap()
endif "}}}

if neobundle#tap('shaberu.vim') "{{{
  command! -nargs=1 Say ShaberuSay <args>
  let g:shaberu_user_define_say_command = 'jsay "%%TEXT%%"'
  let g:shaberu_is_mute = 0
  call neobundle#untap()
endif "}}}

if neobundle#tap('nextfile.vim') "{{{
  let g:nf_map_next         = '[f'
  let g:nf_map_previous     = ']f'
  let g:nf_include_dotfiles = 0
  let g:nf_ignore_dir       = 1
  let g:nf_open_command     = 'edit'

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-qfreplace') "{{{
  au uAutoCmd FileType qf nnoremap <buffer>r :<C-u>Qfreplace<CR>

  call neobundle#untap()
endif "}}}

" if neobundle#tap('') "{{{
"
"   call neobundle#untap()
" endif "}}}

call neobundle#end()
