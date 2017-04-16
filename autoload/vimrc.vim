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

" textobj
" blankline "{{{
function! vimrc#textobj_blankline(flags) abort
  let l:flags = 'n' . a:flags
  return ['V', getpos('.'), [0] + searchpos('^\s*$', l:flags) + [0]]
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
  silent! '[,']s/\v%(^)@<!\s*$/ /
  undojoin
  '[,']fold
endfunction "}}}

" gf create new file
function! vimrc#gf_newfile() abort "{{{
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

function! vimrc#gf_ruby() abort "{{{
  " variables "{{{
  if !exists('g:ruby_version')
    " let g:ruby_version = matchstr(system('ruby --version'), '\v^ruby\s+\zs(\d\.?)+')
    let g:ruby_version = '2.4.0'
  endif

  if !exists('g:gf_ruby_path')
    " 標準の自動探査だと重い
    let g:gf_ruby_path = join([
          \ expand('~/.rubylib/'),
          \ expand('~/.gem/ruby/'.g:ruby_version),
          \ expand('~/.gem/ruby/'.g:ruby_version.'/gems'),
          \ '/usr/lib/ruby/vendor_ruby/'.g:ruby_version,
          \ '/usr/lib/ruby/vendor_ruby/'.g:ruby_version.'/x86_64-linux',
          \ '/usr/lib/ruby/vendor_ruby',
          \ '/usr/lib/ruby/'.g:ruby_version,
          \ '/usr/lib/ruby/'.g:ruby_version.'/x86_64-linux',
          \ ], ',')
          " \ '~/.gem/ruby/'.g:ruby_version.'/gems/did_you_mean-1.1.2/lib',
  endif
  "}}}

  let save_path = &l:path
  try
    let &l:path = g:gf_ruby_path
    let l:count = 1

    " require_relative
    if getline('.') =~# '\v^\s*require_relative\s*(["'']).*\1\s*$'
      let filepath = '%:h/' .  matchstr(getline('.'),'\v(["''])\zs.{-}\ze\1') . '.rb'

    " require | load | autoload
    elseif getline('.') =~# '^\s*\%(require[( ]\|load[( ]\|autoload[( ]:\w\+,\)\s*\s*\%(::\)\=File\.expand_path(\(["'']\)\.\./.*\1,\s*__FILE__)\s*$'
      let filepath =  '%:h/' . matchstr(getline('.'),'\(["'']\)\.\./\zs.\{-\}\ze\1') . '.rb'
    else
      if getline('.') =~# '^\s*\%(require \|load \|autoload :\w\+,\)\s*\(["'']\).*\1\s*$'
        let filepath = matchstr(getline('.'),'\(["'']\)\zs.\{-\}\ze\1')
      else
        let filepath = expand('<cfile>')
      end
      let filepath = fnameescape(findfile(filepath, &path, l:count))
    endif

    if filepath ==# ''
      return 0
    else
      return {'path': filepath, 'line': 0, 'col': 0,}
    endif
  finally
    let &l:path = save_path
  endtry
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
function! vimrc#terminal_run() abort "{{{
  let config = vimrc#parse_quickrun_config(&ft)
  let cmd = vimrc#build_run_command(config)

  botright sp +enew
  call termopen(cmd)
  startinsert
endfunction "}}}

function! vimrc#build_run_command(config) abort "{{{
  let cmd = a:config.exec
  if type(cmd) == type([])
    let cmd = join(cmd, ' && ')
  endif
  let cmd = substitute(cmd, '%c', a:config.command, 'g')
  let cmd = substitute(cmd, '%o', a:config.cmdopt, 'g')
  let cmd = substitute(cmd, '%a', a:config.args, 'g')
  let cmd = substitute(cmd, '%s', a:src, 'g')
  " TODO :p:rが展開されない
  let cmd = expand(cmd)
  return cmd
endfunction "}}}

function! vimrc#parse_quickrun_config(filetype) abort "{{{
  let config = {}
  let type = {'type': a:filetype}

  " TODO quickrunの実行前後でオプションが変わる
  " ConsoleLog cmd
  " ConsoleLog a:config

  for c in [
        \ 'b:quickrun_config',
        \ 'type',
        \ 'g:quickrun_config[config.type]',
        \ 'g:quickrun#default_config[config.type]',
        \ 'g:quickrun_config["_"]',
        \ 'g:quickrun_config["*"]',
        \ 'g:quickrun#default_config["_"]',
        \ ]
    if exists(c)
      let new_config = eval(c)
      if 0 <= stridx(c, 'config.type')
        let config_type = ''
        while has_key(config, 'type') && has_key(new_config, 'type')
              \   && config.type !=# '' && config.type !=# config_type
          let config_type = config.type
          call extend(config, new_config, 'keep')
          let config.type = new_config.type
          let new_config = exists(c) ? eval(c) : {}
        endwhile
      endif
      call extend(config, new_config, 'keep')
    endif
  endfor

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

function! vimrc#word_translate(...) abort "{{{
  if !a:0
    if &l:ft == 'help'
      let word = expand('<cword>')
    else
      let save_iskeyword = &l:iskeyword
      setl iskeyword=@
      try
        let word = expand('<cword>')
      finally
        let &l:iskeyword = save_iskeyword
      endtry
    endif
  else
    let word = a:1
  endif

  let found = vimrc#word_translate_local_dict(word)
  if found !=# ''
    echo found
  else
    echo vimrc#word_translate_weblio_smart(word)
  endif
endfunction "}}}
