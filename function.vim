
" #AutoSave "{{{
let g:my_autosave = get(g:, 'my_autosave', 0)
command! EnableAutoSave let g:my_autosave = 1
command! DisableAutoSave let g:my_autosave = 0
nnoremap <silent><F2> :call ToggleAutoSave()<CR>
function! ToggleAutoSave() abort
  silent update
  let g:my_autosave = !g:my_autosave
  echo 'autosave' g:my_autosave? 'enabled' : 'disabled'
endfunction

function! DoAutoSave() abort
  if g:my_autosave != 0
    silent! update
  endif
endfunction
"}}}

let g:erase_space_on = 1
command! EraseSpace        call EraseSpace()
command! EraseSpaceEnable  let g:erase_space_on=1
command! EraseSpaceDisable let g:erase_space_on=0
function! EraseSpace() abort "{{{
  if g:erase_space_on != 1
    return
  endif

  " filetypeが一致したらreturn
  if &ft =~# 'markdown\|gitcommit\|help'
    return
  endif

  " for vim-precious
  if expand('%') =~# '.md$'
    return
  endif

  let l:pos = getpos(".")
  %s/\s\+$//e
  while getline('$') =~# '^\s*$'
    $delete
  endwhile
  call setpos(".", l:pos)
endfunction "}}}

" #Blank "{{{
nnoremap <silent><Plug>(BlankUp)   :<c-u>call <SID>BlankUp(v:count1)<cr>
nnoremap <silent><Plug>(BlankDown) :<c-u>call <SID>BlankDown(v:count1)<cr>

function! s:BlankUp(count) abort
  put! =repeat(nr2char(10), a:count)
  ']+1
  silent! call repeat#set("\<Plug>(BlankUp)", a:count)
endfunction

function! s:BlankDown(count) abort
  put =repeat(nr2char(10), a:count)
  '[-1
  silent! call repeat#set("\<Plug>(BlankDown)", a:count)
endfunction
"}}}

" #Misc
function! ResetHightlights() abort
  " nohlsearch " 関数内では動作しない
  silent! call clever_f#reset()
  silent! LinediffReset
  silent! QuickhlManualReset
  silent! RCReset
  silent! HierClear
  " call clearmatches()
endfunction

command! HTMLalign call HTMLalign()
function! HTMLalign() abort
  %s/\v\>\</>\r</
  setfiletype html
  normal gg=G
endfunction

" call from snippets
function! Filename() abort
  return expand('%:t:r')
endfunction

function! Format() abort
  EraseSpace

  if exists('b:format_cmd')
    execute b:format_cmd
  endif
endfunction

let g:tags_jobs = {}
function! Tags() abort
  let dir = expand('%:p:h')
  silent! call jobstop(get(g:tags_jobs, dir, -1))
  let g:tags_jobs[dir] = jobstart(get(b:, 'tags_cmd', 'ctags'))
endfunction

let g:clang_rename_command = 'clang-rename'
let g:clang_reanme_flag = {
  \ 'c': '-std=gnu11',
  \ 'cpp': '-std=c++14',
  \ }

au myac FileType c,cpp nnoremap <buffer><silent>,lr :ClangRename<cr>
command! ClangRename call ClangRename()
function! ClangRename() abort
  let flag = g:clang_reanme_flag[&ft]
  let bufpath = expand('%:p')
  let cmd = [g:clang_rename_command,
    \ '-i',
    \ '-offset=' . (line2byte(line('.'))+col('.')-2),
    \ '-new-name=' . input('New name> '),
    \ bufpath,
    \ '--', flag, '...',
    \ ]

  call system(cmd)
  exec 'checktime' bufpath
endfunction
