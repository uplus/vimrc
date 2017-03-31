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

let g:clurin = {
      \ '-': {'def': [
      \   ['&&', '||'], ['yes', 'no'],
      \   [' < ', ' > '], [' <= ', ' >= '], [' == ', ' != '],
      \   [{'pattern': '\v''(\k+)''', 'replace': '''\1'''},
      \    {'pattern': '\v"(\k+)"', 'replace': '"\1"'},],
      \ ]},
      \
      \ 'markdown': {'def': [
      \   ['[ ]', '[x]'],
      \ ]},
      \
      \ 'gitrebase': {'def': [
      \   [ 'pick', 'reword', 'edit', 'squash', 'fixup', 'exec'],
      \ ]},
      \
      \ 'toml': {'def': [
      \   ['hook_add', 'hook_source', 'hook_post_source'],
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
      \ }

au u10ac FileType zsh,sh,bash let b:clurin = {'def':[
      \   [ ' -a ', ' -o '],
      \   [ ' -z ', ' -n '],
      \   [ ' -eq ', ' -ne '],
      \   [ ' -lt ', ' -le ', ' -gt ', ' -ge '],
      \   [ ' -e ', ' -f ', ' -d '],
      \   [ ' -r ', ' -w ', ' -x '],
      \ ]}

" TODO ruby(:a => b, a: file)配置順序注意
" b:サポートしてた

" 複数のファイルタイプに同じ設定はできない
" エラーが出ても出力が分かりづらい(dein)
" []では席表現が使えない

      " \   [{'pattern': '\<true\>', 'replace': 'true'},
      " \    {'pattern': '\<false\>', 'replace': 'false'}],
      " \   [{'pattern': '\(-\?\d\+\)', 'replace': function('g:CountUp')}],
