
augroup filetypedetect
  autocmd!
  autocmd BufRead,BufNewFile */memo/* setf memo | lcd %:h
  autocmd BufRead * if isdirectory(expand('%')) | setf vimfiler | endif
augroup END

