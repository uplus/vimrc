setl foldmethod=indent
let python_highlight_all = 1
let g:python_highlight_all = 1

setl tabstop=4
let &l:softtabstop = &l:tabstop
let &l:shiftwidth = &l:tabstop

if has('*textobj#user#map')
  call textobj#user#map('python', {
        \   'class': {
        \     'select-a': '<buffer>aM',
        \     'select-i': '<buffer>iM',
        \   },
        \   'function': {
        \     'select-a': '<buffer>im',
        \     'select-i': '<buffer>im',
        \   }
        \ })
endif
