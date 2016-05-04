" #quickrun
let g:quickrun_no_default_key_mappings = 1
let g:unite_quickfix_is_multiline = 0
let g:unite_quickfix_filename_is_pathshorten = 0

nnoremap <expr><silent><c-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<c-c>"
nmap \R <Plug>(quickrun-op)
xmap \r <Plug>(quickrun)

nnoremap <silent>\r :call SmartQuickRun()<CR>
function! g:SmartQuickRun()
  update
  " if empty(getloclist('.'))
  echo "start quickrun"
  QuickRun -mode n
  " endif
endfunction

command! QuickRunStop call quickrun#sweep_sessions()
command! Stop QuickRunStop
au u10ac BufWinEnter,BufNewFile *_spec.rb nnoremap <silent><buffer>\r :update<CR>:!rspec %<CR>
au u10ac FileType vim      nnoremap <silent><buffer>\r :write<CR>:.QuickRun<CR>
au u10ac FileType markdown nnoremap <silent><buffer>\r :write<CR>:PrevimOpen<CR>

" Config
let g:quickrun_config   = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'runner' : 'vimproc',
      \ 'runner/vimproc/updatetime' : 60,
      \ 'outputter' : 'quickfix',
      \ 'outputter/buffer/close_on_empty'   : 1,
      \ 'outputter/quickfix/into'           : 0,
      \ 'hook/close_quickfix/enable_exit'   : 1,
      \ 'hook/close_unite_quickfix/enable_module_loaded' : 1,
      \ 'hook/clear_quickfix/enable_hook_loaded'         : 1,
      \ 'hook/unite_quickfix/enable_exit'    : 1,
      \ 'hook/unite_quickfix/unite_options'  : '-no-focus -no-quit -no-empty -direction=botright -create -winheight=10',
      \ 'hook/unite_quickfix/priority_exit'  : 0,
      \ 'hook/unite_quickfix/no_focus'       : 1,
      \ }
      " 'outputter/quickfix/open_cmd'       : 'Quickfix',
      " -createを指定することで再実行した時に-no-focusでもハイライトを有効に
      " topleft 8 にspを付けるとsplitが実行されてlistedbufferになる

let g:quickrun_config['watchdogs_checker/_'] = {
      \ 'hook/close_unite_quickfix/enable_module_loaded'  : 1,
      \ 'hook/clear_quickfix/enable_hook_loaded'          : 1,
      \ 'hook/unite_quickfix/enable_exit'                 : 1,
      \ 'hook/back_window/enable_exit'             : 0,
      \ 'hook/back_window/priority_exit'           : 1,
      \ 'hook/quickfix_status_enable/enable_exit'  : 1,
      \ 'hook/quickfix_status_enable/priority_exit': 2,
      \ 'hook/hier_update/enable_exit'             : 1,
      \ 'hook/hier_update/priority_exit'           : 3,
      \ }

let g:quickrun_config['c/watchdogs_checker'] = {
      \ 'command': 'clang',
      \ 'exec': '%c %o -fsyntax-only %s:p',
      \ 'cmdopt': substitute($C_COMP_OPT, '-lm ', '',''),
      \ }

let g:quickrun_config['cpp/watchdogs_checker'] = {
      \ 'command': 'clang++',
      \ 'exec': '%c %o -fsyntax-only %s:p',
      \ 'cmdopt': $CPP_COMP_OPT,
      \ }

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

