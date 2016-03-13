" Dein.vim:

let s:dein_dir = expand('$CACHE/dein') . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif
  execute ' set runtimepath^=' . s:dein_dir
  let g:loaded_neobundle = 1
endif

let s:path = expand('$CACHE/dein')
let s:toml_path = '~/.vim/dein.toml'
let s:toml_lazy_path = '~/.vim/deinlazy.toml'

call dein#begin(s:path)
if dein#load_cache([expand('<sfile>'), s:toml_path, s:toml_lazy_path])
  call dein#load_toml(s:toml_path, {'lazy': 0})
  call dein#load_toml(s:toml_lazy_path, {'lazy' : 1})
  call dein#save_cache()
endif

call dein#end()

if has('vim_starting') && dein#check_install()
  call dein#install()
endif
