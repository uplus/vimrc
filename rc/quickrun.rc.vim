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
au uAutoCmd BufWinEnter,BufNewFile *_spec.rb nnoremap <silent><buffer>\r :update<CR>:!rspec %<CR>
au uAutoCmd FileType vim      nnoremap <silent><buffer>\r :write<CR>:.QuickRun<CR>
au uAutoCmd FileType markdown nnoremap <silent><buffer>\r :write<CR>:PrevimOpen<CR>

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
      \ 'hook/unite_quickfix/unite_options'  : '-no-focus -no-quit -no-empty -direction=botright -auto-resize -create',
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

" ruby {{{
let s:config = {
      \ 'ruby' : {
      \   'cmdopt' : '-Ku',
      \ },
      \ 'ruby/syntax_check' : {
      \ 'command'   : 'ruby',
      \ 'exec'      : '%c %s:p %o',
      \ 'cmdopt'    : '-c',
      \ 'outputter' : 'quickfix',
      \ 'hook/unite_quickfix/enable'       : 0,
      \ 'hook/close_unite_quickfix/enable' : 0,
      \ },
      \}

call extend(g:quickrun_config, s:config)
unlet s:config
"}}}

"}}}
