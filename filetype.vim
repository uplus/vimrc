au FileType c,cpp,ruby,zsh,php,perl set cindent
au FileType vim nnoremap <silent> gca A<Tab>"<Space>
au FileType c,cpp set commentstring=//\ %s
au FileType html,css set foldmethod=indent

au FileType gitcommit call s:gitcommit_config()
function! s:gitcommit_config()
  nnoremap Q <ESC>:wq
  nnoremap W <ESC>:wq
  goto 1
endfunction

autocmd FileType help call s:help_config()
function! s:help_config()
  nnoremap <buffer> q :q<CR>
  setlocal foldmethod=indent
  setlocal foldlevel=1
  setlocal foldenable
endfunction
