
setl keywordprg=:help
setl iskeyword+=:
nnoremap <silent><buffer>gd :call vimrc#goto_vim_func_def()<CR>
nmap <buffer>[m [[
nmap <buffer>]m ][
nmap <buffer>[M []
nmap <buffer>]M ]]

let b:match_ignorecase = 0
let b:match_words =
      \ '\<fu\%[nction]\>:\<endf\%[unction]\>,' .
      \ '\<\(wh\%[ile]\|for\)\>:\<end\(w\%[hile]\|fo\%[r]\)\>,' .
      \ '\<if\>:\<en\%[dif]\>,' .
      \ '\<try\>:\<endt\%[ry]\>,' .
      \ '\<aug\%[roup]\s\+\%(END\>\)\@!\S:\<aug\%[roup]\s\+END\>,' .
      \ '(:)'

let b:match_skip = 'synIDattr(synID(line("."),col("."),1),"name") =~? "comment\\|string\\|vimSynReg\\|vimSet\\|vimFuncName"'
