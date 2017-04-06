let g:submode_keep_leaving_key = 1
let g:submode_timeout          = 0

" tab moving
call submode#enter_with('changetab', 'n', '', 'gt', 'gt')
call submode#enter_with('changetab', 'n', '', 'gr', 'gT')
call submode#map('changetab', 'n', '', 't', 'gt')
call submode#map('changetab', 'n', '', 'r', 'gT')

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
nmap <silent><Plug>(continuous-x) <Plug>(u10-undojoin)"_x
call submode#enter_with('continuous-x', 'n', '', 'x', '"_x')
call submode#map('continuous-x', 'n', 'r', 'x', '<Plug>(continuous-x)')

