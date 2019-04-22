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
  au BufRead,BufNewFile .env.* set ft=sh syntax=sh

  au BufRead,BufNewFile $HOME/Documents/notes/* call s:note_config()

  au BufRead * if isdirectory(expand('%')) | setf vimfiler | endif
  au VimEnter * if &l:ft ==# '' | filetype detect | endif
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
  au FileType html,css setl foldmethod=indent | setl foldlevel=20
  au FileType qf,help,vimconsole,diff,ref-* nnoremap <silent><buffer>q :quit<cr>
  au FileType conf,gitcommit,html,css set nocindent
  au FileType gundo,vimfiler,quickrun setl foldcolumn=0
  au FileType gundo,vimfiler,quickrun,help,diff if has('patch-7.4.2201') | setl signcolumn=no | endif

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

  function! s:stdin_config() "{{{
    call SetAsScratch()
    setl nofoldenable
    setl foldcolumn=0
    goto
    silent! %foldopen!
  endfunction "}}}

  function! s:vimenter() "{{{
    if argc() == 0
      setl buftype=nowrite
    elseif argc() == 1 && !exists('g:swapname')
      " many side effect.
      " e.g invalid behavior smart_quit() of vimfiler.
      " e.g swap, grep
      " lcd %:p:h
    endif
  endfunction "}}}
augroup END
