" Dein Helpers:
" vim: foldlevel=0

silent! let s:V = vital#of('vital')
silent! let s:Vuri = s:V.import('Web.URI')

function! my#dein#add_repo() abort "{{{
  let str = @+
  try
    let uri = s:Vuri.new(str)
    call append(line('.'), [
          \ '',
          \ '[[plugins]]',
          \ printf("repo = '%s'", join(split(uri.path(), '/')[:1], '/')),
          \ ])
    normal! jjj
  catch 'vital'
    echo str
    echo 'This string is not uri'
  endtry
endfunction "}}}

function! my#dein#open_repo() abort "{{{
  let repo_name = vimrc#delete_chars(expand('<cWORD>'), "'")
  call openbrowser#open('https://github.com/' . repo_name)
endfunction "}}}
