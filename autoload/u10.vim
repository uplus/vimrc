let s:V = vital#of('vital')
let s:Vuri = s:V.import('Web.URI')

" #helpers
function! u10#removechars(str, pattern) abort
  return substitute(a:str, '[' . a:pattern . ']', '', 'g')
endfunction

" cursolがlastlineにあるかどうか
function! u10#is_lastline(is_visual)
  let last = line('$')
  return line('.') == last || foldclosedend(line('.')) == last || (a:is_visual && line("'>") == last)
endfunction

function u10#home2tilde(str)
  return substitute(a:str, '^' . expand('~'), '~', '')
endfunction

function! u10#add_slash_tail(str)
  return substitute(a:str, '/*$', '/', '')
endfunction

function! u10#delete_str(str, pattern, ...)
  return substitute(a:str, a:pattern, '', get(a:000, 0, ''))
endfunction

function u10#expand_dir_alias(str)
    let path = system(printf("zsh -ic 'echo -n %s'", a:str))
    return u10#home2tilde(path)
endfunction

function u10#remove_opt_val(optname, chars)
  for c in  split(a:chars, '.\zs')
    execute printf('setl %s-=%s', a:optname, c)
  endfor
endfunction


" gf create new file
function! u10#gf_ask() abort "{{{
  let path = expand('<cfile>')
  if !filereadable(path)
    echo path
    echo 'Create it?(y/N)'
    if nr2char(getchar()) !=? 'y'
      return 0
    end
  endif
  return {'path': path, 'line': 0, 'col': 0,}
endfunction "}}}

function! u10#add_repo() abort "{{{
  let str = @+
  try
    let uri = s:Vuri.new(str)
    call append(line('.'), [
          \ '[[plugins]]',
          \ printf("repo = '%s'", join(split(uri.path(), '/')[:1], '/')),
          \ '',
          \ ])
    normal! jjj
  catch 'vital'
    echo str
    echo 'This string is not uri'
  endtry
endfunction "}}}

function! u10#highlight(...) "{{{
  if 0 == a:0
    Unite highlight
    return
  endif

  let cmd = "highlight " . a:1

  if 2 <= a:0
    let args = copy(a:000[1:])

    if args[0] =~# 'term'
      execute cmd args[0]

      if len(args) <= 1
        return
      endif
      call remove(args, 0)
    endif

    if args[0] !=# '_'
      execute cmd "ctermfg=" . args[0]
    endif

    if 2 <= len(args)
      execute  cmd "ctermbg=" . args[1]
    endif
  endif

  " output a current highlight
  execute cmd
endfunction "}}}

function! u10#open_git_diff(type) abort "{{{
  silent! update
  let s:before_winnr = winnr()
  let cmdname = 'git diff ' .  expand('%:t')
  let filedir = expand('%:h')
  silent! execute 'bwipeout \[' . escape(cmdname, ' ') . '\]'

  execute 'silent!' ((a:type == 't')? 'tabnew' : printf('botright vsplit [%s]', escape(cmdname, ' ')))

  " diff_config()で設定しようとするとnofileのタイミングが遅い
  setfiletype diff
  setl buftype=nofile
  setl undolevels=-1
  setl nofoldenable
  setl nonumber
  setl foldcolumn=0
  execute 'lcd' filedir
  silent put! =system(cmdname)
  $delete
  nnoremap <silent><buffer>q :call <SID>bwipeout_and_back()<CR>

  function! s:bwipeout_and_back()
    bwipeout!
    execute 'normal!' s:before_winnr ."\<C-w>w"
  endfunction

  " execute 'normal!' s:before_winnr ."\<C-w>w"
endfunction "}}}

function! u10#goto_vim_func_def() abort "{{{
  let func_name = matchstr(getline('.'),  '\v%(.\:)?\zs(%(\w|_|#|\.)*)\ze\(.*\)')
  if empty(func_name)
    return 1
  endif

  exec 'lvimgrep /\vfu%[nction]\!?\s+(.\:)?' . func_name . '/' . '`git ls-files`'
  call setloclist(0, [])
  silent! HierUpdate
  normal! zv
endfunction "}}}

function! u10#undo_clear() abort "{{{
  let l:old = &undolevels
  set undolevels=-1
  exe "normal a \<BS>\<Esc>"
  let &undolevels = l:old
  unlet l:old
  write
endfunction "}}}

function! u10#git_top() abort "{{{
  return system('git rev-parse --show-toplevel')
endfunction "}}}

function! u10#current_only() "{{{
  let l:old = &report
  set report=1000
  let l:count=0

  for l:buf in BuffersInfo()
    if -1 == stridx(l:buf[1], '%')
      execute "bwipeout" l:buf[0]
      let l:count+=1
    endif
  endfor

  echo l:count "buffer deleted"
  let &report=l:old
endfunction "}}}

function! u10#active_only() "{{{
  let l:old = &report
  set report=1000
  let l:count=0

  for l:buf in BuffersInfo()
    if -1 == stridx(l:buf[1], 'a')
      execute "bwipeout" l:buf[0]
      let l:count+=1
    endif
  endfor

  echo l:count "buffer deleted"
  let &report=l:old
