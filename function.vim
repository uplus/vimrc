
" noremap <Plug>(delete_for_match) :<c-u>call u10#delete_for_match()<cr>
" function! u10#delete_for_match() abort "{{{
"   normal! V^
"   normal %
"   normal! d
"   call repeat#set("\<Plug>(delete_for_match)")
" endfunction "}}}

" #OptionStack
let g:option_stack = []

function! Execute(cmd)
  execute a:cmd
  return ""
endfunction

function! Ruby(str) abort
  return Capture('ruby ' . a:str)
endfunction

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
command! BuffersInfo PP BuffersInfo()

" return list [bufnr, status, name]
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

"}}}


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
    if u10#is_lastline(a:is_visual)
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

" #Git
command! CdGitTop execute 'cd' u10#git_top()
command! Cdtop CdGitTop

" #Tabedit "{{{
" zsh like tabedit.
if executable('zsh')
  command! -nargs=1 -complete=customlist,ZshFileCompletion T tabedit <args>
endif

function! ZshFileCompletion(lead, line, pos)
  if a:lead ==# '#'
    return map(BuffersInfo(''), 'v:val[2]')
  elseif a:lead ==# ''
    let query = ''
  elseif a:lead =~# '\v^\~[^/]+'
    echo 'zsh file completion'
    " Slow
    let parts = split(a:lead, '/')
    let parts[0] = u10#expand_dir_alias(parts[0])
    if v:shell_error
      return []
    endif
    let query = join(parts, '/')
  elseif stridx(a:lead, '/') != -1
    let query = a:lead
  else
    let pre_glob = glob('*' . a:lead . '*', 1, 1)
    if len(pre_glob) == 1 && isdirectory(pre_glob[0])
      let query = u10#add_slash_tail(pre_glob[0])
    else
      let query = '*' . a:lead
    endif
  endif

  let cands = []
  for path in glob(query . '*', 1, 1)
    if isdirectory(path)
      let path  .= '/'
    endif
    let path = u10#home2tilde(path)
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
  return Ruby(printf("print Array.new(%d){ Random.rand(%d..%d)}.join(', ')", a:times, a:start, a:last))
endfunction

