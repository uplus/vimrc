" #vital
" NeoBundle 'osyo-manga/vital-reunions' " プロセス実行
" NeoBundle 'osyo-manga/vital-unlocker' " オプションの値保存

" #untie "{{{
" NeoBundle 'osyo-manga/unite-boost-online-doc',{ 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundle 'Shougo/unite-build',               { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundle 'sgur/unite-qf',                    { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundleLazy 'mattn/unite-remotefile',           { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundleLazy 'ujihisa/unite-locate',             { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundleLazy 'supermomonga/unite-goimport.vim',  { 'depends' : [ 'Shougo/unite.vim', 'fatih/vim-go' ] }
"}}}

" #action
NeoBundle 'osyo-manga/vim-milfeulle'
" NeoBundle 'deris/improvedft'      " ftFT can input many charactores
" NeoBundle 'deris/vim-shot-f'      " ftFT show oneshot jump points

" #python
NeoBundleLazy 'jpythonfold.vim',      { 'filetypes' : ['python'] } " fold config of python

" #tag and #ref
" NeoBundle 'szw/vim-tags'
" NeoBundle 'soramugi/auto-ctags.vim'

" #operator
" NeoBundle 'tyru/operator-html-escape.vim',     { 'depends' : 'kana/vim-operator-user' }
" emonkak/vim-operator-sort

" #textobj
" NeoBundle 'akiyan/vim-textobj-xml-attribute'  " axa ixa XML の属性
" NeoBundle 'hchbaw/textobj-motionmotion.vim'   " am im 任意の2つの motion の間

" #misc
NeoBundle 'colorsel.vim' " gui only
" NeoBundle 'thinca/vim-threes'
" NeoBundleLazy 'supermomonga/shaberu.vim',  { 'autoload' : {
      " \   'commands' : [ 'ShaberuSay', 'ShaberuMuteOn', 'ShaberuMuteOff', 'ShaberuMuteToggle' ] }}

" #colorscheme
" NeoBundle 'freeo/vim-kalisi'
" NeoBundle 'altercation/vim-colors-solarized'
" NeoBundle 'Colour-Sampler-Pack' " 大量のcolorschemeセット
" NeoBundle 'cocopon/iceberg.vim'
" NeoBundle 'w0ng/vim-hybrid'
" NeoBundle 'mrkn/mrkn256.vim'
" NeoBundle 'nelstrom/vim-mac-classic-theme'
" NeoBundle 'vim-scripts/louver.vim'
" NeoBundle 'croaker/mustang-vim'
" calmar256-dark gentooish inkot mirodark mustang neverness tabula synic vividchalk
