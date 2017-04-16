
augroup my_filetypedetect
  autocmd!
  autocmd BufRead,BufNewFile $ZSH_DOT_DIR/* lcd %:h
  autocmd BufRead,BufNewFile $HOME/Documents/notes/* setf note | lcd %:h
  autocmd BufRead * if isdirectory(expand('%')) | setf vimfiler | endif
  autocmd VimEnter * if &ft == '' | filetype detect | endif
augroup END
