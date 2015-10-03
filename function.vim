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

" cursolがlastlineにあるかどうか
function! s:is_lastline(is_visual)
  let last = line('$')
  return line('.') == last || foldclosedend(line('.')) == last || (a:is_visual && line("'>") == last)
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
" }}}

" #Capture New window {{{
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
command! EraseSpace :call EraseSpace()
command! EraseSpaceEnable :let g:erase_space_on=1
command! EraseSpaceDisable :let g:erase_space_on=0
function! EraseSpace()
  if g:erase_space_on != 1
    return
  endif

  " filetypeが一致したらreturn
  if index(['markdown', 'gitcommit'], &filetype) != -1
    return
  endif

  let l:cursor = getpos(".")
  %s/\s\+$//ge
  call setpos(".", l:cursor)
endfunction
"}}}

" #Buffer functions "{{{

" #BuffersInfo
" bufnr status modified name を返す
command! BuffersInfo for buf in BuffersInfo() | echo buf | endfor
function! BuffersInfo()
  return map(split(Capture('ls'), '\n'),
        \ 'matchlist(v:val, ''\v^\s*(\d*)\s+([^ ]*)\s*(\+?)\s*"(.*)"\s*.*\s(\d*)$'')[1:4]' )
endfunction

command! BufferCount ruby print VIM::Buffer.count
function! BufferCount()
  return Capture("BufferCount")
endfunction

command! Ao Aonly
function! ActiveBufferCount()
  let l:count = 0
  for l:buf in BuffersInfo()
    if -1 != stridx(l:buf[1], 'a')
      let l:count+=1
    endif
  endfor
  return l:count
endfunction

" #CurrentOnly
command! Co Conly
command! Conly call CurrentOnly()
command! CurrentOnly call CurrentOnly()
function! CurrentOnly()
  let l:old = &report
  set report=1000
  let l:count=0

  for l:buf in BuffersInfo()
    if -1 == stridx(l:buf[1], '%')
      execute "bdelete" l:buf[0]
      let l:count+=1
    endif
  endfor

  echo l:count "buffer deleted"
  let &report=l:old
endfunction

" #ActiveOnly
command! Aonly call ActiveOnly()
command! ActiveOnly call ActiveOnly()
function! ActiveOnly()
  let l:old = &report
  set report=1000
  let l:count=0

  for l:buf in BuffersInfo()
    if -1 == stridx(l:buf[1], 'a')
      execute "bdelete" l:buf[0]
      let l:count+=1
    endif
  endfor

  echo l:count "buffer deleted"
  let &report=l:old
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

" TODO: 動作検証
function! OneShotAutocmd(name, event, pattern, cmd) "{{{
  function l:tmp_func()
    execute cmd
    autocmd! {a:name}
  endfunction

  augroup a:name
    autocmd!
    autocmd {a:event} {a:pattern} call l:tmp_func()
  augroup END
endfunction "}}}

command! Uclear UndoClear "{{{
command! UndoClear :call UndoClear()
function! UndoClear()
  let l:old = &undolevels
  set undolevels=-1
  exe "normal a \<BS>\<Esc>"
  let &undolevels = l:old
  unlet l:old
  write
endfunction "}}}

function! Execute(cmd) "{{{
  execute a:cmd
  return ""
endfunction "}}}

" #OpenGitDiff "{{{
command! OpenGitDiffWin call OpenGitDiff('w')
command! OpenGitDiffTab call OpenGitDiff('t')
function! OpenGitDiff(type)
  silent! update
  let s:before_winnr = winnr()
  let cmdname = 'git diff ' .  bufname('%')
  silent! execute 'bwipeout \[' . escape(cmdname, ' ') . '\]'

  execute (a:type == 't')? 'tabnew' : 'botright vsplit' '[' . cmdname . ']'

  " diff_config()で設定しようとするとnofileのタイミングが遅い
  setfiletype diff
  setl buftype=nofile
  setl undolevels=-1
  setl nofoldenable
  setl nonumber
  setl foldcolumn=0
  silent put! =system(cmdname)
  $delete
  nnoremap <silent><buffer>q :call <SID>bwipeout_and_back()<CR>

  function! s:bwipeout_and_back()
    bwipeout!
    execute 'normal!' s:before_winnr ."\<C-w>w"
  endfunction
endfunction "}}}

" #Hi "{{{
command! -complete=highlight -nargs=+ Hi call Hili(<f-args>)
command! -complete=highlight -nargs=+ Hili call Hili(<f-args>)
function! Hili(group, ...)
  let cmd = "highlight " . a:group

  if 1 <=  a:0
    let cmd .= " ctermfg=" . a:1

    if 2 <= a:0
      let cmd .= " ctermbg=" . a:2
    endif
  endif

  execute cmd
endfunction
"}}}

" #WordTranslate "{{{
let g:wtrans_dict = '~/.vim/dict/gene.dict'
command! -nargs=? WTrans call WordTranslate(<f-args>)
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

  let str = system('grep -ihwA 1 ^' . word . '$ ' . g:wtrans_dict)
  let found = substitute(str, '\v(^|\n)(--|' . word . ')?(\_s|$)', '', 'gi')

  if found !=# ''
    echo found
  else
    echo "Not found " . word
    call openbrowser#smart_search(expand("<cword>"))
  endif
endfunction
"}}}

" #GotoVimFunction "{{{
" goto function declaration on vim
function! GotoVimFunction()
  let matched = matchlist(getline('.'),  '\vcall\s+%(.:)?(.*)\(.*\)')
  if empty(matched)
    echo 'function not found on current cursor.'
    return 1
  endif

  if !search('\vfu%[nction]!?\s+(.:)?' . matched[1], 'w')
    echo 'function declaration not found.'
  endif
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
  let pos  = getcurpos()
  let delete = (a:is_visual? '*' : '') . 'delete'

  if a:is_up
    let line = a:count
    if s:is_lastline(a:is_visual)
      let line -= 1
    endif

    exec delete
    silent! exec 'normal!' repeat('k', line)
    normal! P
  else
    exec delete
    silent! exec 'normal!' repeat('j', a:count-1)
    normal! p
  endif

  let pos[1] = line('.')
  call setpos('.', pos)

  if a:is_visual
    normal! '[V']
  else
    call repeat#set("\<Plug>(Move" . (a:is_up? 'Up)': 'Down)'), a:count)
  endif
endfunction
"}}}
