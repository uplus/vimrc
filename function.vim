
" #OptionStack
let g:option_stack = []

function! Execute(cmd)
  execute a:cmd
  return ""
endfunction

function! Ruby(str) abort
  return u10#capture('ruby ' . a:str)
endfunction

" #EraseSpace "{{{
let g:erase_space_on = 1
command! EraseSpace        call EraseSpace()
command! EraseSpaceEnable  let g:erase_space_on=1
command! EraseSpaceDisable let g:erase_space_on=0
function! EraseSpace()
  if g:erase_space_on != 1
    return
  endif

  " filetypeが一致したらreturn
  if index(['markdown', 'gitcommit', 'help'], &filetype) != -1
    return
  endif

  " for vim-precious
  if expand('%') =~# '.md$'
    return
  endif

  let l:cursor = getpos(".")
  %s/\s\+$//e
  call setpos(".", l:cursor)
endfunction
"}}}

" #Buffer functions "{{{

" #BuffersInfo
command! BuffersInfo PP BuffersInfo()

" return list [bufnr, status, name]
function! BuffersInfo(...)
  return map(split(u10#capture('ls' . (a:0? a:1 : '!')), '\n'),
        \ 'matchlist(v:val, ''\v^\s*(\d*)\s*(.....)\s*"(.*)"\s*.*\s(\d*)$'')[1:4]' )
endfunction

function! BufferCount()
  return len(split(u10#capture('ls!'), "\n"))
endfunction

function! ActiveBufferCount()
  return len(split(u10#capture('ls! a'), "\n"))
endfunction

function! ListedBufferCount()
  return len(split(u10#capture('ls'), "\n"))
endfunction

"}}}

" #Blank "{{{
nnoremap <silent> <Plug>(BlankUp)   :<C-U>call <SID>BlankUp(v:count1)<CR>
nnoremap <silent> <Plug>(BlankDown) :<C-U>call <SID>BlankDown(v:count1)<CR>

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
  silent! QuickhlManualReset
  silent! RCReset
  call clearmatches()
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

let g:u10_autosave = 0
command! EnableAutoSave let g:u10_autosave = 1
command! DisableAutoSave let g:u10_autosave = 1
nnoremap <silent><F2> :call ToggleAutoSave()<CR>
function! ToggleAutoSave() abort
  silent update
  let g:u10_autosave = !g:u10_autosave
  echo 'autosave' g:u10_autosave? 'enabled' : 'disabled'
endfunction

function! DoAutoSave() abort
  if g:u10_autosave != 0
    silent! update
  endif
endfunction

function! DummyArray(start, last, times) abort
  return Ruby(printf("print Array.new(%d){ Random.rand(%d..%d)}.join(', ')", a:times, a:start, a:last))
endfunction
