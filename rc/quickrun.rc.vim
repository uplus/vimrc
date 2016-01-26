" #quickrun
let g:quickrun_no_default_key_mappings = 1
let g:unite_quickfix_is_multiline = 0
let g:unite_quickfix_filename_is_pathshorten = 0
let g:unite#filters#converter_quickfix_highlight#enable_bold_for_message = 1

nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
xnoremap \r :QuickRun -mode v<CR>
nmap \R <Plug>(quickrun-op)

nnoremap <silent>\r :call SmartQuickRun()<CR>
function! g:SmartQuickRun()
  write
  if empty(getloclist('.'))
    echo "start quickrun"
    QuickRun -mode n
  endif
endfunction

command! QuickRunStop call quickrun#sweep_sessions()
command! Stop QuickRunStop
command! Spec :write | !rspec %
au uAutoCmd BufWinEnter,BufNewFile *_spec.rb nnoremap <silent><buffer>\r :Spec<CR>
au uAutoCmd FileType vim nnoremap <silent><buffer>\r :write<CR>:.QuickRun<CR>
au uAutoCmd FileType markdown noremap <silent><buffer>\r :write<CR>:PrevimOpen<CR>

au uAutoCmd FileType quickrun call s:quickrun_config()
function! s:quickrun_config()
  setl buftype=nofile
  nnoremap <silent><buffer>q <C-w>q
  au BufEnter <buffer> if winnr('$') == 1 | quit | endif
endfunction

" Config
let g:quickrun_config   = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'runner'                  : 'vimproc',
      \ 'runner/vimproc/updatetime' : 60,
      \ 'outputter'               : 'error',
      \ 'outputter/error/success' : 'buffer',
      \ 'outputter/error/error'   : 'quickfix',
      \ 'outputter/buffer/split'  : 'botright 8sp `=a:config.name` | echo 1 ||',
      \ 'outputter/buffer/close_on_empty' : 1,
      \ 'hook/close_unite_quickfix/enable_module_loaded' : 1,
      \ 'hook/clear_quickfix/enable_hook_loaded'         : 1,
      \ 'hook/hier_update/enable_exit'       : 1,
      \ 'hook/close_quickfix/enable_exit'    : 1,
      \ 'hook/close_buffer/enable_failure'   : 1,
      \ 'hook/unite_quickfix/enable_failure' : 1,
      \ 'hook/unite_quickfix/priority_exit'  : 0,
      \ 'hook/unite_quickfix/no_focus'       : 1,
      \ 'hook/unite_quickfix/unite_options'  : '-no-quit -no-empty -direction=botright -create -winheight=12',
      \ }
      " -createを指定することで再実行した時に-no-focusでもハイライトを有効に
      " -direction=botrightで標示順序が逆になるのはsorter_reverseで解決
      " -buffer-name を変えると自動で閉じない
      " Todo: split って名前の無駄なバッファが作られる
      " 原因はquickrun側で sp 'split' execute `=edit a:config.name` としてるからバッファ名が食い違う
      " 後続の splitを無効化することで回避

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
    cgetexpr ""
  endif
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
" }}}

" Languages "{{{
let g:quickrun_config.c = {
      \ 'command' : '/usr/bin/clang',
      \ 'cmdopt'  : $C_COMP_OPT
      \ }
let g:quickrun_config.cpp = {
      \ 'command' : '/usr/bin/clang++',
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
