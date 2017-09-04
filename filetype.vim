" filetypedetectだとpreciousも平気
augroup filetypedetect
  " preciousに上書きされることがある
  au!
  au BufRead,BufNewFile *.hbs setf html
  au BufRead,BufNewFile $ZSH_DOT_DIR/* lcd %:h
  au BufRead,BufNewFile Guardfile setf ruby
  au BufRead,BufNewFile,BufWinEnter $HOME/Documents/notes/* setf markdown | lcd %:h
  au BufRead * if isdirectory(expand('%')) | setf vimfiler | endif
  au VimEnter * if &l:ft == '' | filetype detect | endif

  " for ftplugin.toml
  au FileType toml if expand('%:p') =~# expand('~/.vim') |
        \ let b:context_filetype_filetypes = {'toml': [
        \   { 'start': '\s*=\s*\('."'''".'\|"""\)',
        \     'end': '\1', 'filetype': 'vim', },
        \ ]} |
        \ endif
augroup END
