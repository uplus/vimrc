
" #vital
" NeoBundle 'osyo-manga/vital-reunions' " プロセス実行
" NeoBundle 'osyo-manga/vital-unlocker' " オプションの値保存

" #untie "{{{
" NeoBundle 'osyo-manga/unite-filetype',        { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundle 'osyo-manga/unite-vital-module',    { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundle 'osyo-manga/unite-vimmer',          { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundle 'osyo-manga/unite-boost-online-doc',{ 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundle 'osyo-manga/unite-vim_hacks',       { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundle 'Shougo/unite-build',               { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundle 'sgur/unite-qf',                    { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundleLazy 'mattn/unite-remotefile',           { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundleLazy 'ujihisa/unite-locate',             { 'depends' : [ 'Shougo/unite.vim' ] }
" NeoBundleLazy 'supermomonga/unite-goimport.vim',  { 'depends' : [ 'Shougo/unite.vim', 'fatih/vim-go' ] }
"}}}

" #view
" NeoBundle 'vimtaku/hl_matchit.vim'

" #action
NeoBundle 'osyo-manga/vim-milfeulle'
" NeoBundle 'deris/improvedft'      " ftFT can input many charactores
" NeoBundle 'deris/vim-shot-f'      " ftFT show oneshot jump points

" #python
NeoBundleLazy 'jpythonfold.vim',      { 'filetypes' : ['python'] } " fold config of python

" #tag and #ref
" NeoBundle 'szw/vim-tags'
" NeoBundle 'soramugi/auto-ctags.vim'
"

" #operator
" NeoBundle 'tyru/operator-html-escape.vim',     { 'depends' : 'kana/vim-operator-user' }
" NeoBundle 'thinca/vim-operator-sequence',      { 'depends' : 'kana/vim-operator-user' } " Execute two or more operators
" emonkak/vim-operator-sort
" osyo-manga/vim-operator-swap

" #textobj
" NeoBundle 'akiyan/vim-textobj-xml-attribute'  " axa ixa XML の属性
" NeoBundle 'hchbaw/textobj-motionmotion.vim'   " am im 任意の2つの motion の間

" #misc
NeoBundle 'colorsel.vim' " gui only
" NeoBundle 'thinca/vim-threes'
" NeoBundleLazy 'supermomonga/shaberu.vim',  { 'autoload' : {
      " \   'commands' : [ 'ShaberuSay', 'ShaberuMuteOn', 'ShaberuMuteOff', 'ShaberuMuteToggle' ] }}

" #colorscheme"{{{
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
"}}}


"###################### plugin config ############################"
let python_highlight_all = 1

if neobundle#tap('vim-smartinput') "{{{
  function! neobundle#tapped.hooks.on_post_source(bundle)
    call smartinput_endwise#define_default_rules()
    call smartinput#map_to_trigger('i', '<Plug>(smartinput_cr)', '<Enter>', '<Enter>')
    call smartinput#map_to_trigger('i', '<Bar>', '<Bar>', '<Bar>')

    call smartinput#define_rule({
          \   'at'       : '\%(\<struct\>\|\<class\>\|\<enum\>\)\s*\w\+.*\%#',
          \   'char'     : '{',
          \   'input'    : '{};<Left><Left>',
          \   'filetype' : ['cpp'],
          \   })

    call smartinput#define_rule({
          \   'at'       : '\\\%(\|%\|z\)\%#',
          \   'char'     : '(',
          \   'input'    : '(\)<Left><Left>',
          \   'filetype' : ['vim'],
          \   })

    call smartinput#define_rule({
          \   'at'       : '\\(\%#\\)',
          \   'char'     : '<BS>',
          \   'input'    : '<Del><Del><BS><BS>',
          \   'filetype' : ['vim'],
          \   })

    call smartinput#define_rule({
          \   'at'       : '\\[%z](\%#\\)',
          \   'char'     : '<BS>',
          \   'input'    : '<Del><Del><BS><BS><BS>',
          \   'filetype' : ['vim'],
          \   })

    call smartinput#define_rule({
          \   'at': '\({\|\<do\>\)\s*\%#',
          \   'char': '<Bar>',
          \   'input': '<Bar><Bar><Left>',
          \   'filetype': ['ruby'],
          \ })

    call smartinput#define_rule({
          \   'at': '\({\|\<do\>\)\s*|.*\%#|',
          \   'char': '<Bar>',
          \   'input': '<Right>',
          \   'filetype': ['ruby'],
          \ })

    call smartinput#define_rule({
          \   'at': '\({\|\<do\>\)\s*|\%#|',
          \   'char': '<BS>',
          \   'input': '<Del><BS>',
          \   'filetype': ['ruby'],
          \ })

  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-smartinput-endwise') "{{{
  let g:smartinput_endwise_avoid_neocon_conflict =  0

  function! neobundle#tapped.hooks.on_post_source(bundle)
    imap <expr><CR> neosnippet#expandable()? "\<Plug>(neosnippet_expand)" :
          \ pumvisible()? "\<C-y>" :
          \ "\<Plug>(smartinput_cr)"

  endfunction
  call neobundle#untap()
endif "}}}

if neobundle#tap('neocomplete.vim') && has('lua') "{{{
  let g:rsenseUseOmniFunc = 1
  let g:neocomplete#enable_at_startup = 1
  let neobundle#hooks.on_source = '~/.vim/rc/complete.rc.vim'

  inoremap <expr><S-TAB> pumvisible()? "\<C-p>" : "\<S-TAB>"
  imap <expr><TAB> pumvisible()? "\<C-n>" :
        \ neosnippet#jumpable()? "\<Plug>(neosnippet_jump)" :
        \ "\<TAB>"

  inoremap <Plug>(insert-lasttext) <C-a>
  imap <expr><C-l> neosnippet#jumpable()? "\<Plug>(neosnippet_jump)" : "\<Plug>(insert-lasttext)"

  call neobundle#untap()
endif "}}}

if neobundle#tap('open-browser.vim') "{{{
  nmap gss <Plug>(openbrowser-wwwsearch)
  nmap gsc <Plug>(openbrowser-smart-search)
  xmap gsc <Plug>(openbrowser-smart-search)

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

if neobundle#tap('vim-over') "{{{
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

  " <CR>がsmartinputでマップされている
  " それをcunmapすると色々バグる
  function! neobundle#tapped.hooks.on_post_source(bundle)
    OverCommandLineNoremap <CR> <CR>
  endfunction

  call neobundle#untap()
endif "}}}
