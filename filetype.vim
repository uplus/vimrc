" filetypedetectだとpreciousも平気
" preciousに上書きされることがある

if exists('did_load_filetypes')
  finish
endif

augroup filetypedetect
  " filetypedetectは本体の使い回しなためリセットしてはいけない

  au BufRead,BufNewFile gitconfig setf gitconfig
  au BufRead,BufNewFile .yamllint,.gemrc setf yaml
  au BufRead,BufNewFile .env.*,.envrc,.envrc.* setf sh
  au BufRead,BufNewFile $HOME/Documents/notes/* ++nested call my#note#config()

  " Filetype detect for Assembly Language.
  au BufRead,BufNewFile *.cas setf casl2
  au BufRead,BufNewFile *.asm,*.inc setf masm
  au BufRead,BufNewFile *.[sS] setf gas
  au BufRead,BufNewFile *.hla setf hla
augroup END
