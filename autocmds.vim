" #autocmds
augroup myac
  " au CursorMoved * call my#option#auto_cursorcolumn()
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  au SwapExists * let g:swapname = v:swapname
  au CursorHold *.toml syntax sync minlines=300
  au VimResized * if &ft !=# 'help' | wincmd = | redraw! | endif
  au VimEnter,VimResized * let &scrolloff=float2nr(winheight('') * 0.07)
  " 最後のバッファがquickfixなら自動で閉じる
  au WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | quit | endif
  au BufRead,BufNewFile $ZSH_DOT_DIR/* lcd %:p:h

  " BufLeaveだとfloatingでも反応してしまうので外した
  au CursorHold * call DoAutoSave()
  if exists('##FocusLost')
    au FocusLost * call DoAutoSave()
  endif

  " フローティングウィンドウから離れたら自動で閉じる
  au BufEnter * if !vimrc#is_floating_win(0) | call vimrc#close_floating_win('denite') | endif

  " has('patch-8.0.1238')
  " au CmdLineEnter /,\? :set hlsearch
  " au CmdLineLeave /,\? :set nohlsearch

  " nohlsearchする代わりに出力が常に消える
  " visual modeがバグる
  " au CursorMoved * call feedkeys(":silent nohlsearch\<cr>\<c-l>")

  " Terminal: {{{
  if has('nvim')
    au TermOpen * call s:term_open()
    function s:term_open()
      setl signcolumn=no
      setl foldcolumn=0
      au BufEnter <buffer> call feedkeys('a') " or startinsert!
      " call feedkeys("exec zsh\<cr>\<c-l>") " Bug
    endfunction

    au TermClose * call s:term_close()
    function! s:term_close() abort
      " Skip return code when quit terminal.
      if bufname('%') =~ printf('\v(%s|%s|pry)$', $SHELL, &shell)
        " defxを開いているとバグる
        " call feedkeys('\<cr>')
      endif
    endfunction
  endif
  "}}}

  " Sync Clipboard: {{{
  if '' !=# $DISPLAY
    " 今は無くても大丈夫そう
    " let @" = @*
    if exists('##TextYankPost')
      " au TextYankPost * let @* = @" | let @+ = @"
    endif
  endif
  "}}}

  " Fcitx: {{{
  if executable('fcitx5-remote')
    " 最初の一度のみ先頭入れ替えバグは無関係だった
    au InsertLeave * FcitxOff

    if exists('##FocusGained')
      au FocusGained * FcitxOff
    endif
  endif
  "}}}

  " Todo Highlight: {{{
  au myac Syntax * call s:highlight_todo()

  function! s:highlight_todo() abort
    hi! Todo ctermfg=208 ctermbg=0 guifg=#ffb000 guibg=#000000 cterm=italic gui=italic
    if 0 != get(g:, 'todo_match_id')
      silent! call matchdelete(g:todo_match_id)
    end

  " matchaddを複数回呼び出すと激重になるので注意
    let g:todo_match_id = matchadd('Todo', '\v(TODO|NOTE|INFO|XXX|TEMP)\ze(:|\s)')
  endfunction
  "}}}

  " Badspace: {{{
  " trailがあるとハイライトできない あたりまえか
  " filetypeコマンドの後じゃないと反映されない
  let g:badspace_enable = 1
  au VimEnter * au Syntax * call s:badspace()
  au InsertEnter * hi clear BadSpace
  au InsertLeave,VimEnter,ColorScheme * call s:badspace_set_highlight()

  function! s:badspace_set_highlight() abort
    if g:badspace_enable
      hi! BadSpace cterm=NONE ctermfg=197 ctermbg=197 gui=NONE  guifg=#e00050 guibg=#e00050
    endif
  endfunction

  function! s:badspace() abort
    if &buflisted && &buftype ==# '' && &modifiable && &filetype !=# '' && !&diff && &filetype !~# '\v(markdown|calendar|gitcommit|diff|defx:.*)'
      syn match BadSpace display excludenl '\s\+$\|\%u180E\|\%u2000\|\%u2001\|\%u2002\|\%u2003\|\%u2004\|\%u2005\|\%u2006\|\%u2007\|\%u2008\|\%u2009\|\%u200A\|\%u2028\|\%u2029\|\%u202F\|\%u205F\|\%u3000' containedin=ALL
    endif
  endfunction
  "}}}

  " Tag: {{{
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
  "}}}

  " Auto Mkdir: {{{
  au BufWritePre * call s:auto_mkdir(expand('%:p:h'))

  function! s:auto_mkdir(dir)
    if bufname('%') !~# '\v^.*://' && !isdirectory(a:dir) && !vimrc#is_file(a:dir)
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
  "}}}

  " Auto Defx: {{{
  autocmd BufEnter,BufRead,BufNew,BufCreate * call s:browse_check(expand('<amatch>'))

  function! s:browse_check(path) abort
    if a:path ==# '' || bufnr('%') != expand('<abuf>')
      return
    endif

    " Disable netrw.
    augroup FileExplorer
      autocmd!
    augroup END

    if &filetype ==# 'defx' && line('$') != 1
      return
    endif

    " For ":edit ~".
    let l:path = fnamemodify(a:path, ':t') ==# '~' ? '~' : a:path

    if isdirectory(l:path)
      execute 'Defx' fnameescape(l:path)
    endif
  endfunction
  "}}}
augroup END
