command! Recache call dein#clear_state() | call dein#recache_runtimepath() | echo 'Cached!'
command! Install call dein#install()
command! Clear   call dein#clear_state()
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


" ---- autoload ----
command! AddRepo call u10#add_repo()
command! SyntaxInfo call u10#get_syn_info()
command! -complete=highlight -nargs=* Hi call u10#highlight(<f-args>)
command! OpenGitDiffWin call u10#open_git_diff('w')
command! OpenGitDiffTab call u10#open_git_diff('t')
command! Uclear u10#undo_clear
command! UndoClear :call u10#undo_clear()
command! CurrentOnly call u10#current_only()
command! ActiveOnly call u10#active_only()
command! DeleteTrashBuffers call u10#delete_trash_buffers()
command! GitTop execute 'cd' u10#git_top()
command! TermRun noautocmd w | call u10#terminal_run()
command! BuffersInfo PP u10#buffers_info()

command! -nargs=+ -complete=command
      \ Capture call u10#capture(<q-args>)
command! -nargs=+ -complete=command
      \ CaptureWin call u10#capture_win(<q-args>)

" zsh like tabedit.
if executable('zsh')
  command! -nargs=1 -complete=customlist,u10#zsh_file_completion T tabedit <args>
endif

" #note
command! -nargs=1 -complete=customlist,u10#note_file_completion
      \ Note call u10#note_open(<q-args>)

" #word translate
let g:word_translate_local_dict = '~/.vim/tmp/gene.dict'
command! -nargs=1 Weblio echo u10#word_translate_weblio(<f-args>)
command! -nargs=1 Weblios echo u10#word_translate_weblio_smart(<f-args>)
command! -nargs=? WtransLocal call u10#word_translate_local_dict(<f-args>)
command! -nargs=? WordTranslate call u10#word_translate(<f-args>)
