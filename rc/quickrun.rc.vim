
" #quickrun
let g:quickrun_no_default_key_mappings = 1
let g:unite_quickfix_is_multiline = 0
let g:unite_quickfix_filename_is_pathshorten = 0

nmap \R <Plug>(quickrun-op)
xmap \r <Plug>(quickrun)
nmap <space>\r :update \| QuickRun -mode n -runner terminal<cr>
xmap <space>\r :update \| *QuickRun -mode v -runner terminal<cr>

nnoremap <expr><c-c> SmartQuickRunStop()
function! g:SmartQuickRunStop() abort "{{{
  if exists('*quickrun#is_running') && quickrun#is_running()
    call quickrun#sweep_sessions()
    echo 'QuickRun sweeped'
    return
  else
    return "\<c-c>"
  endif
endfunction "}}}

nnoremap <silent>\r :call SmartQuickRun()<CR>
function! g:SmartQuickRun() "{{{
  update

  " if empty(getloclist('.')) " If error exists, don't run
  echo 'start quickrun'
  if expand('%') =~# '_spec.rb$'
    !rspec %
  else
    QuickRun -mode n
  endif
endfunction "}}}

function! QuickRunHeight(...) abort "{{{
  let l:key = 'hook/unite_quickfix/unite_options'

  if 0 == a:0
    echo g:quickrun_config._[l:key]
  else
    let l:opts = substitute(g:quickrun_config._[l:key], '\v(-winheight\=)\d+', '\1' . a:1, '')
    let g:quickrun_config._[l:key] = l:opts
  endif

  return
endfunction "}}}

command! -nargs=* QuickRunHeight call QuickRunHeight(<f-args>)
command! QuickRunStop call SmartQuickRunStop()
command! Stop QuickRunStop

" Config
let g:quickrun_config   = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'runner':                       'vimproc',
      \ 'runner/vimproc/sleep':         10,
      \ 'runner/vimproc/updatetime':    100,
      \ 'runner/vimproc/read_timeout':  20,
      \
      \ 'outputter':  'buffer',
      \ 'outputter/buffer/split': '%{50 < winheight(0) ? "10" : "5"}sp | echo 1 ||',
      \ 'outputter/buffer/into' : 0,
      \ 'outputter/buffer/name': '[quickrun output]',
      \ 'outputter/buffer/filetype': 'quickrun',
      \ 'outputter/buffer/running_mark' : '(-.-)',
      \ 'outputter/buffer/close_on_empty': 0,
      \
      \ 'outputter/quickfix/open_cmd':     'copen',
      \ 'outputter/quickfix/into':         0,
      \
      \ 'hook/close_quickfix/enable_exit': 0,
      \ 'hook/close_quickfix/enable_success': 0,
      \
      \ 'hook/echo/enable': 1,
      \ 'hook/echo/output_success': 'quickrun success',
      \ 'hook/echo/output_failure': 'quickrun failure',
      \
      \ 'hook/hier_update/enable_exit':        1,
      \ 'hook/hier_update/priority_exit':      3,
      \ 'hook/lightline_update/enable_exit':   1,
      \ 'hook/lightline_update/priority_exit': 1,
      \
      \ 'hook/back_window/enable_exit':    0,
      \ 'hook/back_window/priority_exit':  1,
      \ }

