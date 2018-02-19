command! -nargs=1 SetTab
      \ let &l:tabstop=<args> |
      \ let &l:softtabstop = &l:tabstop |
      \ let &l:shiftwidth = &l:tabstop
      \ silent! let &l:breakindentopt = &l:tabstop
command! Terminal execute 'terminal' $SHELL
command! Pry botright sp +terminal\ pry
command! Q qall!
command! W w!
command! WWW w !sudo tee > /dev/null %
command! RmSwap if exists('g:swapname') | call system('rm ' . g:swapname) | endif
command! FcitxOff call system('fcitx-remote -c')
command! -nargs=+ Cal echo eval(<q-args>)
command! -nargs=1 Char echo printf("%c", 0x<args>)
command! Cdbuffer cd %:h
command! Lcdbuffer lcd %:h
command! -nargs=* Job call jobstart(<q-args>)
command! RunInTerm let g:quickrun_config._.runner = 'terminal'

command! Recache call dein#recache_runtimepath() | echo 'Recached!'
command! Install call dein#install()
command! Clear   call dein#clear_state()
command! Update  call dein#update()

command! ClearLocList call setloclist(winnr(), [])
command! Tags call Tags()
command! MoveToTab exec "normal! \<c-w>T"
command! Hitest noautocmd runtime syntax/hitest.vim
command! Narrow set laststatus=0 cmdheight=1 showtabline=0
command! ReloadKeymap source ~/.vim/keymap.vim
command! Tig execute "silent! !tig status" | redraw!
command! TmpCommit !git tmpc
command! -nargs=? Ls !ls -F <args>

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
command! -range AddGuiColor <line1>,<line2>call vimrc#add_gui_color()
command! AddRepo call vimrc#add_repo()
command! SyntaxInfo call vimrc#get_syn_info()
command! -complete=highlight -nargs=* Hi call vimrc#highlight(<f-args>)
command! OpenGitDiffWin call vimrc#open_git_diff('w')
command! OpenGitDiffTab call vimrc#open_git_diff('t')
command! Uclear vimrc#undo_clear
command! UndoClear call vimrc#undo_clear()
command! CurrentOnly call vimrc#current_only()
command! ActiveOnly call vimrc#active_only()
command! DeleteTrashBuffers call vimrc#delete_trash_buffers()
command! GitTop execute 'cd' vimrc#git_top()
command! TermRun noautocmd w | call vimrc#terminal_run()
command! BuffersInfo PP vimrc#buffers_info()
command! -nargs=1 ColorTrans echo vimrc#trans_color(<f-args>)

command! -nargs=+ -complete=command
      \ Capture call vimrc#capture(<q-args>)
command! -nargs=+ -complete=command
      \ CaptureWin call vimrc#capture_win(<q-args>)

" zsh like tabedit.
if executable('zsh')
  command! -nargs=1 -complete=customlist,vimrc#zsh_file_completion T tabedit <args>
endif

" #note
command! -nargs=1 -complete=customlist,vimrc#note_file_completion
      \ Note call vimrc#note_open(<q-args>)

" #word translate
let g:word_translate_local_dict = '~/.vim/tmp/gene.dict'
command! -nargs=1 Weblio echo vimrc#word_translate_weblio(<f-args>)
command! -nargs=1 Weblios echo vimrc#word_translate_weblio_smart(<f-args>)
command! -nargs=? WtransLocal call vimrc#word_translate_local_dict(<f-args>)
command! -nargs=? WordTranslate call vimrc#word_translate(<f-args>)
command! -nargs=? GoldenDict call vimrc#goldendict(<f-args>)
