
" #quickrun
let g:quickrun_no_default_key_mappings = 1

command! QuickRunInTerm let g:quickrun_config._.runner = 'my_terminal'

nmap \R <Plug>(quickrun-op)
xmap \r <Plug>(quickrun)
nmap <space>\r :update \| QuickRun -mode n -runner my_terminal<cr>
xmap <space>\r :update \| *QuickRun -mode v -runner my_terminal<cr>

" nnoremap <expr><c-c> QuickRunStop()
command! QuickRunStop call QuickRunStop()

function! g:QuickRunStop() abort "{{{
  if exists('*quickrun#is_running') && quickrun#is_running()
    call quickrun#sweep_sessions()
    echo 'QuickRun sweeped'
    return
  else
    return "\<c-c>"
  endif
endfunction "}}}

nnoremap <silent>\r :call SmartQuickRun()<CR>
function! g:SmartQuickRun() abort "{{{
  update

  " if empty(getloclist('.')) " If error exists, don't run
  echo 'start quickrun'
  if expand('%') =~# '_spec.rb$'
    !rspec %
  else
    QuickRun -mode n
  endif
endfunction "}}}


" Config
let g:quickrun_config   = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'runner':                       'my_terminal',
      \ 'runner/my_terminal/opener':    'new',
      \ 'runner/my_terminal/into':      0,
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
      \ 'markdown':{'type': 'markdown/mkdp'},
      \ 'markdown/mkdp': {
      \   'runner': 'shell',
      \   'outputter': 'null',
      \   'command': ':MarkdownPreview',
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
      \   'type':
      \     filereadable('Cargo.toml') ? 'rust/cargo' :
      \     'rust/rustc',
      \ },
      \ 'rust/rustc': {
      \   'command': 'rustc',
      \   'exec': ['%c %o %s -o %s:p:r', '%s:p:r %a'],
      \   'cmdopt': '-O ' . $RUSTFLAGS,
      \   'tempfile': '%{tempname()}.rs',
      \   'hook/sweep/files': '%S:p:r',
      \ },
      \ 'rust/cargo': {
      \   'command': 'cargo',
      \   'exec': '%c run %o',
      \ },
      \ 'scala': {'type': (findfile('build.sbt', '.;') ==# '')? 'scala/scala-cli' : 'scala/sbt' },
      \ 'scala/sbt': {
      \   'command': 'sbt',
      \   'exec': '%c run %o',
      \ },
      \ 'scala/scala-cli': {
      \   'command': 'scala-cli',
      \   'exec': '%c %o %s',
      \ },
      \ 'xmodmap': {
      \   'command': 'xmodmap',
      \   'exec': '%c %o %s',
      \ },
      \ }
call extend(g:quickrun_config, s:config)
unlet s:config
"}}}

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
" topleft 8 にspを付けるとsplitが実行されてlistedbufferになる
" error successで分けるなら処理が終了するのを待たないといけない
" http://d.hatena.ne.jp/osyo-manga/20120919/1348054752

" hookとoutputter/の設定はquickrunの方でやる必要がある
