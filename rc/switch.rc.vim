" switch.vim
let g:switch_mapping = "<silent>!"
let g:switch_find_smallest_match = 1
au uAutoCmd FileType gitrebase nnoremap <buffer>! 0:Switch<CR>

let g:switch_custom_definitions = get(g:, 'switch_custom_definitions', [])

" Todo: \zs \ze
let g:switch_custom_definitions += [
      \ ['enable', 'disable'],
      \ [ ' < ', ' > '],
      \ [ ' <= ', ' >= '],
      \ [ ' == ', ' != '],
      \ { '\v"(.+)"'   : '''\1''' },
      \ { '\v''(.+)''' : '"\1"'   },
      \]

" Todo: ruby-lambdaをスペースを識別できるようにする
" {'''\(\k\+\)''': ':\1', '"\(\k\+\)"': '''\1''', ':\(\k\+\)\@>\%(\s*=>\)\@!': '"\1"\2'},
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
      \   [ '.clone', '.dup' ],
      \   [ '.any?', '.none?' ],
      \   [ '.all?', '.one?' ],
      \   [ 'p ', 'puts ', 'print '],
      \   [ 'attr_accessor', 'attr_reader', 'attr_writer' ],
      \   [ 'File.exist?', 'File.file?', 'File.directory?' ],
      \ ]


au FileType markdown let g:switch_custom_definitions += [[ '[ ]', '[x]' ]]

au FileType erb,html,php let g:switch_custom_definitions += [ { '<!--\([a-zA-Z0-9 /]\+\)--></\(div\|ul\|li\|a\)>' : '</\2><!--\1-->' } ]

au FileType vim let g:switch_custom_definitions +=
      \ [
      \   [ 'echo ', 'echomsg ' ],
      \   [ 'NeoBundle ', 'NeoBundleLazy ' ],
      \   [ 'nnoremap ', 'nmap ' ],
      \   [ 'inoremap ', 'imap ' ],
      \   [ 'cnoremap ', 'cmap ' ],
      \   [ 'xnoremap ', 'xmap ' ],
      \   [ ' <silent><buffer>', ' <silent>' ],
      \   [ 'BufWritePre', 'BufWritePost', 'BufWriteCmd'],
      \   [ 'BufReadPre', 'BufReadPost', 'BufReadCmd'],
      \   [ '==#', '!=#' ],
      \   [ '==?', '!=?' ],
      \   [ '=~#', '!~#' ],
      \   [ '=~?', '!~?' ],
      \   [ 'if', 'elseif' ],
      \ ]

au FileType gitrebase let g:switch_custom_definitions += [
      \  [ 'pick', 'reword', 'edit', 'squash', 'fixup', 'exec'],
      \ ]

au FileType zsh,bash,sh let g:switch_custom_definitions += [
      \  [ ' -a ', ' -o '],
      \  [ ' -z ', ' -n '],
      \  [ ' -eq ', ' -ne '],
      \  [ ' -lt ', ' -le ', ' -gt ', ' -ge '],
      \  [ ' -e ', ' -f ', ' -d '],
      \  [ ' -r ', ' -w ', ' -x '],
      \ ]

