" #quickrun
let g:quickrun_no_default_key_mappings = 1
let g:unite_quickfix_is_multiline = 0
let g:unite_quickfix_filename_is_pathshorten = 0

nmap \R <Plug>(quickrun-op)
xmap \r <Plug>(quickrun)

nnoremap <expr><c-c> SmartQuickRunStop()
function! g:SmartQuickRunStop() abort
  if exists('*quickrun#is_running') && quickrun#is_running()
    call quickrun#sweep_sessions()
    echo 'QuickRun sweeped'
    return
  else
    return "\<c-c>"
  endif
endfunction

nnoremap <silent>\r :call SmartQuickRun()<CR>
function! g:SmartQuickRun()
  update

  " if empty(getloclist('.')) " If error exists, don't run
  echo "start quickrun"
  if &ft == 'vim'
    .QuickRun
  elseif &ft == 'markdown'
    PrevimOpen
  elseif expand('%') =~ '_spec.rb$'
    !rspec %
  else
    QuickRun -mode n
  endif
endfunction

function! QuickRunHeight(...) abort
  let l:key = 'hook/unite_quickfix/unite_options'

  if 0 == a:0
    echo g:quickrun_config._[l:key]
  else
    let l:opts = substitute(g:quickrun_config._[l:key], '\v(-winheight\=)\d+', '\1' . a:1, '')
    let g:quickrun_config._[l:key] = l:opts
  endif

  return
endfunction

command! -nargs=* QuickRunHeight call QuickRunHeight(<f-args>)
command! QuickRunStop call SmartQuickRunStop()
command! Stop QuickRunStop

" Config
let g:quickrun_config   = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'runner' : 'vimproc',
      \ 'runner/vimproc/sleep': 10,
      \ 'runner/vimproc/updatetime' : 50,
      \ 'runner/vimproc/read_timeout': 100,
      \ 'outputter' : 'quickfix',
      \ 'outputter/buffer/close_on_empty'   : 1,
      \ 'outputter/quickfix/into'           : 0,
      \ 'hook/close_quickfix/enable_exit'   : 1,
      \ 'hook/close_unite_quickfix/enable_module_loaded' : 1,
      \ 'hook/unite_quickfix/enable_exit'    : 1,
      \ 'hook/unite_quickfix/unite_options'  : '-no-focus -no-quit -no-empty -direction=botright -create -winheight=10',
      \ 'hook/unite_quickfix/priority_exit'  : 0,
      \ 'hook/unite_quickfix/no_focus'       : 1,
      \ }
      " 'outputter/quickfix/open_cmd'       : 'Quickfix',
      " -createを指定することで再実行した時に-no-focusでもハイライトを有効に
      " topleft 8 にspを付けるとsplitが実行されてlistedbufferになる

function! s:make_hook_points_module(base)
  return shabadou#make_hook_points_module(a:base)
endfunction

" replace_region {{{
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

" quickrun-hook-clear_quickfix {{{
let s:hook = s:make_hook_points_module({
      \ "name" : "clear_quickfix",
      \ "kind" : "hook",
      \})

function! s:hook.hook_apply(context)
  if !empty(&g:errorformat)
    silent cgetexpr ""
  endif
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
" }}}

" Languages "{{{
let g:quickrun_config.c = {
      \ 'command' : 'clang',
      \ 'cmdopt'  : $C_COMP_OPT
      \ }
let g:quickrun_config.cpp = {
      \ 'command' : 'clang++',
      \ 'cmdopt'  : $CPP_COMP_OPT
      \ }
let g:quickrun_config.markdown = {
      \ 'type'      : 'markdown/pandoc',
      \ 'cmdopt'    : '-s',
      \ 'outputter' : 'browser'
      \ }

let g:quickrun_config.ruby = {
      \ 'cmdopt' : '-Ku'
      \ }

let g:quickrun_config.rspec = {
      \ 'command': 'bundle',
      \ 'exec': '%c exec rspec -f d %s'
      \ }
"}}}


" watchdogs
let s:c_opt = substitute($C_COMP_OPT, '-lm ', '','')

let s:config = {
      \ 'watchdogs_checker/_' : {
      \   'hook/close_unite_quickfix/enable_module_loaded'  : 1,
      \   'hook/unite_quickfix/enable_exit'                 : 1,
      \   'hook/back_window/enable_exit'             : 0,
      \   'hook/back_window/priority_exit'           : 1,
      \   'hook/quickfix_status_enable/enable_exit'  : 1,
      \   'hook/quickfix_status_enable/priority_exit': 2,
      \   'hook/hier_update/enable_exit'             : 1,
      \   'hook/hier_update/priority_exit'           : 3,
      \ },
      \	'c/watchdogs_checker' : {
      \		'type'
      \			: executable('clang') ? 'watchdogs_checker/clang'
      \			: executable('gcc')   ? 'watchdogs_checker/gcc'
      \			:''
      \	},
      \	'cpp/watchdogs_checker' : {
      \		'type'
      \			: executable('clang-check') ? 'watchdogs_checker/clang_check'
      \			: executable('clang++')     ? 'watchdogs_checker/clang++'
      \			: executable('g++')         ? 'watchdogs_checker/g++'
      \			: executable('cl')          ? 'watchdogs_checker/cl'
      \			:'',
      \	},
      \	'watchdogs_checker/gcc'     : { 'cmdopt': s:c_opt },
      \	'watchdogs_checker/clang'   : { 'cmdopt': s:c_opt },
      \	'watchdogs_checker/g++'     : { 'cmdopt': $CPP_COMP_OPT },
      \	'watchdogs_checker/clang++' : { 'cmdopt': $CPP_COMP_OPT },
      \ 'watchdogs_checker/c89' : {
      \   'command': 'gcc',
      \   'exec': '%c %o -fsyntax-only %s:p',
      \   'cmdopt': s:c_opt . ' -std=c89',
      \ },
      \ 'watchdogs_checker/flake8': {
      \   'cmdopt': '--ignore=' . g:autopep8_ignore  . ' --max-line-length=' . g:autopep8_max_line_length
      \ },
      \}

call extend(g:quickrun_config, s:config)
unlet s:config
