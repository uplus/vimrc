let g:submode_keep_leaving_key = 1

" Todo: foldを展開しないzjマップ作る 別ファイルに移動

" tab moving
call submode#enter_with('changetab', 'n', '', 'gt', 'gt')
call submode#enter_with('changetab', 'n', '', 'gT', 'gT')
call submode#map('changetab', 'n', '', 't', 'gt')
call submode#map('changetab', 'n', '', 'T', 'gT')

" undo/redo
call submode#enter_with('undo/redo', 'n', '', '<C-r>', '<C-r>')
call submode#enter_with('undo/redo', 'n', '', 'u', 'u')
call submode#map('undo/redo', 'n', '', '<C-r>', '<C-r>')
call submode#map('undo/redo', 'n', '', 'u', 'u')

" move between fold
call submode#enter_with('movefold', 'n', '', 'zj', 'zjzMzvzz')
call submode#enter_with('movefold', 'n', '', 'zk', 'zkzMzv[zzz')
call submode#map('movefold', 'n', '', 'j', 'zjzMzvzz')
call submode#map('movefold', 'n', '', 'k', 'zkzMzv[zzz')

" resize window
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>+')
call submode#map('winsize', 'n', '', '-', '<C-w>-')
