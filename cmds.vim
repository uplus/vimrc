command! Recache call dein#clear_state() | call dein#recache_runtimepath() " | UpdateRemotePlugins
command! Q qall!
command! W w!
command! Sh update | shell
command! ReloadKeymap source ~/.vim/keymap.vim
command! Tig execute "silent! !tig status" | redraw!
command! TmpCommit !git tmpc
command! WWW w !sudo tee > /dev/null %
command! Cdbuffer cd %:h
command! Lcdbuffer lcd %:h
command! -nargs=? Ls !ls -F --color=always <args>
command! -nargs=+ Cal echo eval(<q-args>)
command! Zatof normal! 0diwf=cl()lxC{Px>>o}
command! Narrow set laststatus=0 cmdheight=1 showtabline=0
command! -nargs=* Job call jobstart(<q-args>)
command! -nargs=1 Char echo printf("%c", 0x<args>)
command! Rmswap if exists('g:swapname') | call system('rm ' . g:swapname) | endif
command! FcitxOff call system('fcitx-remote -c')
