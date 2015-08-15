" switch.vim
let g:switch_mapping = "!"

let g:switch_custom_definitions = get(g:, 'switch_custom_definitions', [])
let g:switch_custom_definitions += [
      \ ['enable', 'disable'],
      \ ['>', '<'],
      \ ['<=', '>='],
      \]

" Todo: make theres
" > < をまわりのスペースか文字を認識して実効するようにする ->が -<になったりしちゃう
" ruby-lambdaをスペースを識別できるようにする
" "" '' ``

au FileType ruby,eruby let g:switch_custom_definitions +=
      \ [
      \   [ 'if', 'unless' ],
      \   [ 'while', 'until' ],
      \   [ '.blank?', '.present?' ],
      \   [ 'include', 'extend' ],
      \   [ 'class', 'module' ],
      \   [ '.inject', '.reject' ],
      \   [ '.map', '.map!' ],
      \   [ '.sub', '.sub!', '.gub', '.gub!' ],
      \   [ 'attr_accessor', 'attr_reader', 'attr_writer' ],
      \ ]

au FileType markdown let g:switch_custom_definitions += [[ '[ ]', '[x]' ]]

au FileType erb,html,php let g:switch_custom_definitions += [ { '<!--\([a-zA-Z0-9 /]\+\)--></\(div\|ul\|li\|a\)>' : '</\2><!--\1-->' } ]

au FileType vim let g:switch_custom_definitions +=
      \ [
      \   [ 'nnoremap', 'nmap' ],
      \   [ 'inoremap', 'imap' ],
      \   [ 'cnoremap', 'cmap' ],
      \   [ 'xnoremap', 'xmap' ],
      \   [ '<silent>', '<silent><buffer>', '<silent><buffer><expr>' ],
      \   [ 'BufWrite', 'BufWritePre', 'BufWritePost', 'BufWriteCmd'],
      \   [ 'BufRead', 'BufReadPre', 'BufReadPost', 'BufReadCmd'],
      \   [ '==#', '!=#' ],
      \   [ '==?', '!=?' ],
      \   [ '=~#', '!~#' ],
      \   [ '=~?', '!~?' ],
      \ ]

au FileType gitrebase let g:switch_custom_definitions += [
      \  [ 'pick', 'reword', 'edit', 'squash', 'fixup', 'exec'],
      \ ]
