" vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect

" #AutoSave "{{{
let g:my_autosave = 1
let g:my_autosave = get(g:, 'my_autosave', 0)
command! EnableAutoSave let g:my_autosave = 1
command! DisableAutoSave let g:my_autosave = 0

function! DoAutoSave() abort
  if -1 != index(['denite', 'denite-filter', 'defx', 'narrow'], &filetype)
    return
  endif

  if pumvisible()
    return
  endif

  if g:my_autosave != 0
    " for debug
    " echo 'auto save at' strftime('%T') bufname() &filetype

    " silent! update
    silent! wall
    silent! SignifyRefresh
    " silent! ALELint
  endif
endfunction
"}}}

function! EraseSpace() abort "{{{
  " filetypeが一致したらreturn
  if -1 != index(['markdown', 'gitcommit', 'help'], &filetype)
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

command! HTMLalign call HTMLalign()
function! HTMLalign() abort "{{{
  %s/\v\>\</>\r</eI
  setfiletype html
  normal! gg=G
endfunction "}}}

function! Format() abort "{{{
  call EraseSpace()

  if exists('b:format_cmd')
    execute b:format_cmd
  endif
endfunction "}}}

function! ResetHighlights() abort "{{{
  " nohlsearch " 関数内では動作しない
  silent! call clever_f#reset()
  silent! LinediffReset
  silent! QuickhlManualReset
  silent! RCReset
  silent! HierClear
  silent! call lightline#update()
  ClearLocList
  " call clearmatches()
endfunction "}}}

let g:tags_jobs = {}
function! Tags() abort "{{{
  let l:dir = expand('%:p:h')
  silent! call jobstop(get(g:tags_jobs, l:dir, -1))
  let g:tags_jobs[l:dir] = jobstart(get(b:, 'tags_cmd', 'ctags'))
endfunction "}}}

" 現在行か選択範囲に引数の演算を適用する
command! -nargs=1 -range Inject echomsg Inject(<f-args>)
function! Inject(expr) abort "{{{
  let pos_save = getpos('.')
  try
    execute printf('silent normal! gv"%sy', g:working_register)
    let values = split(getreg(g:working_register))
    return vimrc#fold(values, a:expr)
  finally
    call setpos('.', pos_save)
  endtry
endfunction "}}}

function! Job(...) abort "{{{
  if exists('*jobstart')
    call jobstart(a:000)
  elseif exists('*job_start')
    call job_start(a:000)
  else
    " echo "job not found"
  endif
endfunction "}}}

function Debug(data) "{{{
  let g:debug_data = a:data
  PP! a:data
endfunction "}}}

" unix sortに似た使い勝手
command! -nargs=+ -range=% Sort call Sort(<f-args>)
function! Sort(k, ...) abort "{{{
  let pos = getpos('.')

  " 1列目でソートしたいなら0
  let k = a:k - 1
  " セパレータをデフォルト引数で取る
  let sep = get(a:000, 0, ', ')
  execute printf('*sort /\v([^%s]+[%s]+){%d}\zs/', sep, sep, k)

  call setpos('.', pos)
endfunction "}}}
