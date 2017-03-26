function! Execute(cmd)
  execute a:cmd
  return ""
endfunction

function! Ruby(str) abort
  return Capture('ruby ' . a:str)
endfunction

" #OptionStack "{{{
" 引数には = += -= 含めた値をとる
let g:option_stack = []

function! OptionPush(name, expr)
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
endfunction

function! OptionPop()
  let [name, value] = remove(g:option_stack, -1)
  execute 'setl ' . name . '=' . value
endfunction

function! OptionStackClean()
  let g:option_stack = []
endfunction
"}}}

" #Capture {{{
" cmdをクォートなしでとれる
command! -nargs=+ -complete=command
      \ Capture call Capture(<q-args>)

" cmdをクォートで囲んでとる
function! Capture(cmd)
  redir => l:out
  silent execute a:cmd
  redir END
  let g:capture = substitute(l:out, '\%^\n', '', '')
  return g:capture
endfunction

" #Capture New window
command! -nargs=+ -complete=command
      \ CaptureWin call CaptureWin(<q-args>)

function! CaptureWin(cmd)
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
endfunction
" }}}

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
" return list [bufnr,status,name]
command! BuffersInfo for buf in BuffersInfo() | echo buf | endfor
function! BuffersInfo(...)
  return map(split(Capture('ls' . (a:0? a:1 : '!')), '\n'),
        \ 'matchlist(v:val, ''\v^\s*(\d*)\s*(.....)\s*"(.*)"\s*.*\s(\d*)$'')[1:4]' )
endfunction

function! BufferCount()
  return len(split(Capture('ls!'), "\n"))
endfunction

function! ActiveBufferCount()
  return len(split(Capture('ls! a'), "\n"))
endfunction

function! ListedBufferCount()
  return len(split(Capture('ls'), "\n"))
endfunction

" #CurrentOnly "{{{
command! Conly call CurrentOnly()
command! CurrentOnly call CurrentOnly()
function! CurrentOnly()
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
endfunction
"}}}

" #ActiveOnly "{{{
command! Aonly call ActiveOnly()
command! ActiveOnly call ActiveOnly()
function! ActiveOnly()
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
endfunction
"}}}

command! DeleteTrashBuffers call DeleteTrashBuffers()
function! DeleteTrashBuffers()
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
endfunction

"}}}

" #Syntaxinfo "{{{
command! SyntaxInfo call s:get_syn_info()
function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction

function! s:get_syn_attr(synid)
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
endfunction

function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  let base = "name: "  . baseSyn.name    .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: "   . baseSyn.guifg   .
        \ " guibg: "   . baseSyn.guibg

  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
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
endfunction
"}}}

" #UndoClear"{{{
command! Uclear UndoClear
command! UndoClear :call UndoClear()
function! UndoClear()
  let l:old = &undolevels
  set undolevels=-1
  exe "normal a \<BS>\<Esc>"
  let &undolevels = l:old
  unlet l:old
  write
endfunction
"}}}

" #OpenGitDiff "{{{
command! OpenGitDiffWin call OpenGitDiff('w')
command! OpenGitDiffTab call OpenGitDiff('t')
function! OpenGitDiff(type)
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

" #Highlight "{{{
command! -complete=highlight -nargs=* Hi call Highlight(<f-args>)
function! Highlight(...)
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
endfunction
"}}}

" #WordTranslate "{{{
command! -nargs=1 Weblio echo WordTranslateWeblio(<f-args>)
function! WordTranslateWeblio(word) abort
  let l:html    = webapi#http#get('ejje.weblio.jp/content/' . tolower(a:word)).content
  let l:content = matchstr(l:html, '\Vname="description"\v.{-}content\=\"\zs.{-}\ze\"\>')
  let l:body    = matchstr(l:content, '\v.{-1,}\ze\s{-}\-\s', 0, 1)
  let l:body = tr(l:body, '《》【】', '<>[]')
  let l:body = s:removechars(l:body, '★→１２')
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
endfunction

command! -nargs=1 Weblios echo WordTranslateSmartWeblio(<f-args>)
function! WordTranslateSmartWeblio(word) abort
  let l:reason = WordTranslateWeblio(a:word)
  let l:prototype = matchstr(l:reason, '\v(\w+)\ze\s*の%(現在|過去|複数|三人称|直接法|間接法)')

  if '' !=# l:prototype
    let l:reason .= "\n" . WordTranslateWeblio(l:prototype)
  endif

  return l:reason
endfunction

command! -nargs=? WtransLocal call WordTranslateLocalDict(<f-args>)
let g:word_translate_local_dict = '~/.vim/tmp/gene.dict'
function! WordTranslateLocalDict(word) abort
  if filereadable(expand(g:word_translate_local_dict))
    let l:str = system('grep -ihwA 1 ^' . a:word . '$ ' . g:word_translate_local_dict)
    return substitute(l:str, '\v(^|\n)(--|' . a:word . ')?(\_s|$)', '', 'gi')
  else
    return ''
  endif
endfunction

command! -nargs=? WordTranslate call WordTranslate(<f-args>)
function! WordTranslate(...)
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

  let found = WordTranslateLocalDict(word)
  if found !=# ''
    echo found
  else
    echo WordTranslateSmartWeblio(word)
  endif
endfunction
"}}}

" #GotoVimFunction "{{{
function! GotoVimFunction()
  let func_name = matchstr(getline('.'),  '\v%(.\:)?\zs(%(\w|_|#|\.)*)\ze\(.*\)')
  if empty(func_name)
    return 1
  endif

  exec 'lvimgrep /\vfu%[nction]\!?\s+(.\:)?' . func_name . '/' . '`git ls-files`'
  call setloclist(0, [])
  silent! HierUpdate
  normal! zv
endfunction
"}}}

" #Blank "{{{
nnoremap <silent> <Plug>(BlankUp)   :<C-U>call <SID>BlankUp(v:count1)<CR>
nnoremap <silent> <Plug>(BlankDown) :<C-U>call <SID>BlankDown(v:count1)<CR>

function! s:BlankUp(count) abort
  put!=repeat(nr2char(10), a:count)
  ']+1
  silent! call repeat#set("\<Plug>(BlankUp)", a:count)
endfunction

function! s:BlankDown(count) abort
  put =repeat(nr2char(10), a:count)
  '[-1
  silent! call repeat#set("\<Plug>(BlankDown)", a:count)
endfunction
"}}}

" #Move "{{{
nnoremap <silent><Plug>(MoveUp)   :<C-u>call <SID>Move(v:count1, 1, 0)<CR>
nnoremap <silent><Plug>(MoveDown) :<C-u>call <SID>Move(v:count1, 0, 0)<CR>
xnoremap <silent><Plug>(MoveUp)   :<C-u>call <SID>Move(v:count1, 1, 1)<CR>
xnoremap <silent><Plug>(MoveDown) :<C-u>call <SID>Move(v:count1, 0, 1)<CR>

function! s:Move(count, is_up, is_visual) abort
  let save_reg = 'p'
  call PushReg(save_reg)
  let pos  = getcurpos()
  let delete = (a:is_visual? '*' : '') . 'delete ' . save_reg

  if a:is_up
    let line = a:count
    if s:is_lastline(a:is_visual)
      let line -= 1
    endif

    exec delete
    silent! exec 'normal!' repeat('k', line)
    execute 'put!' save_reg
  else
    exec delete
    silent! exec 'normal!' repeat('j', a:count-1)
    execute 'put' save_reg
  endif

  let pos[1] = line('.')
  call setpos('.', pos)
  call PopReg(save_reg)

  if a:is_visual
    normal! '[V']
  else
    silent! call repeat#set("\<Plug>(Move" . (a:is_up? 'Up)': 'Down)'), a:count)
  endif
endfunction
"}}}

" #Git "{{{
command! CdGitTop execute 'cd' g:GitTop()
command! Cdtop CdGitTop
function! g:GitTop()
  return system('git rev-parse --show-toplevel')
endfunction
"}}}

" #Misc "{{{
noremap <Plug>(delete_for_match) :<c-u>call <SID>delete_for_match()<CR>
function! s:delete_for_match() abort
  normal! V^
  normal %
  normal! d
  call repeat#set("\<Plug>(delete_for_match)")
endfunction

" cursolがlastlineにあるかどうか
function! s:is_lastline(is_visual)
  let last = line('$')
  return line('.') == last || foldclosedend(line('.')) == last || (a:is_visual && line("'>") == last)
endfunction

function! s:removechars(str, pattern) abort
  return substitute(a:str, '[' . a:pattern . ']', '', 'g')
endfunction

function s:home2tilde(str)
  return substitute(a:str, '^' . expand('~'), '~', '')
endfunction

function! s:add_slash_tail(str)
  return substitute(a:str, '/*$', '/', '')
endfunction

function! s:delete_str(str, pattern, ...)
  return substitute(a:str, a:pattern, '', get(a:000, 0, ''))
endfunction

function RemoveOptVal(optname, chars)
  for c in  split(a:chars, '.\zs')
    execute printf('setl %s-=%s', a:optname, c)
  endfor
endfunction

function! ResetHightlights() abort
  nohlsearch
  silent! QuickhlManualReset
  silent! RCReset
  call clearmatches()
endfunction

let g:u10_autosave = 0
nnoremap <silent><F2> :call AutoSave()<CR>
function! AutoSave() abort
  silent update
  let g:u10_autosave = !g:u10_autosave
  echo 'autosave' g:u10_autosave? 'enabled' : 'disabled'
endfunction

function! DoAutoSave() abort
  if g:u10_autosave != 0
    update
  endif
endfunction

let g:reg_stack = []
function! PushReg(reg) abort
  call add(g:reg_stack, [getreg(a:reg, 1), getregtype(a:reg)])
endfunction

function! PopReg(reg) abort
  let data = remove(g:reg_stack, -1)
  call setreg(a:reg, data[0], data[1])
endfunction

function! DummyArray(start, last, times) abort
  return Ruby(printf("print Array.new(%d){ Random.rand(%d..%d )}.join(', ')", a:times, a:start, a:last))
endfunction

command! AddRepo call AddRepo()
function! AddRepo() abort
  call append(line('.'), printf("repo = '%s'", matchstr(@+, '\v([^/]*/[^/]*)$')))
  call append(line('.'), '[[plugins]]')
  normal! }
endfunction

command Let2Var s/\vlet\!?\(:([^)]*)\)\s*\{\s*([^}]*)\s*\}/\1 = \2/
"}}}

" #Tabedit "{{{
" zsh like tabedit.
if executable('zsh')
  command! -nargs=1 -complete=customlist,ZshFileCompletion T tabedit <args>
endif

function s:expand_filename_tilde(str)
    let path = system(printf("zsh -ic 'echo -n %s'", a:str))
    return s:home2tilde(path)
endfunction

function! ZshFileCompletion(lead, line, pos)
  if a:lead ==# '#'
    return map(BuffersInfo(''), 'v:val[2]')
  elseif a:lead ==# ''
    let query = ''
  elseif a:lead =~# '\v^\~[^/]+'
    echo 'zsh file completion'
    " Slow
    let parts = split(a:lead, '/')
    let parts[0] = s:expand_filename_tilde(parts[0])
    if v:shell_error
      return []
    endif
    let query = join(parts, '/')
  elseif stridx(a:lead, '/') != -1
    let query = a:lead
  else
    let pre_glob = glob('*' . a:lead . '*', 1, 1)
    if len(pre_glob) == 1 && isdirectory(pre_glob[0])
      let query = s:add_slash_tail(pre_glob[0])
    else
      let query = '*' . a:lead
    endif
  endif

  let cands = []
  for path in glob(query . '*', 1, 1)
    if isdirectory(path)
      let path  .= '/'
    endif
    let path = s:home2tilde(path)
    let cands += [path]
  endfor

  return cands
endfunction
"}}}

" #Notes "{{{
if executable('note')
  let g:note_path = system('note')[0:-2]
  command! -nargs=1 -complete=customlist,NoteFileCompletion Note call g:NoteOpen(<q-args>)

  function! g:NoteOpen(name) abort
    let l:name = system(['note', '-S', a:name])[0:-2]
    if name ==# ''
      echo printf('%s not found', a:name)
    endif

    exec 'tabedit' l:name
  endfunction

  function g:NoteFileCompletion(lead, line, pos) abort
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
  endfunction
endif
"}}}

" #TerminalRun "{{{
" quickrunの設定をパースしてtermで実行する
" TODO  プラグインにしてもいいかも quickrun-terminal

nnoremap <silent>\tr :TermRun<cr>
command! TermRun noautocmd w | call TerminalRun()

function! TerminalRun() abort
  let config = GetRunConfig(&ft)
  let cmd = BuildRunCommand(expand('%'), config)

  botright sp +enew
  call termopen(cmd)
  startinsert
endfunction

function! BuildRunCommand(src, config) abort
  let cmd = a:config.exec
  let cmd = substitute(cmd, '%c', a:config.command, 'g')
  let cmd = substitute(cmd, '%o', a:config.cmdopt, 'g')
  let cmd = substitute(cmd, '%a', a:config.args, 'g')
  let cmd = substitute(cmd, '%s', a:src, 'g')
  return cmd
endfunction

function! GetRunConfig(filetype) abort
  let config = {}
  let type = {'type': a:filetype}

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
endfunction
"}}}
