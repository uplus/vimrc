" http://qiita.com/syngan/items/0dd647e0f08557bbd633
" https://github.com/syngan/vim-clurin

" match order
" 1. g:clurin[&filetype]
" 2. g:clurin['-']
" 3. clurin.vim デフォルトの &filetype 用定義
" 4. clurin.vim デフォルト定義 (-)

" search order
" 1. g:clurin[&filetype]
" 2. g:clurin['-']
" 3. clurin.vim デフォルトの &filetype 用定義
" 4. clurin.vim デフォルト定義 (-)

function! g:CountUp(str, cnt, def) abort
  " a:str: matched_text
  " a:cnt: non zero.
  " a:def: definition
  return str2nr(a:str) + a:cnt
endfunction

function! g:CtrlAX(cnt) abort
	if a:cnt >= 0
		execute 'normal!' a:cnt . "\<C-A>"
	else
		execute 'normal!' (-a:cnt) . "\<C-X>"
	endif
endfunction

function g:RubyDo(str, cnt, def) abort
  VimConsoleLog a:cnt
  VimConsoleLog a:str
  VimConsoleLog a:def

  s/\vdo\s*(\|.*\|)?\_s*(.*)\_s*end/{\1 \2}
  " いらない行の削除をする
  " 一行にして返す
endfunction

let g:clurin = {
      \ '-': {'def': [
      \   ['&&', '||'], ['yes', 'no'], ['Left', 'Right'], ['Up', 'Down'],
      \   [' < ', ' > '], [' <= ', ' >= '], [' == ', ' != '],
      \   [{'pattern': '\v''(\k+)''', 'replace': '''\1'''},
      \    {'pattern': '\v"(\k+)"', 'replace': '"\1"'},],
      \ ]},
      \
      \ 'markdown': {'def': [
      \   ['[ ]', '[x]'],
      \   ['#', '##', '###', '####', '#####', ],
      \   ["-", "\t-", "\t\t-", "\t\t\t-", ],
      \   ["+", "\t+", "\t\t+", "\t\t\t+", ],
      \ ]},
      \
      \ 'gitrebase': {'def': [
      \   [ 'pick', 'reword', 'edit', 'squash', 'fixup', 'exec'],
      \ ]},
      \
      \ 'toml': {'def': [
      \   ['hook_add', 'hook_source', 'hook_post_source'],
      \   [{'pattern': '\v''(.+)''$', 'replace': "'''\\1'''" },],
      \ ]},
      \
      \ 'vim': {'def': [
      \   ['echo ', 'echomsg '],
      \   ['nnoremap ', 'nmap '],
      \   ['inoremap ', 'imap '],
      \   ['cnoremap ', 'cmap '],
      \   ['xnoremap ', 'xmap '],
      \   ['BufWritePre', 'BufWritePost', 'BufWriteCmd'],
      \   ['BufReadPre', 'BufReadPost', 'BufReadCmd'],
      \   ['==#', '!=#' ],
      \   ['==?', '!=?' ],
      \   ['=~#', '!~#' ],
      \   ['=~?', '!~?' ],
      \   ['if', 'elseif', 'else'],
      \   [{'pattern': '\[''\(\k\+\)''\]', 'replace': '[''\1'']'},
      \    {'pattern': '\["\(\k\+\)"\]',   'replace': '["\1"]'},
      \    {'pattern': '\.\(\k\+\)',       'replace': '.\1'}],
      \ ]},
      \
      \ 'c': {'def': [
      \ ]},
      \
      \ 'ruby': {'def': [
      \   [{'pattern': '\v"(\k+)"', 'replace': '"\1"'},
      \    {'pattern': '\v''(\k+)''', 'replace': '''\1'''},
      \    {'pattern': '\v:(\k+)', 'replace': ':\1'}],
      \   [{'pattern': '\v\s*do\s*(\|.*\|)?', 'replace': function('g:RubyDo')},],
      \   ['if', 'unless' ],
      \   ['while', 'until' ],
      \   ['.blank?', '.present?' ],
      \   ['include', 'extend' ],
      \   ['class', 'module' ],
      \   ['.inject', '.reject' ],
      \   ['.map', '.map!' ],
      \   ['.sub', '.sub!', '.gub', '.gub!' ],
      \   ['.clone', '.dup' ],
      \   ['.any?', '.none?' ],
      \   ['.all?', '.one?' ],
      \   ['p ', 'puts ', 'print '],
      \   ['attr_accessor', 'attr_reader', 'attr_writer' ],
      \   ['File.exist?', 'File.file?', 'File.directory?' ],
      \ ]},
      \ 'zsh': {'def': [
      \   ['chpwd', 'periodic', 'precmd', 'preexec', 'zshaddhistory', 'zshexit', 'zsh_directory_name'],
      \ ]}
      \ }

" TODO expandで同じ要素追加する?(コピーにならないかも)
au u10ac FileType zsh,sh let b:clurin = {'def':[
      \   ['if', 'elif', 'else'],
      \   [' -a ', ' -o '],
      \   [' -z ', ' -n '],
      \   [' -eq ', ' -ne '],
      \   [' -lt ', ' -le ', ' -gt ', ' -ge '],
      \   [' -e ', ' -f ', ' -d '],
      \   [' -r ', ' -w ', ' -x '],
      \ ]}

" 関数とPatternだけ用意してユーザが挿入する方が良いかも

" TODO ruby(:a => b, a: file)配置順序注意
" 通常のリスト中でignorecaseが使いたい? yesとかは関数使ったほうがいい
" 改行するときは関数を呼ぶ?
" 複数行置換できない
"   明示的に指定したときのみやらせる?
"   getline->matchだから複数行対応は面倒くさいかも
"   doにマッチさせて関数読んで中で頑張る
" replaceの関数で処理を終えたい
"   オプションを追加するのが互換性があっていい
"   具体例は思いつかないけど戻り値で判断するのが便利
"   例外

" 複数のファイルタイプに同じ設定はできない
" エラーが出ても出力が分かりづらい(dein)
" []では正規表現が使えない

      " \   [{'pattern': '\<true\>', 'replace': 'true'},
      " \    {'pattern': '\<false\>', 'replace': 'false'}],
      " \   [{'pattern': '\(-\?\d\+\)', 'replace': function('g:CountUp')}],
