let g:submode_keep_leaving_key = 1
let g:submode_timeout          = 0

" tab moving
call submode#enter_with('changetab', 'n', '', 'gt', 'gt')
call submode#enter_with('changetab', 'n', '', 'gr', 'gT')
call submode#map('changetab', 'n', '', 't', 'gt')
call submode#map('changetab', 'n', '', 'r', 'gT')

" undo/redo
" call submode#enter_with('undo/redo', 'n', '', '<C-r>', '<C-r>')
" call submode#enter_with('undo/redo', 'n', '', 'u', 'u')
" call submode#map('undo/redo', 'n', '', '<C-r>', '<C-r>')
" call submode#map('undo/redo', 'n', '', 'u', 'u')

" move between fold
call submode#enter_with('movefold', 'n', '', 'zk', 'zkzMzv[zzz')
call submode#enter_with('movefold', 'n', '', 'zj', 'zjzMzvzz')
call submode#map('movefold', 'n', '', 'k', 'zkzMzv[zzz')
call submode#map('movefold', 'n', '', 'j', 'zjzMzvzz')

" move between fold but not open and close it
call submode#enter_with('movefold-not', 'n', '', 'zK', 'zk')
call submode#enter_with('movefold-not', 'n', '', 'zJ', 'zj')
call submode#map('movefold-not', 'n', '', 'K', 'zk')
call submode#map('movefold-not', 'n', '', 'J', 'zj')
call submode#map('movefold-not', 'n', '', 'k', 'zk')
call submode#map('movefold-not', 'n', '', 'j', 'zj')

" resize window
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>+')
call submode#map('winsize', 'n', '', '-', '<C-w>-')

" time travel
call submode#enter_with('time-travel', 'n', '', 'g-', 'g-')
call submode#enter_with('time-travel', 'n', '', 'g+', 'g+')
call submode#map('time-travel', 'n', '', '-', 'g-')
call submode#map('time-travel', 'n', '', '+', 'g+')

" continuous x
nnoremap <silent><Plug>(continuous-x) :<c-u>undojoin \| normal! "_x<CR>
call submode#enter_with('continuous-x', 'n', '', 'x', '"_x')
call submode#map('continuous-x', 'n', 'r', 'x', '<Plug>(continuous-x)')

" sidescroll
call submode#enter_with('sidescroll', 'n', '', 'zl', 'zl')
call submode#enter_with('sidescroll', 'n', '', 'zh', 'zh')
call submode#map('sidescroll', 'n', '', 'l', '3zl')
call submode#map('sidescroll', 'n', '', 'h', '3zh')
