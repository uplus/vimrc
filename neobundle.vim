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

if has('vim_starting')
  "Set the directory to be managed by the bundle
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim', { 'build' : {
                            \   'mac'   : 'make -f make_mac.mak',
                            \   'linux' : 'make',
                            \   'unix'  : 'make -f make_unix.mak',
                            \}, }
NeoBundle 'Shougo/vimshell'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'troydm/easybuffer.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic.git'
NeoBundle 'kana/vim-submode'        " vimに独自のモードを作成できる
NeoBundle 'osyo-manga/vim-over'     " タブ補完が効く置き換えモード
NeoBundle 'kannokanno/previm'       " Markdown Previewer
NeoBundle 'bronson/vim-trailing-whitespace' " 行末の半角スペースをハイライト
NeoBundle 'vim-scripts/AnsiEsc.vim' " ANSIカラー情報を反映して表示する
NeoBundle 'deris/vim-shot-f'        " ftFTで一発で飛べる位置を表示する
" NeoBundle 'deris/improvedft'        " ftFTで複数文字を入力できる
" NeoBundle 'deris/clever-f.vim'      " ftFTで検索後ftで次へ移動できる

" Rails
NeoBundle 'tpope/vim-rails'         " Modelを表示したりできる
NeoBundle 'basyura/unite-rails'     " Unite上にrailsの情報を表示する

" NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'LeafCage/yankround.vim'  " round the yank history
NeoBundle 'osyo-manga/vim-anzu'     " show search point to command line
NeoBundle 'haya14busa/incsearch.vim' "サーチ時に全てをハイライト

NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-endwise'       " do に対してのendなどを自動入力
NeoBundle 'kana/vim-smartchr'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'tpope/vim-surround'      " 囲んでるものに対しての処理
NeoBundle 'AndrewRadev/switch.vim'  " ifとunlessを入れ替えたり

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/unite-quickfix' " uniteにquickfixを出力
NeoBundle 'osyo-manga/shabadou.vim'   " 汎用的なquickrun-hook

if s:meet_neocomplete_requirements()
  NeoBundle 'Shougo/neocomplete'
endif
" NeoBundle 'Shougo/neosnippet.vim'
NeoBundleLazy 'Rip-Rip/clang_complete', {
            \ 'autoload' : {'filetypes' : ['c', 'cpp']}
            \ }

NeoBundleLazy 'osyo-manga/vim-stargate', { 'autoload' : {'filetypes' : ['c', 'cpp'] } }

source ~/.vim/colors.vim "Colors
call neobundle#end()
filetype plugin indent on " Required

"# anzu&incsearch マッチした数&自動ハイライト&オフ
let g:incsearch#auto_nohlsearch = 1 "自動でハイライトを消す
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map  n <Plug>(incsearch-nohl-n)
map  N <Plug>(incsearch-nohl-N)
nmap n <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)
nmap N <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

"# NERDTree
"0ならそのまま開いとく, 1なら閉じる
" let g:NERDTreeQuitOnOpen=0 "//defo 0
"let g:NERDTreeShowHidden=0 "//defo 0
let g:NERDTreeWinSize=26  "//defo 31

call Source_rc('switch.rc.vim')

" syntastic
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = $CPP_COMP_OPT
let g:syntastic_always_populate_loc_list=1  " quickfixの表示を更新する
let g:syntastic_check_on_open=1

" ###Quickrun
let g:quickrun_config = get(g:, 'quickrun_config', {})
" vimprocを使用して非同期実行し、結果をquickfixに出力する
let g:quickrun_config._ = {
      \ 'outputter/buffer/split'  : ':botright 8sp',
      \ 'runner'    : 'vimproc',
      \ 'runner/vimproc/updatetime' : 40,
      \ 'outputter' : 'multi:buffer:quickfix',
      \ 'hook/time/enable' : 1,
      \ 'outputter/buffer/close_on_empty' : 1
      \}

let g:quickrun_config.cpp = {
      \ 'command' : '/usr/bin/clang++',
      \ 'cmdopt'  : $CPP_COMP_OPT
      \}

let g:quickrun_config.c = {
      \ 'command' : '/usr/bin/clang',
      \ 'cmdopt'  : $C_COMP_OPT
      \}

" yankround
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

" yankround
" round対象のうちはハイライトする
let g:yankround_use_region_hl = 0
let g:yankround_max_history = 50
let g:yankround_dir = "~/.vim/tmp/"

let g:over#command_line#enable_move_cursor = 1
let g:over_command_line_prompt = "> "

" ##neocomplete, clang_complete and etc...
if s:meet_neocomplete_requirements()
  call Source_rc('complete.rc.vim')
endif

if !exists('loaded_matchit')
  runtime macros/matchit.vim
endif
