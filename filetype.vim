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

" #filetype config
augroup myac
  au FileType conf,gitcommit,html,css set nocindent
  au FileType qf,help,vimconsole,narrow,diff,ref-* nnoremap <silent><buffer>q :quit<cr>
  au FileType quickrun,help,diff setl signcolumn=no
  au BufReadPost COMMIT_EDITMSG goto
  au OptionSet previewwindow,diff if v:option_new | nnoremap <silent><buffer>q :quit<cr> | endif
augroup END
