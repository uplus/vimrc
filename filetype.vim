autocmd FileType c,cpp,ruby,zsh,php,perl set cindent
autocmd FileType gitcommit goto 1
autocmd FileType vim nnoremap <silent> gca A<Tab>"<Space>
au FileType c,cpp set commentstring=//\ %s
