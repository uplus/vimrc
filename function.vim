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

function Execute(cmd) "{{{
  execute a:cmd
  return ""
endfunction "}}}

" #OpenGitDiff "{{{
command! OpenGitDiffWin call OpenGitDiff('w')
command! OpenGitDiffTab call OpenGitDiff('t')
function! OpenGitDiff(type)
  let cmdname = 'git diff ' .  bufname('%')
  silent! execute 'bdelete \[' . escape(cmdname, ' ') . '\]'

  let tmp_spr = &splitright
  set splitright
  execute (a:type == 't')? 'tabnew' : 'vnew' '[' . cmdname . ']'
  let &splitright=tmp_spr

  setl buftype=nofile
  setl filetype=diff
  setl undolevels=-1
  setl nofoldenable
  setl foldcolumn=0
  silent put! =system(cmdname)
  nnoremap <buffer><silent>q :bdelete!<CR>
endfunction "}}}

" #Hi "{{{
command! -complete=highlight -nargs=+ Hi call Hili(<f-args>)
command! -complete=highlight -nargs=+ Hili call Hili(<f-args>)
function! Hili(group, ...)
  let cmd = "highlight " . a:group
  if a:0 == 1
    let cmd .= " ctermfg=" . a:1
  elseif a:0 == 2
    let cmd .= " ctermbg=" . a:2
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
    call OptionPush('iskeyword', '=@')
    let word = expand('<cword>')
    call OptionPop()
  else
    let word = a:1
  endif

  let str = system('grep -ihwA 1 ^' . word . '$ ' . g:wtrans_dict)
  let found = substitute(str, '\v(^|\n)(--|' . word . ')?(\_s|$)', '', 'gi')

  if found !=# ''
    echo found
  else
    echo "Not found " . word
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
nnoremap <silent> <Plug>(MoveUp)   :<C-U>call <SID>Move('--',v:count1,'Up')<CR>
nnoremap <silent> <Plug>(MoveDown) :<C-U>call <SID>Move('+',v:count1,'Down')<CR>
xnoremap <silent> <Plug>(MoveSelectionUp)   :<C-U>call <SID>MoveSelectionUp(v:count1)<CR>
xnoremap <silent> <Plug>(MoveSelectionDown) :<C-U>call <SID>MoveSelectionDown(v:count1)<CR>

function! s:Move(cmd, count, map) abort
  if -1 != foldclosed('.')
    keepjumps execute 'normal!' foldclosed('.') . 'ggm<'
    keepjumps execute 'normal!' foldclosedend('.') . 'ggm>'

    if a:cmd ==# '--'
      call <SID>MoveSelectionUp(a:count)
    else
      call <SID>MoveSelectionDown(a:count)
    endif

    return
  endif

  normal! m`
  call OptionPush('viewoptions', '=folds')
  mkview!
  silent! exe 'move' . a:cmd . a:count
  loadview
  call OptionPop()
  normal! ``
  silent! call repeat#set("\<Plug>(Move)".a:map, a:count)
endfunction

function! s:MoveSelectionUp(count) abort
  normal! m`
  call OptionPush('viewoptions', '=folds')
  mkview!
  silent! exe "'<,'>move'<--".a:count
  loadview
  call OptionPop()
  normal! ``
  silent! call repeat#set("\<Plug>(MoveSelectionUp)", a:count)
endfunction

function! s:MoveSelectionDown(count) abort
  normal! m`
  call OptionPush('viewoptions', '=folds')
  mkview!
  exe "'<,'>move'>+".a:count
  loadview
  call OptionPop()
  normal! ``
  silent! call repeat#set("\<Plug>(MoveSelectionDown)", a:count)
endfunction
"}}}
