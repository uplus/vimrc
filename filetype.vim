" filetypedetectだとpreciousも平気
" preciousに上書きされることがある

if exists('did_load_filetypes')
  finish
endif

augroup filetypedetect
  au!

  au BufRead,BufNewFile *.cas setf casl2
  au BufRead,BufNewFile Guardfile setf ruby

  " Filetype detect for Assembly Language.
  au BufRead,BufNewFile *.asm set ft=masm syntax=masm
  au BufRead,BufNewFile *.inc set ft=masm syntax=masm
  au BufRead,BufNewFile *.[sS] set ft=gas syntax=gas
  au BufRead,BufNewFile *.hla set ft=hla syntax=hla

  au BufRead,BufNewFile $ZSH_DOT_DIR/* lcd %:h
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
