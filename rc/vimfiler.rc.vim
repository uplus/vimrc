let g:vimfiler_sendto = {
      \ 'unzip' : 'unzip %f',
      \ 'zip' : 'zip -r %F.zip %*',
      \ 'Inkscape' : 'inkspace',
      \ 'GIMP' : 'gimp %*',
      \ 'gedit' : 'gedit',
      \ }

function! s:smart_quit()
  if argc() == 0 || isdirectory(argv(0)) || vimrc#buffer_count('l') == 0
    quit
  else
    call vimfiler#util#hide_buffer()
  endif
endfunction
