setl foldmethod=indent
let python_highlight_all = 1
let g:python_highlight_all = 1
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
