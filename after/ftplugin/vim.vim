
setl keywordprg=:help
setl iskeyword+=:
nnoremap <silent><buffer>gd :call GotoVimFunction()<CR>
nmap <buffer>[m [[
nmap <buffer>]m ][
nmap <buffer>[M []
nmap <buffer>]M ]]
