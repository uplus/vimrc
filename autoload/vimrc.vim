" TODO Vitalizeする?
silent! let s:V = vital#of('vital')
silent! let s:Vuri = s:V.import('Web.URI')

" #helpers
function! vimrc#removechars(str, pattern) abort
  return substitute(a:str, '[' . a:pattern . ']', '', 'g')
endfunction

" cursolがlastlineにあるかどうか
function! vimrc#is_lastline(is_visual) abort
  let last = line('$')
  return line('.') == last || foldclosedend(line('.')) == last || (a:is_visual && line("'>") == last)
endfunction

function vimrc#home2tilde(str) abort
  return substitute(a:str, '^' . expand('~'), '~', '')
endfunction

function! vimrc#add_slash_tail(str) abort
  return substitute(a:str, '/*$', '/', '')
endfunction

function! vimrc#delete_str(str, pattern, ...) abort
  return substitute(a:str, a:pattern, '', get(a:000, 0, ''))
endfunction

function vimrc#expand_dir_alias(str) abort
    let path = system(printf("zsh -ic 'echo -n %s'", a:str))
    return vimrc#home2tilde(path)
endfunction

function vimrc#remove_opt_val(optname, chars) abort
  for c in  split(a:chars, '.\zs')
    execute printf('setl %s-=%s', a:optname, c)
  endfor
endfunction

function! vimrc#inject(list, expr) abort
  if type(a:expr) ==# g:type_str
    let Func = {memo, v -> eval(printf("%s %s %s", memo, a:expr, v))}
  else
    let Func = a:expr
  endif

  let result = a:list[0]
  unlet a:list[0]

  for v in a:list
    let result = Func(result, v)
  endfor
  return result
endfunction

