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
command! Let2Var s/\vlet\!?\(:([^)]*)\)\s*\{\s*([^}]*)\s*\}/\1 = \2/

" #encoding Reopening with a specific character."{{{
" In particular effective when I am garbled in a terminal.
command! -bang -bar -complete=file -nargs=? Utf8      edit<bang> ++enc=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Iso2022jp edit<bang> ++enc=iso-2022-jp <args>
command! -bang -bar -complete=file -nargs=? Cp932     edit<bang> ++enc=cp932 <args>
command! -bang -bar -complete=file -nargs=? Euc       edit<bang> ++enc=euc-jp <args>
command! -bang -bar -complete=file -nargs=? Utf16     edit<bang> ++enc=ucs-2le <args>
command! -bang -bar -complete=file -nargs=? Utf16be   edit<bang> ++enc=ucs-2 <args>

" Aliases.
command! -bang -bar -complete=file -nargs=? Jis     Iso2022jp<bang> <args>
command! -bang -bar -complete=file -nargs=? Sjis    Cp932<bang> <args>
command! -bang -bar -complete=file -nargs=? Unicode Utf8<bang> <args>
"}}}


" #autoload
command! AddRepo call u10#add_repo()

