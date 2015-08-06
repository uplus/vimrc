" #quickrun
let g:quickrun_no_default_key_mappings = 1

nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
nnoremap \r :write<CR>:QuickRun -mode n<CR>
xnoremap \r :QuickRun -mode v<CR>
nmap \R <Plug>(quickrun)

command! QuickRunStop call quickrun#sweep_sessions()
command! Stop QuickRunStop
command! Spec :write | !rspec %
au uAutoCmd BufWinEnter,BufNewFile *_spec.rb nnoremap <silent><buffer>\r :Spec<CR>
au uAutoCmd FileType vim nnoremap <silent><buffer>\r :.QuickRun<CR>

" Config
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'runner'    : 'vimproc',
      \ 'runner/vimproc/updatetime' : 60,
      \ 'outputter' : 'error',
      \ 'outputter/error/success' : 'buffer',
      \ 'outputter/error/error'   : 'quickfix',
      \ 'outputter/buffer/split'  : ':rightbelow 8sp',
      \ 'outputter/buffer/close_on_empty' : 1,
      \ }

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
"}}}
