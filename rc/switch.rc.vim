" switch.vim
nnoremap <silent>! :Switch<CR>

let g:switch_custom_definitions = get(g:, 'switch_custom_definitions', [])
au FileType ruby,eruby let g:switch_custom_definitions +=
      \ [
      \   [ 'if', 'unless' ],
      \   [ 'while', 'until' ],
      \   [ '.blank?', '.present?' ],
      \   [ 'include', 'extend' ],
      \   [ 'class', 'module' ],
      \   [ '.inject', '.reject' ],
      \   [ '.map', '.map!' ],
      \   [ 'attr_accessor', 'attr_reader', 'attr_writer' ],
      \ ]

au FileType markdown let g:switch_custom_definitions += [[ '[ ]', '[x]' ]]

au FileType erb,html,php let g:switch_custom_definitions += [ { '<!--\([a-zA-Z0-9 /]\+\)--></\(div\|ul\|li\|a\)>' : '</\2><!--\1-->' } ]
