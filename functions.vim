" vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect

" #AutoSave "{{{
let g:my_autosave = v:true
command! EnableAutoSave let g:my_autosave = v:true
command! DisableAutoSave let g:my_autosave = v:false

function! DoAutoSave() abort
  " 無効 | 補完中 | 書き込み負荷 | 特定ファイルタイプ
  if !g:my_autosave || pumvisible() || !u#is_writable_buf() || u#is_include(['narrow'], &filetype)
    return
  end

  " for debug
  " echo 'auto save at' strftime('%T') bufname() &filetype

  " silent! update
  silent! wall
  silent! SignifyRefresh
  " silent! ALELint
endfunction
"}}}

function! EraseSpace() abort "{{{
  " filetypeが一致したらreturn
  if -1 != index(['markdown', 'gitcommit', 'help'], &filetype)
    return
  endif

  " for vim-precious
  if expand('%') =~# '.md$'
    return
  endif

  let l:pos = getpos('.')
  %s/\s\+$//eI
  while getline('$') =~# '^\s*$'
    $delete
  endwhile
  call setpos('.', l:pos)
endfunction "}}}

command! HTMLalign call HTMLalign()
function! HTMLalign() abort "{{{
  %s/\v\>\</>\r</eI
  setfiletype html
  normal! gg=G
endfunction "}}}

function! Format() abort "{{{
  call EraseSpace()

  if exists('b:format_cmd')
    execute b:format_cmd
  endif
endfunction "}}}

function! FormatJS() abort
  %! js-beautify -
endfunction

function! FormatSQL() abort
  %s/,\ze\d/,/e
  %s/\v(IFNULL|SUM|TRUNCATE|\()\zs\s+\(/(/e
  %s/\v\(\s+\ze(\w|['`(])/(/e
  %s/\v(['`)]|\w)\zs\s+\)/)/e
endfunction

function! ResetHighlights() abort "{{{
  " nohlsearch " 関数内では動作しない
  silent! call clever_f#reset()
  silent! LinediffReset
  silent! QuickhlManualReset
  silent! RCReset
  silent! HierClear
  silent! call lightline#update()
  ClearLocList
  " call clearmatches()
endfunction "}}}

" let g:tags_jobs = {}
" function! Tags() abort "{{{
"   let l:dir = expand('%:p:h')
"   silent! call jobstop(get(g:tags_jobs, l:dir, -1))
"   let g:tags_jobs[l:dir] = jobstart(get(b:, 'tags_cmd', 'ctags'))
" endfunction "}}}

" 現在行か選択範囲に引数の演算を適用する
command! -nargs=1 -range Inject echomsg Inject(<f-args>)
function! Inject(expr) abort "{{{
  let pos_save = getpos('.')
  try
    execute printf('silent normal! gv"%sy', g:working_register)
    let values = split(getreg(g:working_register))
    return u#fold(values, a:expr)
  finally
    call setpos('.', pos_save)
  endtry
endfunction "}}}

function! Job(...) abort "{{{
  if exists('*jobstart')
    call jobstart(a:000)
  elseif exists('*job_start')
    call job_start(a:000)
  else
    " echo "job not found"
  endif
endfunction "}}}

function Debug(data) "{{{
  let g:debug_data = a:data
  PP! a:data
endfunction "}}}

" unix sortに似た使い勝手
command! -nargs=+ -range=% Sort <line1>,<line2>call Sort(<f-args>)
function! Sort(k, ...) abort range "{{{
  let pos = getpos('.')

  " 1列目でソートしたいなら0
  let k = a:k - 1
  " セパレータをデフォルト引数で取る
  let sep = get(a:000, 0, ', ')
  execute printf('%d,%dsort /\v([^%s]+[%s]+){%d}\zs/', a:firstline, a:lastline, sep, sep, k)

  call setpos('.', pos)
endfunction "}}}

function! OpenCop() abort "{{{
  let rule = u#delete_chars(expand('<cWORD>'), ':')
  let rule_downcase =  substitute(rule, '.', '\L\0', 'g')
  let group = matchstr(rule_downcase, '^.*\ze/')
  let tag = u#delete_chars(rule_downcase, '/')

  " https://docs.rubocop.org/rubocop/cops_layout.html#layoutemptylinebetweendefs
  call openbrowser#open('https://docs.rubocop.org/rubocop/cops_' . group . '.html#' . tag)
endfunction "}}}

function! JoinText(text) abort "{{{
  let str = a:text

  " remove head comment marker
  let comment_marker = substitute(&commentstring, '%s\|\s', '', 'g')
  let str = substitute(str, '^\s*' . comment_marker . '\s*', '', 'g')
  let str = substitute(str, '\n\zs\s*' . comment_marker . '\s*', '', 'g')

  " replace symbols to "
  let str = substitute(str, '\v[`|]', '"', 'g')

  " remove head & tail space
  let str = substitute(str, '^\s\+', '', 'g')
  let str = substitute(str, '\n\zs\s\+', '', 'g')
  let str = substitute(str, '\s\+\ze\n', '', 'g')

  " join dash separated word
  let str = substitute(str, '-\n', '', 'g')

  " join \r\n separeted paragraph.
  " keep
  "   empty line(\n\n)
  "   paragraph end (.\n)
  "   list (\n-\s)
  "   num list (\d+\.\s)
  let str = substitute(str, '\v%(\n|\.)@<!\n%(%(•|-|\d+\.)\s+)@!', ' ', 'g')
  " listの直後の行を結合しない版
  " let str = substitute(str, '\v%(\n|\.|%(%(-|\d+\.)\s+[^\n]+))@<!\n%(%(-|\d+\.)\s+[^\n]+)@!', '', 'g')

  " insert \n after \.
  " keep
  "   paragraph end (.\n)
  "   num list (\d+\.\s)
  let str = substitute(str, '\v%(\n\d+)@<!\.\s+%(\n)@!', '.\n', 'g')

  return str
endfunction "}}}

" 動作確認用
" vnoremap <expr>gs_ printf('"%sy', g:working_register) . "<cmd>echo JoinText(getreg(g:working_register))<cr>"

" 動作確認用
" trans-
" late
" - hey
" - you
" • hoge
" • fuga
" 1. hey
" 99. you
" hoge(非対応)
"
" end. fuga
" fuga
" end.
"
" I
" am
