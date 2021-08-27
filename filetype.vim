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

  au BufRead,BufNewFile $HOME/Documents/notes/* call s:note_config()
augroup END

function! s:note_config() abort
  silent! lcd %:h

  if vimrc#capture('verbose setl ft?') !~# 'modeline'
    setf markdown
    setl foldmethod=marker
  endif
endfunction

" #filetype config
augroup myac
  au FileType conf,gitcommit,html,css set nocindent
  au FileType qf,help,vimconsole,narrow,diff,ref-* nnoremap <silent><buffer>q :quit<cr>
  au FileType quickrun,help,diff if has('patch-7.4.2201') | setl signcolumn=no | endif
  au BufReadPost COMMIT_EDITMSG goto

  au StdinReadPost * call s:stdin_config()
  au VimEnter * call s:vimenter()

  " preview window {{{
  if exists('##OptionSet')
    au OptionSet previewwindow,diff call s:quit_map()

    function! s:quit_map() abort
      if &previewwindow || &diff
        nnoremap <silent><buffer>q :quit<cr>
      endif
    endfunction
  endif
  "}}}

  function! s:stdin_config()
    call my#option#set_as_scratch()
    setl nofoldenable
    setl foldcolumn=0
    goto
    silent! %foldopen!
  endfunction

  function! s:vimenter()
    if argc() == 0
      setl buftype=nowrite
    elseif argc() == 1 && !exists('g:swapname')
      " many side effect.
      " e.g invalid behavior smart_quit() of vimfiler.
      " e.g swap, grep
      " lcd %:p:h
    endif
  endfunction
augroup END
