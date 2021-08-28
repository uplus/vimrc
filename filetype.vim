" filetypedetectだとpreciousも平気
" preciousに上書きされることがある

if exists('did_load_filetypes')
  finish
endif

augroup filetypedetect
  " filetypedetectは本体の使い回しなためリセットしてはいけない

  " Filetype detect for Assembly Language.
  au BufRead,BufNewFile *.cas setf casl2
  au BufRead,BufNewFile *.asm,*.inc setf masm
  au BufRead,BufNewFile *.[sS] setf gas
  au BufRead,BufNewFile *.hla setf hla

  au BufRead,BufNewFile gitconfig setf gitconfig
  au BufRead,BufNewFile .yamllint,.gemrc setf yaml
  au BufRead,BufNewFile .env,.env.*,.envrc,.envrc.* setf sh
  au BufRead,BufNewFile Guardfile,Vagrantfile setf ruby
  au BufRead,BufNewFile $HOME/Documents/notes/* call my#note#config()
augroup END
