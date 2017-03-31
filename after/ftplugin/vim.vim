
setl keywordprg=:help
setl iskeyword+=:
nnoremap <silent><buffer>gd :call u10#goto_vim_func_def()<CR>
nmap <buffer>[m [[
nmap <buffer>]m ][
nmap <buffer>[M []
nmap <buffer>]M ]]
