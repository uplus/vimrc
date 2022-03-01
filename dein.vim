" Dein.vim:

" install
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = expand('$CACHE/dein') . '/repos/github.com/Shougo/dein.vim'

  if !isdirectory(s:dein_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . s:dein_dir)
  endif

  execute ' set runtimepath^=' . s:dein_dir
endif

" config
let g:dein#auto_recache = v:false
let g:dein#install_progress_type = 'floating'
let g:dein#enable_notification = v:true
let g:dein#notification_time = 5
let g:dein#install_log_filename = '~/.vim/tmp/dein.log'

" load plugins
let s:path = expand('$CACHE/dein')
if !dein#load_state(s:path)
  finish
endif

let s:dein_normal      = '~/.vim/plugins/normal.toml'
let s:dein_to_op       = '~/.vim/plugins/to-op.toml'
let s:dein_colorscheme = '~/.vim/plugins/colorscheme.toml'
let s:dein_input       = '~/.vim/plugins/input.toml'
let s:dein_lazy        = '~/.vim/plugins/lazy.toml'
let s:dein_filetypes   = '~/.vim/plugins/filetypes.toml'
let s:dein_ftplugin    = '~/.vim/plugins/ftplugin.toml'
let s:dein_trial       = '~/.vim/plugins/trial.toml'

call dein#begin(s:path, [expand('<sfile>'),
  \   s:dein_lazy, s:dein_filetypes, s:dein_normal, s:dein_to_op, s:dein_colorscheme, s:dein_input,
  \   s:dein_ftplugin
  \ ])

call dein#load_toml(s:dein_ftplugin,    { 'lazy': 0 })
call dein#load_toml(s:dein_lazy,        { 'lazy': 1 })
call dein#load_toml(s:dein_filetypes,   { 'lazy': 0 })
call dein#load_toml(s:dein_normal,      { 'lazy': 0 })
call dein#load_toml(s:dein_to_op,       { 'lazy': 0 })
call dein#load_toml(s:dein_colorscheme, { 'lazy': 0 })
call dein#load_toml(s:dein_input,       { 'lazy': 0 })
call dein#load_toml(s:dein_trial,       { 'lazy': 0, 'merged': 0 })

" disable plugins for debug
if filereadable(expand('~/.vim/disable-plugin-list'))
  for plugin in readfile(expand('~/.vim/disable-plugin-list'))
    if plugin =~# '^#'
      continue
    endif

    call dein#disable(plugin)
  endfor
endif

call dein#end()
call dein#save_state()

if !has('vim_starting') && dein#check_install()
  " Installation check.
  call dein#install()
endif
