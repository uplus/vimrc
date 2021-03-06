" vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect

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


function! g:CountUp(strs, cnt, def) abort
  " a:strs: matched text list
  " a:cnt: non zero.
  " a:def: definition
  return str2nr(a:strs[0]) + a:cnt
endfunction

" nomatch's argument is one
function! g:CtrlAX(cnt) abort
	if a:cnt >= 0
		execute 'normal!' a:cnt . "\<C-A>"
	else
		execute 'normal!' (-a:cnt) . "\<C-X>"
	endif
endfunction

function g:RubyBlockOneline(str, cnt, def) abort
  let gdefault_save = &gdefault
  let &gdefault = 0
  try
    s/\v\s*do\s*(\|.*\|)?\_s*(.*)\_s*end/{\1 \2}/Ie
  finally
    let &gdefault = gdefault_save
  endtry
endfunction

function g:RubyBlockMultiline(str, cnt, def) abort
  let save_pos = getpos('.')
  let gdefault_save = &gdefault
  let &gdefault = 0
  try
    " \1周りのスペースは=regで対応?
    s/\v\s*\{(\|.*\|)?\_s*(.*)\_s*\}$/ do \1\r\2\rend/Ie
    call feedkeys('3==')
  finally
    let &gdefault = gdefault_save
    call setpos('.', save_pos)
  endtry
endfunction

let g:clurin = {
      \ '-': {'use_default': 0, 'def': [
      \   ['true', 'false'], ['on', 'off'], ['enable', 'disable'], ['On', 'Off'],
      \   ['&&', '||'], ['yes', 'no'], ['Left', 'Right'], ['Up', 'Down'],
      \   [' < ', ' > '], [' <= ', ' >= '], [' == ', ' != '],
      \   ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
      \   ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      \   ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
      \   [{'pattern': '\v''([^'']+)''', 'replace': '''\1'''},
      \    {'pattern': '\v"([^"]+)"', 'replace': '"\1"'},],
      \ ]},
      \
      \ 'markdown': {'def': [
      \   ['[ ]', '[x]'],
      \   ['#', '##', '###', '####', '#####', ],
      \   ['-', "\t-", "\t\t-", "\t\t\t-", ],
      \   ['+', "\t+", "\t\t+", "\t\t\t+", ],
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
      \ 'c': {'use_default': 0, 'def': [
      \ ]},
      \
      \ 'c cpp': {'def': [
      \   [{'pattern': '\(\k\+\)\.', 'replace': '\1.'},
      \    {'pattern': '\(\k\+\)->', 'replace': '\1->'}],
      \ ]},
      \
      \ 'ruby': {'def': [
      \   ['Metrics/', 'Metrics/AbcSize', 'Metrics/CyclomaticComplexity', 'Metrics/PerceivedComplexity'],
      \   ['perform_now', 'perform_later'],
      \   ['rubocop:enable', 'rubocop:disable'],
      \   [{'pattern': '\v:(\k+)\s*\=\>\s*', 'replace': ':\1 => '},
      \    {'pattern': '\v(\k+)\:\s*', 'replace': '\1: '},
      \   ],
      \   [{'pattern': '\v"(\w+)"', 'replace': '"\1"'},
      \    {'pattern': '\v''(\w+)''', 'replace': '''\1'''},
      \    {'pattern': '\v:(\w+)@>(\s+\=\>)@!', 'replace': ':\1'},
      \   ],
      \   {'quit': 1, 'group': [
      \     {'pattern': '\v\s*do\s*(\|.*\|)?', 'replace': function('g:RubyBlockMultiline')},
      \     {'pattern': '\v\s*\{(\|.*\|)?\_s*.*\_s*\}$', 'replace': function('g:RubyBlockOneline')},
      \   ]},
      \   [{'pattern': '\vlambda\s*\{%(\|(.*)\|)?\s*(.*)\s*\}', 'replace': 'lambda{|\1| \2}'},
      \    {'pattern': '\v-\>\s*\((.*)\)\s*\{\s*(.*)\s*\}', 'replace': '->(\1){ \2}'},
      \    {'pattern': '\vproc\s*\{%(\|(.*)\|)?\s*(.*)\s*\}', 'replace': 'proc{|\1| \2}'},
      \   ],
      \   ['if', 'unless' ],
      \   ['while', 'until' ],
      \   ['.blank?', '.present?' ],
      \   ['include', 'prepend', 'extend'],
      \   ['class', 'module' ],
      \   ['.inject', '.reject' ],
      \   ['.map', '.map!' ],
      \   ['.sub', '.sub!', '.gub', '.gub!' ],
      \   ['.clone', '.dup' ],
      \   ['.any?', '.none?' ],
      \   ['.all?', '.one?' ],
      \   ['pp ', 'puts ', 'print '],
      \   ['attr_accessor', 'attr_reader', 'attr_writer' ],
      \   ['File.exist?', 'File.file?', 'File.directory?' ],
      \   ['should ', 'should_not '],
      \   ['be_truthy', 'be_falsey'],
      \   ['create', 'build', 'build_stubbed'],
      \   ['it_behaves_like', 'include_examples'],
      \   ['describe', 'context'],
      \   ['.to ', '.to_not '],
      \ ]},
      \
      \ 'zsh': {'def': [
      \   ['chpwd', 'periodic', 'precmd', 'preexec', 'zshaddhistory', 'zshexit', 'zsh_directory_name'],
      \ ]},
      \
      \ 'zsh sh': {'def': [
      \   ['if', 'elif', 'else'],
      \   [' -a ', ' -o '],
      \   [' -z ', ' -n '],
      \   [' -eq ', ' -ne '],
      \   [' -lt ', ' -le ', ' -gt ', ' -ge '],
      \   [' -e ', ' -f ', ' -d '],
      \   [' -r ', ' -w ', ' -x '],
      \   [{'pattern': '\v\$(\w+)', 'replace': '$\1'},
      \    {'pattern': '\V"\@<!${\(\w\+\)}"\@!', 'replace': '${\1}'},
      \    {'pattern': '\V"${\(\w\+\)}"', 'replace': '"${\1}"'},],
      \ ]},
      \
      \ 'go': {'def': [
      \   ['Print', 'Println', 'Printf'],
      \   ['Fprint', 'Fprintln', 'Fprintf'],
      \   ['Sprint', 'Sprintln', 'Sprintf'],
      \ ]},
      \
      \ 'javascript': {'def': [
      \   ['===', '!=='],
      \   ['var', 'let', 'const'],
      \   ['if', 'else if', 'else'],
      \   ['console.log', 'console.info', 'console.warn'],
      \ ]},
      \ }
