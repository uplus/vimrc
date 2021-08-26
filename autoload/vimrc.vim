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
  if type(a:expr) ==# v:t_string
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
  if join(getline("'[", "']"), '') =~# '\%^\_s*\%$'
    execute printf('normal! `[%s`]"_d', v)
  else
    execute printf('normal! `[%s`]d', v)
  endif
endfunction "}}}

function! vimrc#operator_space_fold(motion_wise) abort "{{{
  " vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
  '<s/\v%(^)@<!\s*$/ /e
  undojoin
  '>s/\v%(^)@<!\s*$/ /e
  undojoin
  '<,'>fold
  " vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
endfunction "}}}

" arg1: command string
" arg2: open command
function! vimrc#terminal(...) abort
  " arg1
  let l:cmd = empty(a:1) ? $SHELL : $SHELL . ' -ic ' . a:1
  let l:cmd = substitute(l:cmd, ' ', '\\ ', 'g')

  " arg2
  let l:open_cmd = get(a:, 2, 'botright split')

  execute l:open_cmd '+terminal\' l:cmd
  silent setl ft= nobuflisted bufhidden undolevels=-1 nofoldenable nonumber foldcolumn=0 signcolumn=no

  silent tnoremap <esc> <c-\><c-n><c-w>c
  silent nnoremap <buffer>q <c-w>c
  startinsert
endfunction

" cmd毎にbufferを分けたい
function! vimrc#working_terminal(...) abort "{{{
  let l:cmd = get(a:, 1, '')
  let l:open_cmd = get(a:, 2, 'botright split')

  if bufexists(get(g:, 'vimrc#working_terminal_nr', -1))
    " 既に存在するバッファを開く
    exec l:open_cmd bufname(g:vimrc#working_terminal_nr)
  else
    call vimrc#terminal(l:cmd, l:open_cmd)
    let g:vimrc#working_terminal_nr = bufnr('%')
    au myac TermClose <buffer> unlet g:vimrc#working_terminal_nr
  endif
endfunction "}}}

function! vimrc#add_repo() abort "{{{
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

function! vimrc#highlight(...) abort "{{{
  if 0 == a:0
    return
  endif

  let cmd = 'highlight ' . a:1

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
      execute cmd 'ctermfg=' . args[0]
    endif

    if 2 <= len(args)
      execute  cmd 'ctermbg=' . args[1]
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

  execute 'silent!' ((a:type ==# 't')? 'tabnew' : printf('botright vsplit git-diff-%s', escape(cmdname, ' ')))
  let s:git_diff_bufnr = bufnr('%')

  " diff_config()で設定しようとするとnofileのタイミングが遅い
  setl buftype=nofile
  setl modifiable
  setl undolevels=-1
  setl nofoldenable
  setl nonumber
  setl foldcolumn=0

  " ファイルタイプをセットするとのが早いとバグる
  setfiletype diff

  execute 'lcd' filedir
  silent put! =system(cmdname)
  $delete
  nnoremap <silent><buffer>q :call <sid>bwipeout_and_back()<cr>

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
      execute 'bwipeout' l:buf[0]
      let l:count+=1
    endif
  endfor

  echo l:count 'buffer deleted'
  let &report=l:old
endfunction "}}}

function! vimrc#active_only() abort "{{{
  let l:old = &report
  set report=1000
  let l:count=0

  for l:buf in vimrc#buffers_info()
    if -1 == stridx(l:buf[1], 'a') && l:buf[2] !~# '^term'
      execute 'bwipeout' l:buf[0]
      let l:count+=1
    endif
  endfor

  echo l:count 'buffer deleted'
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
  let l:head_matched = filter(copy(files), 'v:val =~# "^" . l:name')
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
  elseif a:1 ==# 'a'   " active
    let cmd = 'ls! a'
  elseif a:1 ==# 'l'   " listed
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
  if &buftype !=# '' || &filetype ==# 'markdown'
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
  let synid = synID(line('.'), col('.'), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction "}}}

function! vimrc#get_syn_attr(synid) abort "{{{
  let name    = synIDattr(a:synid, 'name')
  let ctermfg = synIDattr(a:synid, 'fg', 'cterm')
  let ctermbg = synIDattr(a:synid, 'bg', 'cterm')
  let guifg   = synIDattr(a:synid, 'fg', 'gui')
  let guibg   = synIDattr(a:synid, 'bg', 'gui')
  return {
        \ 'name'    : name,
        \ 'ctermfg' : ctermfg,
        \ 'ctermbg' : ctermbg,
        \ 'guifg'   : guifg,
        \ 'guibg'   : guibg }
endfunction "}}}

function! vimrc#get_syn_info() abort "{{{
  let baseSyn = vimrc#get_syn_attr(vimrc#get_syn_id(0))
  let base = 'name: '  . baseSyn.name    .
        \ ' ctermfg: ' . baseSyn.ctermfg .
        \ ' ctermbg: ' . baseSyn.ctermbg .
        \ ' guifg: '   . baseSyn.guifg   .
        \ ' guibg: '   . baseSyn.guibg

  let linkedSyn = vimrc#get_syn_attr(vimrc#get_syn_id(1))
  let link = 'name: '  . linkedSyn.name    .
        \ ' ctermfg: ' . linkedSyn.ctermfg .
        \ ' ctermbg: ' . linkedSyn.ctermbg .
        \ ' guifg: '   . linkedSyn.guifg   .
        \ ' guibg: '   . linkedSyn.guibg

  echo base
  if base != link
    echo 'link to'
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

function vimrc#get_cword() abort
  let save_iskeyword = &l:iskeyword
  setl iskeyword=@
  try
    return expand('<cword>')
  finally
    let &l:iskeyword = save_iskeyword
  endtry
endfunction

function! vimrc#goldendict(...) abort
  let word = a:0? a:1 : vimrc#get_cword()
  call jobstart(['goldendict', word], {'detach': 1})
endfunction