endfunction "}}}

function! u10#delete_trash_buffers() "{{{
  let l:count=0

  for l:buf in BuffersInfo(' u')
    if -1 == stridx(l:buf[1], 'a') && -1 == stridx(l:buf[1], 'h')
      silent execute 'bwipeout' l:buf[0]
      let l:count+=1
    endif
  endfor

  if l:count != 0
    echo l:count 'buffer deleted'
  endif
endfunction "}}}


" ---- function groups ----
" #syntax info
function! u10#get_syn_id(transparent) "{{{
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction "}}}

function! u10#get_syn_attr(synid) "{{{
  let name    = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg   = synIDattr(a:synid, "fg", "gui")
  let guibg   = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name"    : name,
        \ "ctermfg" : ctermfg,
        \ "ctermbg" : ctermbg,
        \ "guifg"   : guifg,
        \ "guibg"   : guibg }
endfunction "}}}

function! u10#get_syn_info() "{{{
  let baseSyn = u10#get_syn_attr(u10#get_syn_id(0))
  let base = "name: "  . baseSyn.name    .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: "   . baseSyn.guifg   .
        \ " guibg: "   . baseSyn.guibg

  let linkedSyn = u10#get_syn_attr(u10#get_syn_id(1))
  let link = "name: "  . linkedSyn.name    .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: "   . linkedSyn.guifg   .
        \ " guibg: "   . linkedSyn.guibg

  echo base
  if base != link
    echo "link to"
    echo link
  endif
endfunction "}}}

" #word translate
function! u10#word_translate_weblio(word) abort "{{{
  let l:html    = webapi#http#get('ejje.weblio.jp/content/' . tolower(a:word)).content
  let l:content = matchstr(l:html, '\Vname="description"\v.{-}content\=\"\zs.{-}\ze\"\>')
  let l:body    = matchstr(l:content, '\v.{-1,}\ze\s{-}\-\s', 0, 1)
  let l:body = tr(l:body, '《》【】', '<>[]')
  let l:body = u10#removechars(l:body, '★→１２')
  let l:body = substitute(l:body, '\v(\d+)\s*', '\1', 'g')
  let l:body = substitute(l:body, '\V&#034;', '"', 'g')
  let l:body = substitute(l:body, '\V&#038;', '&', 'g')
  let l:body = substitute(l:body, '\V&#039;', "'", 'g')
  let l:body = substitute(l:body, '\V&#060;', '<', 'g')
  let l:body = substitute(l:body, '\V&#039;', '>', 'g')

  if l:body =~# '\.\.\.\s*$'
    let l:idx = strridx(l:body, ';')
    if 0 < l:idx
      let l:body = l:body[0:l:idx-1]
    endif
  endif
  return l:body
endfunction "}}}

function! u10#word_translate_weblio_smart(word) abort "{{{
  let l:reason = u10#word_translate_weblio(a:word)
  let l:prototype = matchstr(l:reason, '\v(\w+)\ze\s*の%(現在|過去|複数|三人称|直接法|間接法)')

  if '' !=# l:prototype
    let l:reason .= "\n" . u10#word_translate_weblio(l:prototype)
  endif

  return l:reason
endfunction "}}}

function! u10#word_translate_local_dict(word) abort "{{{
  if filereadable(expand(g:word_translate_local_dict))
    let l:str = system('grep -ihwA 1 ^' . a:word . '$ ' . g:word_translate_local_dict)
    return substitute(l:str, '\v(^|\n)(--|' . a:word . ')?(\_s|$)', '', 'gi')
  else
    return ''
  endif
endfunction "}}}

function! u10#word_translate(...) abort "{{{
  if !a:0
    if &l:ft == 'help'
      let word = expand('<cword>')
    else
      call OptionPush('iskeyword', '=@')
      let word = expand('<cword>')
      call OptionPop()
    endif
  else
    let word = a:1
  endif

  let found = u10#word_translate_local_dict(word)
  if found !=# ''
    echo found
  else
    echo u10#word_translate_weblio_smart(word)
  endif
endfunction "}}}

" #option stack TODO Vital.Vim.Guard
function! u10#option_push(name, expr) " 引数に = += -= 含めた値をとる {{{
  if -1 == match(a:expr, '\v^[+-]?\=')
    echo 'second argument need = += -= '
    return
  endif

  if !exists('&' . a:name)
    echo 'option not exists ' . a:name
    return
  endif

  call add(g:option_stack, [a:name, eval('&l:' . a:name)])

  try
    execute 'setlocal' a:name . a:expr
  catch /^Vim(setlocal):E474/
    call remove(g:option_stack, -1)
    echo 'Invalid argument ' . a:expr
  endtry
endfunction "}}}

function! u10#option_pop() "{{{
  let [name, value] = remove(g:option_stack, -1)
  execute 'setl ' . name . '=' . value
endfunction "}}}

function! u10#option_clear() "{{{
  let g:option_stack = []
endfunction "}}}

