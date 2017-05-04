" #autocmds
augroup myac
  " au CursorMoved * call vimrc#auto_cursorcolumn()
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  au SwapExists * let g:swapname = v:swapname
  au CursorHold *.toml syntax sync minlines=300
  au VimResized * if &ft !=# 'help' | wincmd = | redraw! | endif
  au VimEnter,WinEnter,VimResized * let &scrolloff=float2nr(winheight('') * 0.1)

  au BufLeave * nested call DoAutoSave()
  au CursorHold * nested call DoAutoSave()
  if exists('##FocusLost')
    au FocusLost * nested call DoAutoSave()
  endif

  " #terminal {{{
  if has('nvim')
    au TermOpen * call s:term_open()
    function s:term_open()
      setl signcolumn=no
      setl foldcolumn=0
      au BufEnter <buffer> call feedkeys('a') " or startinsert!
      " call feedkeys("exec zsh\<cr>\<c-l>") " Rug
    endfunction

    " Skip return code when quit terminal.
    au TermClose * call s:term_close()
    function! s:term_close() abort
      if bufname('%') =~ printf('\v(%s|%s)$', $SHELL, &shell)
        call feedkeys('\<cr>')
      endif
    endfunction
  endif "}}}

  " Sync clipboard
  if '' !=# $DISPLAY
    let @" = @*
    if exists('##TextYankPost')
      au TextYankPost * let @*=@" | let @+=@"
    endif
  endif

  " #fcitx {{{
  if executable('fcitx-remote')
    au InsertLeave * FcitxOff
    if exists('##FocusGained')
      au FocusGained * FcitxOff
    endif
  endif "}}}

  " Auto save
  if exists('##FocusLost')
    au FocusLost * call DoAutoSave()
  endif

  " #badspace {{{
  " trailがあるとハイライトできない あたりまえか
  " au Syntax * call s:badspace() " ファイルタイプ決定前だと判定できない
  au FileType * call s:badspace()
  au InsertEnter * hi clear BadSpace
  au InsertLeave,VimEnter,ColorScheme * call s:badspace_set_highlight()

  function! s:badspace_set_highlight() abort
    hi BadSpace ctermfg=16 ctermbg=197  guifg=#000000 guibg=#ff0060
  endfunction

  function! s:badspace() abort
    if &buflisted == 1 && &buftype ==# '' && &modifiable && &ft !=# '' && &ft !~# '\v(markdown|github-dashboard|calendar|gitcommit)'
      " cannot use \%$ in ':syntax match'
      3match BadSpace '^\s*\%$'
      syn match BadSpace '\s\+$\|\%u180E\|\%u2000\|\%u2001\|\%u2002\|\%u2003\|\%u2004\|\%u2005\|\%u2006\|\%u2007\|\%u2008\|\%u2009\|\%u200A\|\%u2028\|\%u2029\|\%u202F\|\%u205F\|\%u3000' containedin=ALL
    endif
  endfunction
"}}}

  " nohlsearchする代わりに出力が常に消える
  " visual modeがバグる
  " au CursorMoved * call feedkeys(":silent nohlsearch\<cr>\<c-l>")

  " #tag
  " .tagsがある場合のみ更新する
  au BufWritePost * if filewritable('.tags') | call Tags() | endif
augroup END
