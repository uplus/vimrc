" operator and textobject
" vim: foldlevel=0

" operator
function! my#ot#operator_blank2void(motion_wise) abort "{{{
  let v = operator#user#visual_command_from_wise_name(a:motion_wise)
  if join(getline("'[", "']"), '') =~# '\%^\_s*\%$'
    execute printf('normal! `[%s`]"_d', v)
  else
    execute printf('normal! `[%s`]d', v)
  endif
endfunction "}}}

function! my#ot#operator_space_fold(motion_wise) abort "{{{
  " vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
  '<s/\v%(^)@<!\s*$/ /e
  undojoin
  '>s/\v%(^)@<!\s*$/ /e
  undojoin
  '<,'>fold
  " vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
endfunction "}}}

function! my#ot#text_move(count, is_up, is_visual) abort "{{{
  let save_lazyredraw = &l:lazyredraw
  setl lazyredraw
  try
    let pos  = getcurpos()
    let delete = (a:is_visual? '*' : '') . 'delete ' . g:working_register

    if a:is_up
      let line = a:count
      if u#is_lastline(a:is_visual)
        let line -= 1
      endif

      noautocmd exec delete
      silent! exec 'normal!' repeat('k', line)
      execute 'put!' g:working_register
    else
      noautocmd exec delete
      silent! exec 'normal!' repeat('j', a:count-1)
      execute 'put' g:working_register
    endif

    let pos[1] = line('.')
    call setpos('.', pos)

    if a:is_visual
      normal! '[V']
    else
      silent! call repeat#set("\<Plug>(Move" . (a:is_up? 'Up)': 'Down)'), a:count)
    endif
  finally
    let &l:lazyredraw = save_lazyredraw
  endtry
endfunction "}}}

function! my#ot#blank_up(count) abort
  normal! $
  put! =repeat(nr2char(10), a:count)
  ']+1
  " repeatできないほうが使い勝手が良い
  " silent! call repeat#set("\<Plug>(BlankUp)", a:count)
endfunction

function! my#ot#blank_down(count) abort
  normal! $
  put =repeat(nr2char(10), a:count)
  '[-1
  " repeatできないほうが使い勝手が良い
  " silent! call repeat#set("\<Plug>(BlankDown)", a:count)
endfunction


" textobj
" blankline "{{{
function! my#ot#textobj_blankline(flags) abort
  let l:flags = 'nW' . a:flags
  return ['V', getpos('.'), [0] + searchpos('^\s*$\|\%^\|\%$', l:flags) + [0]]
endfunction

function! my#ot#textobj_blankline_prev() abort
  return my#ot#textobj_blankline('b')
endfunction

function! my#ot#textobj_blankline_next() abort
  return my#ot#textobj_blankline('')
endfunction
"}}}
