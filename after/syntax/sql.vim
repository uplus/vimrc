
syn case ignore

syn keyword sqlType     text
syn match sqlKeyword 'primary key'

" next ones are contained, so folding works.
" syn keyword sqlStatement create update alter select insert contained

" Setup Folding:
" this is a hack, to get certain statements folded.
" the keywords create/update/alter/select/insert need to
" have contained option.
" syn region sqlFold start='^\s*\zs\c\(Create\|Update\|Alter\|Select\|Insert\)' end=';$\|^$' transparent fold contains=ALL
