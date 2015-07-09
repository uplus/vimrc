" #quickrun
let g:quickrun_no_default_key_mappings = 1
nnoremap <Leader>r :write<CR>:QuickRun -mode n<CR>
xnoremap <Leader>r :write<CR>:QuickRun -mode v<CR>

" Config
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'hook/close_unite_quickfix/enable_hook_loaded' : 1,
      \ 'hook/unite_quickfix/enable_failure'   : 1,
      \ 'hook/close_quickfix/enable_exit'      : 1,
      \ 'hook/close_buffer/enable_failure'     : 1,
      \ 'hook/close_buffer/enable_empty_data'  : 1,
      \ 'hook/shabadoubi_touch_henshin/enable' : 1,
      \ 'hook/shabadoubi_touch_henshin/wait'   : 20,
      \ 'outputter/buffer/split' : ':botright 8sp',
      \ 'outputter'              : 'multi:buffer:quickfix',
      \ 'runner'                 : 'vimproc',
      \ 'runner/vimproc/updatetime' : 40,
      \ }


" Languages
let g:quickrun_config.cpp = {
      \ 'command' : '/usr/bin/clang++',
      \ 'cmdopt'  : $CPP_COMP_OPT
      \ }

let g:quickrun_config.c = {
      \ 'command' : '/usr/bin/clang',
      \ 'cmdopt'  : $C_COMP_OPT
      \ }
let g:quickrun_config.markdown = {
      \ 'type'      : 'markdown/pandoc',
      \ 'cmdopt'    : '-s',
      \ 'outputter' : 'browser'
      \ }


" RSpec実行
function! RSpec_run()
  write
  !rspec %
endfunction
command! Spec :call RSpec_run()

autocmd BufWinEnter,BufNewFile *_spec.rb nnoremap <buffer>\r :call RSpec_run()<CR>