" textobj
" blankline "{{{
function! vimrc#textobj_blankline(flags) abort
  let l:flags = 'nW' . a:flags
  return ['V', getpos('.'), [0] + searchpos('^\s*$\|\%^\|\%$', l:flags) + [0]]
endfunction

function! vimrc#textobj_blankline_prev() abort
  return vimrc#textobj_blankline('b')
endfunction

function! vimrc#textobj_blankline_next() abort
  return vimrc#textobj_blankline('')
endfunction
"}}}

" operator
function! vimrc#operator_blank2void(motion_wise) abort "{{{
  let v = operator#user#visual_command_from_wise_name(a:motion_wise)
  if join(getline("'[", "']"), '') =~ '\%^\_s*\%$'
    execute printf('normal! `[%s`]"_d', v)
  else
    execute printf('normal! `[%s`]d', v)
  endif
endfunction "}}}

function! vimrc#operator_space_fold(motion_wise) abort "{{{
  '<s/\v%(^)@<!\s*$/ /e
  undojoin
  '>s/\v%(^)@<!\s*$/ /e
  undojoin
  '<,'>fold
endfunction "}}}


function! vimrc#working_terminal() abort "{{{
  if !bufexists(get(g:, 'vimrc#working_terminal_nr', -1))
    botright split +Terminal
    let g:vimrc#working_terminal_nr = bufnr('%')
    silent setl ft= nobuflisted bufhidden
    silent nnoremap <buffer>q <c-w>c
    au myac TermClose <buffer> unlet g:vimrc#working_terminal_nr
    startinsert
  else
    exec 'botright split' bufname(g:vimrc#working_terminal_nr)
  endif
endfunction "}}}

function! vimrc#add_repo() abort "{{{
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

function! vimrc#highlight(...) abort "{{{
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

function! vimrc#open_git_diff(type) abort "{{{
  silent! update
  let s:prev_winnr = winnr()
  let cmdname = 'git diff ' .  expand('%:t')
  let filedir = expand('%:h')

  if exists('s:git_diff_bufnr')
    silent! execute 'bwipeout' s:git_diff_bufnr
  endif

  execute 'silent!' ((a:type == 't')? 'tabnew' : printf('botright vsplit git-diff-%s', escape(cmdname, ' ')))
  let s:git_diff_bufnr = bufnr('%')

  " diff_config()で設定しようとするとnofileのタイミングが遅い
  setfiletype diff
  setl buftype=nofile
  setl undolevels=-1
  setl nofoldenable
  setl nonumber
  setl foldcolumn=0
  setl modifiable
  execute 'lcd' filedir
  silent put! =system(cmdname)
  $delete
  nnoremap <silent><buffer>q :call <SID>bwipeout_and_back()<CR>

  function! s:bwipeout_and_back()
    bwipeout!
    execute 'normal!' s:prev_winnr ."\<C-w>w"
  endfunction
endfunction "}}}

function! vimrc#goto_vim_func_def() abort "{{{
  let func_name = matchstr(getline('.'),  '\v%(.\:)?\zs(%(\w|_|#|\.)*)\ze\(.*\)')
  if empty(func_name)
    return 1
  endif

  exec 'lvimgrep /\vfu%[nction]\!?\s+(.\:)?' . func_name . '/' . '`git ls-files`'
  call setloclist(0, [])
  silent! HierUpdate
  normal! zv
endfunction "}}}

function! vimrc#undo_clear() abort "{{{
  let l:old = &undolevels
  set undolevels=-1
  exe "normal a \<BS>\<Esc>"
  let &undolevels = l:old
  unlet l:old
  write
endfunction "}}}

function! vimrc#git_top() abort "{{{
  return system('git rev-parse --show-toplevel')
endfunction "}}}

function! vimrc#current_only() abort "{{{
  let l:old = &report
  set report=1000
  let l:count=0

  for l:buf in vimrc#buffers_info()
    if -1 == stridx(l:buf[1], '%')
      execute "bwipeout" l:buf[0]
      let l:count+=1
    endif
  endfor

  echo l:count "buffer deleted"
  let &report=l:old
endfunction "}}}

function! vimrc#active_only() abort "{{{
  let l:old = &report
  set report=1000
  let l:count=0

  for l:buf in vimrc#buffers_info()
    if -1 == stridx(l:buf[1], 'a')
      execute "bwipeout" l:buf[0]
      let l:count+=1
    endif
  endfor

  echo l:count "buffer deleted"
  let &report=l:old
endfunction "}}}

function! vimrc#delete_trash_buffers() abort "{{{
  let l:count=0

  for l:buf in vimrc#buffers_info(' u')
    if -1 == stridx(l:buf[1], 'a') && -1 == stridx(l:buf[1], 'h')
      silent execute 'bwipeout' l:buf[0]
      let l:count+=1
    endif
  endfor

  if l:count != 0
    echo l:count 'buffer deleted'
  endif
endfunction "}}}

function! vimrc#note_open(name) abort "{{{
  let l:name = system(['note', '-S', a:name])[0:-2]
  if name ==# ''
    echo printf('%s not found', a:name)
  endif

  exec 'tabedit' l:name
endfunction "}}}

function! vimrc#note_file_completion(lead, line, pos) abort "{{{
  let l:name = a:lead
  let l:files = split(system(['note', '--list']))

  if l:name ==# ''
    return l:files
  endif

  " match filter
  let l:files = filter(files, 'v:val =~ l:name')
  let l:head_matched = filter(copy(files), 'v:val =~ "^" . l:name')
  if 0 != len(l:head_matched)
    let l:files = l:head_matched
  endif

  if 1 < len(l:files)
    return l:files
  endif

  let l:name = files[0]
  if l:name =~# '/$'
    let l:files = split(system(['note', '--list', l:name]))
    call map(l:files, 'l:name . v:val')
  endif

  return l:files
endfunction "}}}

function! vimrc#capture(cmd_str) abort "{{{
  redir => g:capture
  silent execute a:cmd_str
  redir END
  return substitute(g:capture, '\%^\n', '', '')
endfunction "}}}

function! vimrc#capture_win(cmd) abort "{{{
  redir => result
  silent execute a:cmd
  redir END

  let bufname = 'Capture: ' . a:cmd
  new
  setlocal bufhidden=unload
  setlocal nobuflisted
  setlocal buftype=nofile
  setlocal noswapfile
  silent file `=bufname`
  silent put =result
  1,2delete _
endfunction "}}}

function! vimrc#delete_for_match() abort "{{{
  normal! V^
  normal %
  normal! d
  call repeat#set("\<Plug>(delete_for_match)")
endfunction "}}}

function! vimrc#text_move(count, is_up, is_visual) abort "{{{
  let save_lazyredraw = &l:lazyredraw
  setl lazyredraw
  try
    let pos  = getcurpos()
    let delete = (a:is_visual? '*' : '') . 'delete ' . g:working_register

    if a:is_up
      let line = a:count
      if vimrc#is_lastline(a:is_visual)
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

function! vimrc#zsh_file_completion(lead, line, pos) abort "{{{
  if a:lead ==# '#'
    return map(vimrc#buffers_info(''), 'v:val[2]')
  elseif a:lead ==# ''
    let query = ''
  elseif a:lead =~# '\v^\~[^/]+'
    echo 'zsh file completion'
    " Slow
    let parts = split(a:lead, '/')
    let parts[0] = vimrc#expand_dir_alias(parts[0])
    if v:shell_error
      return []
    endif
    let query = join(parts, '/')
  elseif stridx(a:lead, '/') != -1
    let query = a:lead
  else
    let pre_glob = glob('*' . a:lead . '*', 1, 1)
    if len(pre_glob) == 1 && isdirectory(pre_glob[0])
      let query = vimrc#add_slash_tail(pre_glob[0])
    else
      let query = '*' . a:lead
    endif
  endif

  let cands = []
  for path in glob(query . '*', 1, 1)
    if isdirectory(path)
      let path  .= '/'
    endif
    let path = vimrc#home2tilde(path)
    let cands += [path]
  endfor

  return cands
endfunction "}}}

function! vimrc#buffer_count(...) abort "{{{
  if a:0 == 0
    let cmd = 'ls!'
  elseif a:1 == 'a'   " active
    let cmd = 'ls! a'
  elseif a:1 == 'l'   " listed
    let cmd = 'ls'
  else
    let cmd = 'ls!'
  endif
  echo cmd
  return len(split(vimrc#capture(cmd), "\n"))
endfunction "}}}

" return list [bufnr, status, name]
function! vimrc#buffers_info(...) abort "{{{
  return map(split(vimrc#capture('ls' . (a:0? a:1 : '!')), '\n'),
        \ 'matchlist(v:val, ''\v^\s*(\d*)\s*(.....)\s*"(.*)"\s*.*\s(\d*)$'')[1:4]' )
endfunction "}}}

function! vimrc#auto_cursorcolumn() abort "{{{
  if &buftype != "" || &filetype == 'markdown'
    setlocal nocursorcolumn
    return
  endif

  if virtcol('.')-1 <= indent('.') && 1 < virtcol('.')
    setlocal cursorcolumn
  else
    setlocal nocursorcolumn
  endif
endfunction "}}}


" ---- function groups ----
" #syntax info
function! vimrc#get_syn_id(transparent) abort "{{{
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction "}}}

function! vimrc#get_syn_attr(synid) abort "{{{
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

function! vimrc#get_syn_info() abort "{{{
  let baseSyn = vimrc#get_syn_attr(vimrc#get_syn_id(0))
  let base = "name: "  . baseSyn.name    .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: "   . baseSyn.guifg   .
        \ " guibg: "   . baseSyn.guibg

  let linkedSyn = vimrc#get_syn_attr(vimrc#get_syn_id(1))
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

" #terminal run
" quickrunの設定をパースしてbuiltin-termで実行する
" TODO deprecated
function! vimrc#terminal_run() abort "{{{
  let config = vimrc#parse_quickrun_config()
  let cmd = vimrc#build_run_command(config)

  botright enew
  call termopen(cmd)
  startinsert
endfunction "}}}

function! vimrc#build_run_command(config) abort "{{{
  let cmd = a:config.exec
  if type(cmd) == type([])
    let cmd = join(cmd, ' && ')
  endif
  PP! a:config
  let cmd = substitute(cmd, '%c', a:config.command, 'g')
  let cmd = substitute(cmd, '%o', a:config.cmdopt, 'g')
  let cmd = substitute(cmd, '%a', a:config.args, 'g')
  let cmd = substitute(cmd, '%s', expand('%'), 'g')
  let cmd = expand(cmd) " TODO だめ
  return cmd
endfunction "}}}

function! vimrc#parse_quickrun_config() abort "{{{
  let config = quickrun#new().base_config

  return { 'type': config.type,
        \ 'command':  get(config, 'command', config.type),
        \ 'cmdopt':   get(config, 'cmdopt', ''),
        \ 'args':     get(config, 'args', ''),
        \ 'exec':     get(config, 'exec',  '%c %o %s %a'),
        \ }
endfunction "}}}

" #word translate
function! vimrc#word_translate_weblio(word) abort "{{{
  let l:html    = webapi#http#get('ejje.weblio.jp/content/' . tolower(a:word)).content
  let l:content = matchstr(l:html, '\Vname="description"\v.{-}content\=\"\zs.{-}\ze\"\>')
  let l:body    = matchstr(l:content, '\v.{-1,}\ze\s{-}\-\s', 0, 1)
  let l:body = tr(l:body, '《》【】', '<>[]')
  let l:body = vimrc#removechars(l:body, '★→１２')
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

function! vimrc#word_translate_weblio_smart(word) abort "{{{
  let l:reason = vimrc#word_translate_weblio(a:word)
  let l:prototype = matchstr(l:reason, '\v(\w+)\ze\s*の%(現在|過去|複数|三人称|直接法|間接法)')

  if '' !=# l:prototype
    let l:reason .= "\n" . vimrc#word_translate_weblio(l:prototype)
  endif

  return l:reason
endfunction "}}}

function! vimrc#word_translate_local_dict(word) abort "{{{
  if filereadable(expand(g:word_translate_local_dict))
    let l:str = system('grep -ihwA 1 ^' . a:word . '$ ' . g:word_translate_local_dict)
    return substitute(l:str, '\v(^|\n)(--|' . a:word . ')?(\_s|$)', '', 'gi')
  else
    return ''
  endif
endfunction "}}}

function vimrc#get_cword() abort "{{{
  let save_iskeyword = &l:iskeyword
  setl iskeyword=@
  try
    return expand('<cword>')
  finally
    let &l:iskeyword = save_iskeyword
  endtry
endfunction "}}}

function! vimrc#word_translate(...) abort "{{{
  let word = a:0? a:1 : vimrc#get_cword()

  let found = vimrc#word_translate_local_dict(word)
  if found !=# ''
    echo found
  else
    echo vimrc#word_translate_weblio_smart(word)
  endif
endfunction "}}}

function! vimrc#goldendict(...) abort "{{{
  let word = a:0? a:1 : vimrc#get_cword()
  call jobstart(['goldendict', word], {'detach': 1})
endfunction "}}}

" #color converter
function! vimrc#add_gui_color() range abort "{{{
  for linenum in range(a:firstline, a:lastline)
    let line = getline(linenum)
    if line !~# '\v^(\"\s*)?\s*hi'
      continue
    end
    call setline(linenum, line . ' ' . vimrc#get_add_gui_color(line))
  endfor
  silent! call repeat#set(":call vimrc#add_gui_color()\<cr>", a:lastline - a:firstline)
endfunction "}}}

function! vimrc#get_add_gui_color(line) abort "{{{
  let append = ''
  for key  in ['fg', 'bg', '']
    let val = matchstr(a:line, 'cterm' . key . '=\zs\v(\S+)')
    if val !=# ''
      let append .= printf('gui%s=%s ', key, vimrc#trans_color(val))
    endif
  endfor
  return substitute(append, '\s*$', '', '')
endfunction "}}}

" TODO standalone
function! vimrc#trans_color(color) abort "{{{
  if a:color !~# '^\x\+$'
    return a:color
  else
    return substitute(system(['colortrans', a:color]), '\n$', '', '')
  end
endfunction "}}}
