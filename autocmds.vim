" #autocmds
augroup myac
  " au CursorMoved * call vimrc#auto_cursorcolumn()
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  au SwapExists * let g:swapname = v:swapname
  au CursorHold *.toml syntax sync minlines=300
  au VimResized * if &ft !=# 'help' | wincmd = | redraw! | endif
  au VimEnter,WinEnter,VimResized * let &scrolloff=float2nr(winheight('') * 0.1)
  " 最後のバッファがquickfixなら自動で閉じる
  au WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | quit | endif
  au BufRead,BufNewFile $ZSH_DOT_DIR/* lcd %:h

  au BufLeave * call DoAutoSave()
  au CursorHold * call DoAutoSave()
  if exists('##FocusLost')
    au FocusLost * call DoAutoSave()
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
      if bufname('%') =~ printf('\v(%s|%s|pry)$', $SHELL, &shell)
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

  " #badspace {{{
  " trailがあるとハイライトできない あたりまえか
  " filetypeコマンドの後じゃないと反映されない
  let g:badspace_enable = 1
  au VimEnter * au myac Syntax * call s:badspace()
  au InsertEnter * hi clear BadSpace
  au BufEnter vimfiler:* hi clear BadSpace
  au InsertLeave,VimEnter,ColorScheme * call s:badspace_set_highlight()

  function! s:badspace_set_highlight() abort
    if g:badspace_enable
      hi BadSpace ctermfg=197 ctermbg=197  guifg=#e00050 guibg=#e00050
    endif
  endfunction

  function! s:badspace() abort
    if &buflisted && &buftype ==# '' && &modifiable && &filetype !=# '' && &filetype !~# '\v(markdown|github-dashboard|calendar|gitcommit)'
      syn match BadSpace display excludenl '\s\+$\|\%u180E\|\%u2000\|\%u2001\|\%u2002\|\%u2003\|\%u2004\|\%u2005\|\%u2006\|\%u2007\|\%u2008\|\%u2009\|\%u200A\|\%u2028\|\%u2029\|\%u202F\|\%u205F\|\%u3000' containedin=ALL
    endif
  endfunction
"}}}

  " nohlsearchする代わりに出力が常に消える
  " visual modeがバグる
  " au CursorMoved * call feedkeys(":silent nohlsearch\<cr>\<c-l>")

  " #tag
  " .tagsがある場合のみ更新する
  au BufWritePost * if filewritable('.tags') | call Tags() | endif

  " Load settings for each location.
  au BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
  function! s:vimrc_local(loc)
    let l:files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
    for l:i in reverse(filter(l:files, 'filereadable(v:val)'))
      source `=i`
    endfor
  endfunction

  " has('patch-8.0.1238')
  " au CmdLineEnter /,\? :set hlsearch
  " au CmdLineLeave /,\? :set nohlsearch

  au BufWritePre * call s:auto_mkdir(expand('%:p:h'))
  function! s:auto_mkdir(dir)
    if !isdirectory(a:dir) && !IsFile(a:dir)
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END
