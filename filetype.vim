" filetypedetectだとpreciousも平気
augroup filetypedetect
  " preciousに上書きされることがある
  au!
  au BufRead,BufNewFile *.hbs setf html
  au BufRead,BufNewFile $ZSH_DOT_DIR/* lcd %:h
  au BufRead,BufNewFile Guardfile setf ruby
  au BufRead,BufNewFile *.cas setf casl2
  au BufRead,BufNewFile,BufWinEnter $HOME/Documents/notes/* call s:note_config()

  au BufRead * if isdirectory(expand('%')) | setf vimfiler | endif
  au VimEnter * if &l:ft == '' | filetype detect | endif
augroup END

function! s:note_config() abort
  lcd %:h
  echomsg 'set ft=markdown'
  if vimrc#capture('verbose setl ft?') !~# 'modeline'
    setf markdown
  endif
endfunction
