setl foldmethod=indent

SetTab 4

setl foldmethod=manual

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
