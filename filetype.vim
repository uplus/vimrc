au FileType c,cpp,ruby,zsh,php,perl set cindent
au FileType gitcommit goto 1
au FileType vim nnoremap <silent> gca A<Tab>"<Space>
au FileType c,cpp set commentstring=//\ %s
au FileType html,css set foldmethod=indent

"binary edit mode (xxd) vim -b で起動、もしくは *.bin ファイルを開くと発動
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END
