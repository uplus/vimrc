" Command:

" Misc:
command! Q qall!
command! W w!
command! Naw noautocmd write
command! Narrow set laststatus=0 cmdheight=1 showtabline=0
command! RmSwap if exists('g:swapname') | call system('rm ' . g:swapname) | endif
command! ClearLocList call setloclist(winnr(), [])
command! -nargs=1 Char echo printf("%c", 0x<args>)
command! -nargs=* Job call jobstart(<q-args>)
" 全ハイライトを確認するバッファーを生成する
command! Hitest noautocmd runtime syntax/hitest.vim
" 一時的なバッファーを作る
command! TmpBuffer execute winheight(0)/5 . 'new +call\ my#option#set_as_scratch()'
command! Mksession mksession! .session.vim
command! Cpbufname let @+=bufname()

" 句読点を論文用に置換する
command! ReplacePunctuation %s/\v(、|。)/\=tr(submatch(1), '、。', '，．')
" 編集したら随時diffを表示するバッファーを作る
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
" g<c-g>は改行を含めてしまう
command! -range=% CountChar <line1>,<line2>s/.//ggn
command! FcitxOff call Job('fcitx5-remote', '-c')
command! TmpCommit Gina tmpc
" treesitterの構文木を表示する
command! TSMyTree lua vim.treesitter.inspect_tree()

" Cd:
command! Cdbuffer cd %:h
command! Lcdbuffer lcd %:h
command! Cdgittop execute 'cd' vimrc#git_top()

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
command! AddRepo call my#dein#add_repo()
command! -nargs=1 SetTab call my#option#set_tab(<args>)

command! OpenCop call OpenCop()
command! OpenGitDiffWin call vimrc#open_git_diff('w')
command! OpenGitDiffTab call vimrc#open_git_diff('t')

command! UndoClear call vimrc#undo_clear()
command! -nargs=1 -complete=customlist,my#note#file_completion Note call my#note#open(<q-args>)

command! -nargs=+ -complete=command Capture call u#capture(<q-args>)
command! -nargs=+ -complete=command CaptureWin call u#capture_win(<q-args>)

command! MetalsGenerateBspConfig call vimrc#lsp_execute_command("metals.generate-bsp-config", v:null)
