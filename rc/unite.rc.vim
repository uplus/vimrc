" #headline unite soure "{{{
let s:unite_source_headline = {
      \ 'name': 'headline',
      \ 'max_candidates': 100,
      \ }

function! s:unite_source_headline.gather_candidates(args, context)
  let outlines = []
  let num      = 0
  let marker   = split(&l:foldmarker, ',')[0]
  let comment  = split(&l:commentstring, '%s')[0]
  let marker_pattern = printf('\V%s\?\s\*%s', comment, marker)
  echomsg marker_pattern

  for line in getbufline('%', 1, '$')
    let num+=1
    " &l:commentstring
    " let matched = matchlist(line, '\v%(^|\s+)#(#*)\s*(\w[^\{#]*)')[1:2]
    " TODO syntax info使って区別する
    let matched = matchlist(line, '\v%(^|\s+)\#+(\S.*)$')
    " let matched = matchlist(line, '\v^[^\w\d\#]*\#+\s*(.*)$')
    if empty(matched)
      continue
    endif

    " let oline = substitute(matched[1], '#', '  ', 'g')
    let oline = matched[1]
    let oline = substitute(oline, marker_pattern, '', '')
    if empty(oline)
      continue
    endif

    call add(outlines,{
          \ 'word'         : oline,
          \ 'source'       : 'headline',
          \ 'kind'         : 'jump_list',
          \ 'action__path' : expand('%:p'),
          \ 'action__line' : num
          \ })
  endfor

  return outlines
endfunction

call unite#define_source(s:unite_source_headline)
unlet s:unite_source_headline
"}}}

" on_post_sourceの中でやると起動直後に反映されてない
au myac FileType unite call s:unite_config()
function! s:unite_config()
  let context = unite#get_context()

  if context.buffer_name ==# 'quickrun-hook-unite-quickfix' || context.buffer_name ==# 'quickfix'
    au myac WinEnter <buffer> if !exists('b:win_entered') | 0 | let b:win_entered = 1 | endif
    au myac WinEnter <buffer> if winnr('$') == 1 | quit | endif
    nnoremap <silent><buffer>k :call <SID>unite_move_pos(1)<CR>
    nnoremap <silent><buffer>j :call <SID>unite_move_pos(0)<CR>

  elseif context.buffer_name ==# 'location_list'
    au myac WinEnter <buffer> if winnr('$') == 1 | quit | endif

  elseif context.buffer_name ==# 'buffer'
    nnoremap <silent><buffer><expr><nowait>s unite#do_action('split')
    nnoremap <silent><buffer><expr><nowait>v unite#do_action('vsplit')
    nnoremap <silent><buffer><expr><nowait>t unite#do_action('tabopen')
  endif
endfunction

" smart_close
" active bufferならquit
" auto_highlightを消す
function! s:unite_smart_close()
  let context = unite#get_context()

  if vimrc#buffer_count('a') == 0
    quit
  elseif context.auto_highlight == 1
    if context.quit == 0
      call feedkeys("\<Plug>(unite_exit)")
    endif
    call feedkeys("\<Plug>(unite_do_default_action)")
  else
    call feedkeys("\<Plug>(unite_exit)")
  endif
endfunction

" unie_move_pos unite-quickfixで賢く移動する
function! s:unite_move_pos(is_up)
  call cursor(0, a:is_up? 1 : col('$'))
  call search('|\d\+\D*\d*|', a:is_up? 'wb' : 'w')
  normal! ^
endfunction
