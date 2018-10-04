" filetypedetectだとpreciousも平気
" preciousに上書きされることがある

if exists('did_load_filetypes')
  finish
endif

augroup filetypedetect
  " 使い回し
  " au!

  au BufRead,BufNewFile *.cas setf casl2
  au BufRead,BufNewFile Guardfile setf ruby
  au BufRead,BufNewFile gitconfig setf gitconfig

  " Filetype detect for Assembly Language.
  au BufRead,BufNewFile *.asm set ft=masm syntax=masm
  au BufRead,BufNewFile *.inc set ft=masm syntax=masm
  au BufRead,BufNewFile *.[sS] set ft=gas syntax=gas
  au BufRead,BufNewFile *.hla set ft=hla syntax=hla
  au BufRead,BufNewFile .yamllint set ft=yaml syntax=yaml

  au BufRead,BufNewFile $HOME/Documents/notes/* call s:note_config()

  au BufRead * if isdirectory(expand('%')) | setf vimfiler | endif
  au VimEnter * if &l:ft ==# '' | filetype detect | endif
augroup END

function! s:note_config() abort
  lcd %:h
  if vimrc#capture('verbose setl ft?') !~# 'modeline'
    setf markdown
    setl fdm=marker
  endif
endfunction
