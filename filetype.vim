" filetypedetectだとpreciousも平気
" preciousに上書きされることがある

augroup filetypedetect
  " filetypedetectは本体の使い回しなためリセットしてはいけない

  au BufRead,BufNewFile gitconfig setf gitconfig
  au BufRead,BufNewFile .yamllint,.gemrc setf yaml
  au BufRead,BufNewFile .env.*,.envrc,.envrc.* setf sh
  au BufRead,BufNewFile Dockerfile* setf dockerfile
  au BufRead,BufNewFile $HOME/Documents/notes/* ++nested call my#note#config()
  au BufRead,BufNewFile fluent.conf setf xml " 違うけど
augroup END