" #languages {{{
let s:config = {
      \ 'c': {'type': 'c/clang'},
      \ 'cpp': {'type': 'cpp/clang'},
      \ 'c/clang': {
      \   'cmdopt': $C_COMP_OPT,
      \   'command': 'clang',
      \   'exec': ['%c %o %s -o %s:p:r', '%s:p:r %a'],
      \   'hook/sweep/files': '%S:p:r',
      \   'tempfile': '%{tempname()}.c',
      \ },
      \ 'cpp/clang': {
      \   'cmdopt': $CPP_COMP_OPT,
      \   'command': 'clang++',
      \   'exec': ['%c %o %s -o %s:p:r', '%s:p:r %a'],
      \   'hook/sweep/files': '%S:p:r',
      \   'tempfile': '%{tempname()}.cpp',
      \ },
      \ 'review': {
      \   'command': 'rake',
      \   'cmdopt': 'clean pdf',
      \   'exec': '%c %o >/dev/null',
      \ },
      \ 'ruby': {'cmdopt' : '-Ku'},
      \ 'ruby/rspec': {
      \   'command': 'bundle',
      \   'exec': '%c exec rspec -f d %s',
      \ },
      \ 'markdown':{'type': 'markdown/previm'},
      \ 'markdown/previm': {
      \   'runner': 'shell',
      \   'outputter': 'null',
      \   'command': ':PrevimOpen',
      \   'exec': '%c',
      \ },
      \ 'go': {'type': 'go/run'},
      \ 'go/run': {
      \   'command': 'go',
      \   'exec': '%c run %s:p:t %a',
      \   'tempfile': '%{tempname()}.go',
      \   'hook/output_encode/encoding': 'utf-8',
      \   'hook/cd/directory': '%S:p:h',
      \ },
      \ 'go/build': {
      \   'command': 'go',
      \   'cmdopt': './...',
      \   'exec': '%c build %o',
      \   'hook/output_encode/encoding': 'utf-8',
      \   'hook/cd/directory': '%S:p:h',
      \ },
      \ 'go/build_run': {
      \   'command': 'go',
      \   'cmdopt': './...',
      \   'exec': ['%c build %o', '%s:p:h:t %a'],
      \   'hook/output_encode/encoding': 'utf-8',
      \   'hook/cd/directory': '%S:p:h',
      \ },
      \ 'go/test': {
      \   'command': 'go',
      \   'cmdopt': './...',
      \   'exec': '%c test %o',
      \   'hook/output_encode/encoding': 'utf-8',
      \   'hook/cd/directory': '%S:p:h',
      \ },
      \ 'rust': {
      \   'type': 'rust/rustc'
      \ },
      \ 'rust/rustc': {
      \   'command': 'rustc',
      \   'exec': ['%c %o %s -o %s:p:r', '%s:p:r %a'],
      \   'cmdopt': $RUSTFLAGS,
      \   'tempfile': '%{tempname()}.rs',
      \   'hook/sweep/files': '%S:p:r',
      \ },
      \ 'rust/cargo': {
      \   'command': 'cargo',
      \   'exec': '%c run %o',
      \ },
      \ 'xmodmap': {
      \   'command': 'xmodmap',
      \   'exec': '%c %o %s',
      \ },
      \ }
call extend(g:quickrun_config, s:config)
unlet s:config
"}}}

