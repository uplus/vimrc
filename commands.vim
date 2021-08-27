command! -nargs=1 SetTab call my#option#set_tab(<args>)
command! Q qall!
command! W w!
command! Naw noautocmd write
command! RmSwap if exists('g:swapname') | call system('rm ' . g:swapname) | endif
command! -nargs=1 Char echo printf("%c", 0x<args>)
command! Cdbuffer cd %:h
command! Lcdbuffer lcd %:h
command! -nargs=* Job call jobstart(<q-args>)
command! RunInTerm let g:quickrun_config._.runner = 'terminal'

command! ClearLocList call setloclist(winnr(), [])
command! Tags call Tags()
command! Hitest noautocmd runtime syntax/hitest.vim
command! Narrow set laststatus=0 cmdheight=1 showtabline=0
command! ReloadKeymap source ~/.vim/keymaps.vim
" 一時的なバッファーを作る
command! TmpBuffer exec winheight(0)/5 . 'new +call\ SetAsScratch()'
" 句読点を論文用に置換する
command! ReplacePunctuation %s/\v(、|。)/\=tr(submatch(1), '、。', '，．')
" 編集したら随時diffを表示するバッファーを作る
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
" g<c-g>は改行を含めてしまう
command! -range=% CountChar <line1>,<line2>s/.//ggn

" external command
command! FcitxOff call Job('fcitx5-remote', '-c')
command! TmpCommit Gina tmpc

" Encoding:
command! -bang -bar -complete=file -nargs=? EncodeUtf8      edit<bang> ++enc=utf-8 <args>
command! -bang -bar -complete=file -nargs=? EncodeIso2022jp edit<bang> ++enc=iso-2022-jp <args>
command! -bang -bar -complete=file -nargs=? EncodeCp932     edit<bang> ++enc=cp932 <args>
command! -bang -bar -complete=file -nargs=? EncodeEuc       edit<bang> ++enc=euc-jp <args>
command! -bang -bar -complete=file -nargs=? EncodeUtf16     edit<bang> ++enc=ucs-2le <args>
command! -bang -bar -complete=file -nargs=? EncodeUtf16be   edit<bang> ++enc=ucs-2 <args>
command! -bang -bar -complete=file -nargs=? EncodeJis       EncodeIso2022jp<bang> <args>
command! -bang -bar -complete=file -nargs=? EncodeSjis      EncodeCp932<bang> <args>
command! -bang -bar -complete=file -nargs=? EncodeUnicode   EncodeUtf8<bang> <args>

" Autoload:
command! AddRepo call vimrc#add_repo()
command! -complete=highlight -nargs=* Hi call vimrc#highlight(<f-args>)
command! OpenGitDiffWin call vimrc#open_git_diff('w')
command! OpenGitDiffTab call vimrc#open_git_diff('t')
command! UndoClear call vimrc#undo_clear()
command! ActiveOnly call my#buffer#active_only()
command! DeleteTrashBuffers call my#buffer#delete_trash_buffers()
command! GitTop execute 'cd' vimrc#git_top()
command! TermRun noautocmd w | call vimrc#terminal_run()

command! -nargs=1 -complete=customlist,my#note#file_completion Note call my#note#open(<q-args>)
command! -nargs=+ -complete=command Capture call vimrc#capture(<q-args>)
command! -nargs=+ -complete=command CaptureWin call vimrc#capture_win(<q-args>)

" " zsh like tabedit.
" if executable('zsh')
"   command! -nargs=1 -complete=customlist,vimrc#zsh_file_completion T tabedit <args>
" endif
