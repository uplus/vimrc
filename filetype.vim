
augroup u10_filetypedetect
  autocmd!
  autocmd BufRead,BufNewFile $ZSH_DOT_DIR/* lcd %:h
  autocmd BufRead,BufNewFile */note/* setf note | lcd %:h
  autocmd BufRead * if isdirectory(expand('%')) | setf vimfiler | endif
augroup END