" #watchdogs {{{
let s:c_opt_watchdogs = substitute($C_COMP_OPT, '-lm ', '','')
let s:config = {
      \ 'watchdogs_checker/_': {
      \   'runner':                          'vimproc',
      \   'outputter':                       'quickfix',
      \ },
      \
      \ 'c/watchdogs_checker' : {
      \   'type'
      \     : executable('clang') ? 'watchdogs_checker/clang'
      \     : executable('gcc')   ? 'watchdogs_checker/gcc'
      \     :''
      \ },
      \ 'cpp/watchdogs_checker' : {
      \   'type'
      \     : executable('clang-check') ? 'watchdogs_checker/clang_check'
      \     : executable('clang++')     ? 'watchdogs_checker/clang++'
      \     : executable('g++')         ? 'watchdogs_checker/g++'
      \     : executable('cl')          ? 'watchdogs_checker/cl'
      \     :'',
      \ },
      \ 'go/watchdogs_checker': {'type': 'watchdogs_checker/gobuild'},
      \ 'help/watchdogs_checker': {'type': 'watchdogs_checker/non_check'},
      \ 'markdown/watchdogs_checker': {'type': 'watchdogs_checker/non_check'},
      \ 'toml/watchdogs_checker': {'type': 'watchdogs_checker/non_check'},
      \
      \ 'watchdogs_checker/gcc'     : { 'cmdopt': s:c_opt_watchdogs },
      \ 'watchdogs_checker/clang'   : { 'cmdopt': s:c_opt_watchdogs },
      \ 'watchdogs_checker/g++'     : { 'cmdopt': $CPP_COMP_OPT },
      \ 'watchdogs_checker/clang++' : { 'cmdopt': $CPP_COMP_OPT },
      \ 'watchdogs_checker/c89' : {
      \   'command': 'gcc',
      \   'exec': '%c %o -fsyntax-only %s:p',
      \   'cmdopt': s:c_opt_watchdogs . ' -std=c89',
      \ },
      \ 'watchdogs_checker/flake8': {
      \   'cmdopt': '--ignore=' . g:autopep8_ignore  . ' --max-line-length=' . g:autopep8_max_line_length
      \ },
      \ 'watchdogs_checker/gobuild': {
      \   'command': 'go',
      \   'cmdopt' : './...',
      \   'exec': '%c build %o',
      \   'errorformat': '%f:%l: %m,%-G%.%#',
      \   'hook/sweep/files': '%S:p:h/%S:p:h:t',
      \ },
      \ 'watchdogs_checker/vint': {
      \   'command': 'vint',
      \   'exec' : '%c %o %s',
      \   'cmdopt': '--no-color',
      \ },
      \ 'watchdogs_checker/non_check': {
      \   'command': 'echo',
      \   'exec': '%c %o',
      \   'cmdopt': '',
      \ },
      \ 'watchdogs_checker/rustc' : {
      \   'command' : 'rustc',
      \   'exec'    : '%c %o %s:p',
      \   'cmdopt' : '',
      \   'errorformat'
      \     : '%-Gerror: aborting %.%#,'
      \     . '%-Gerror: Could not compile %.%#,'
      \     . '%Eerror: %m,'
      \     . '%Eerror[E%n]: %m,'
      \     . '%Wwarning: ,'
      \     . '%C %#--> %f:%l:%c'
      \ },
      \ 'watchdogs_checker/rustc_parse-only' : {
      \   'command' : 'rustc',
      \   'exec'    : '%c %o %s:p',
      \   'cmdopt' : '',
      \   'errorformat'
      \     : '%E%f:%l:%c: %\d%#:%\d%# %.%\{-}error:%.%\{-} %m'
      \     . ',%W%f:%l:%c: %\d%#:%\d%# %.%\{-}warning:%.%\{-} %m'
      \     . ',%C%f:%l %m'
      \     . ',%-Z%.%#',
      \ },
      \ 'javascript/watchdogs_checker' : {
      \   'type': 'eslint',
      \   'outputter/quickfix/errorformat': '\ \ %l:%c\ \ error\ %m,%-G%.%#',
      \ },
      \}
" call extend(g:quickrun_config, s:config) " これだとイマイチ上手く行かない
call watchdogs#setup(g:quickrun_config)
unlet s:config
"}}}

" #replace_region {{{
let s:config = {
      \ 'replace_region' : {
      \   'outputter'                  : 'error',
      \   'outputter/success'          : 'replace_region',
      \   'outputter/error'            : 'message',
      \   'outputter/message/log'      : 1,
      \   'hook/unite_quickfix/enable' : 0,
      \   'type'                       : 'ruby',
      \ },
      \}

call extend(g:quickrun_config, s:config)
unlet s:config

command! -nargs=* -range -complete=customlist,quickrun#complete
      \ ReplaceRegion QuickRun
      \   -mode v
      \   -outputter error
      \   -outputter/success replace_region
      \   -outputter/error message
      \   -outputter/message/log 1
      \   -hook/unite_quickfix/enable 0
      \   -hook/echo/enable 0
      \   -type ruby
" }}}

" #hooks
" lightline_update {{{
let s:hook = shabadou#make_hook_points_module({
      \ 'name' : 'lightline_update',
      \ 'kind' : 'hook',
      \})

function! s:hook.hook_apply(context)
  call lightline#update()
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
"}}}

" quickrun-hook-clear_quickfix {{{
let s:hook = shabadou#make_hook_points_module({
      \ 'name' : 'clear_quickfix',
      \ 'kind' : 'hook',
      \})

function! s:hook.hook_apply(context)
  if !empty(&g:errorformat)
    silent cgetexpr ""
  endif
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
" }}}



" priority_exit enable_exitの優先順位を数値で指定
" hook/{hook module}/{hook point}

" -create指定しないとハイライトされないときがある
"   有効にするとバッファが作られまくる
"   uniteで最初の行がエラーだとハイライトされる
" topleft 8 にspを付けるとsplitが実行されてlistedbufferになる
" error successで分けるなら処理が終了するのを待たないといけない
" http://d.hatena.ne.jp/osyo-manga/20120919/1348054752

" hookとoutputter/の設定はquickrunの方でやる必要がある
