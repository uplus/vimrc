" vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect

function! IsFile(path) abort
  return !isdirectory(a:path) && glob(a:path) !=# ''
endfunction

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
  if -1 != index(['denite', 'denite-filter', 'defx', 'narrow'], &filetype)
    return
  endif

  " for debug
  echo 'auto save at' strftime('%T') bufname() &filetype

  if g:my_autosave != 0
    silent! update
    silent! SignifyRefresh
    silent! ALELint
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
  if &filetype =~# 'markdown\|gitcommit\|help'
    return
  endif

  " for vim-precious
  if expand('%') =~# '.md$'
    return
  endif

  let l:pos = getpos('.')
  %s/\s\+$//eI
  while getline('$') =~# '^\s*$'
    $delete
  endwhile
  call setpos('.', l:pos)
endfunction "}}}

" #Blank "{{{
nnoremap <silent><Plug>(BlankUp)   :<c-u>call <SID>BlankUp(v:count1)<cr>
nnoremap <silent><Plug>(BlankDown) :<c-u>call <SID>BlankDown(v:count1)<cr>

function! s:BlankUp(count) abort
  normal! $
  put! =repeat(nr2char(10), a:count)
  ']+1
  silent! call repeat#set("\<Plug>(BlankUp)", a:count)
endfunction

function! s:BlankDown(count) abort
  normal! $
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
  silent! call lightline#update()
  ClearLocList
  " call clearmatches()
endfunction

command! HTMLalign call HTMLalign()
function! HTMLalign() abort
  %s/\v\>\</>\r</eI
  setfiletype html
  normal! gg=G
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
  let l:dir = expand('%:p:h')
  silent! call jobstop(get(g:tags_jobs, l:dir, -1))
  let g:tags_jobs[l:dir] = jobstart(get(b:, 'tags_cmd', 'ctags'))
endfunction

" If use selected text in function, need range
command! -nargs=1 -range Inject echomsg Inject(<args>)
function! Inject(expr) abort
  let pos_save = getpos('.')
  try
    exec printf('silent normal! gv"%sy', g:working_register)
    let values = split(getreg(g:working_register))
    return vimrc#inject(values, a:expr)
  finally
    call setpos('.', pos_save)
  endtry
endfunction

function! OpenPluginGithub(name) abort
  call openbrowser#open('https://github.com/' . a:name)
endfunction

function! Job(...) abort
  if exists('*jobstart')
    call jobstart(a:000)
  elseif exists('*job_start')
    call job_start(a:000)
  else
    " echo "job not found"
  endif
endfunction

function! SetAsScratch() abort
  nnoremap <silent><buffer>q :quit<CR>
  setl buftype=nofile
  setl bufhidden=hide
  setl noswapfile
  setl nobuflisted
endfunction

function! SetTab(num) abort
  let &l:tabstop=a:num
  let &l:softtabstop = &l:tabstop
  let &l:shiftwidth = &l:tabstop

  if exists('+breakindentopt')
    let &l:breakindentopt = printf('shift:%d', (2 <= &l:tabstop ? &l:tabstop - 2 : 0))
  endif
endfunction


nnoremap <Plug>(OpenPluginGithub) :call OpenPluginGithub(expand('<cWORD>'))<cr>
nmap gsp <Plug>(OpenPluginGithub)

function Debug(data)
  let g:debug_data = a:data
  PP! a:data
endfunction
