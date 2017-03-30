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
      \   ['&&', '||'],
      \   ['yes', 'no'],
      \   ['abc', 'efg'],
      \   [{'pattern': '\(-\?\d\+\)', 'replace': function('g:CountUp')}],
      \   [{'pattern': '\<true\>', 'replace': 'true'},
      \    {'pattern': '\<false\>', 'replace': 'false'}],
      \ ]},
      \
      \ 'vim': {'def': [
      \   [{'pattern': '''\(\k\+\)''', 'replace': '''\1'''},
      \    {'pattern': '"\(\k\+\)"', 'replace': '"\1"'}],
      \   [{'pattern': '\[''\(\k\+\)''\]', 'replace': '[''\1'']'},
      \    {'pattern': '\["\(\k\+\)"\]',   'replace': '["\1"]'},
      \    {'pattern': '\.\(\k\+\)',       'replace': '.\1'}],
      \ ]},
      \
      \ 'c': {'def': [
      \   [{'pattern': '\(\k\+\)\.', 'replace': '\1.'},
      \    {'pattern': '\(\k\+\)->', 'replace': '\1->'}]
      \ ]},
      \ 'ruby': {'def': [
      \   [{'pattern': '''\(\k\+\)''', 'replace': '''\1'''},
      \   {'pattern': '"\(\k\+\)"', 'replace': '"\1"'},
      \   {'pattern': ':\(\k\+\)"', 'replace': ':\1'}],
      \ ]}
      \ }
