" vim: foldlevel=0

augroup myac
  " au CursorMoved * call my#option#auto_cursorcolumn()
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  au SwapExists * let g:swapname = v:swapname
  " au CursorHold *.toml syntax sync minlines=300
  au VimResized * if &ft !=# 'help' | wincmd = | redraw! | endif
  au VimEnter,VimResized * let &scrolloff = float2nr(&lines * 0.07)
  au VimEnter,VimResized * let &previewheight = float2nr(&lines * 0.40)
  " .tagsがある場合のみ更新する
  " au BufWritePost * if filewritable('.tags') | call Tags() | endif
  " 最後のバッファがquickfixなら自動で閉じる
  au WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | quit | endif
  au BufRead,BufNewFile $ZSH_DOT_DIR/* lcd $ZSH_DOT_DIR/
  " git commit -vのファイルを開いたとき先頭に移動する
  au BufReadPost COMMIT_EDITMSG goto

  au FileType conf,gitcommit,html,css set nocindent
  au FileType quickrun,help,diff setl signcolumn=no
  au FileType qf,help,vimconsole,narrow,diff,lspinfo,ref-* nnoremap <silent><buffer>q <cmd>quit<cr>
  au OptionSet previewwindow if v:option_new | nnoremap <silent><buffer>q <cmd>quit<cr> | endif

  " BufLeaveだとfloatingでも反応してしまうので外した
  " au CursorHold,FocusLost * call DoAutoSave()
  au CursorHold * call DoAutoSave()

  " フローティングウィンドウから離れたら自動で閉じる
  au BufEnter * if !vimrc#is_floating_win(0) | call vimrc#close_floating_win('denite') | endif

  " ヤンクしたテキストをハイライトする
  au TextYankPost * silent! lua vim.highlight.on_yank {higroup="Search", timeout=150, on_visual=true}

  " has('patch-8.0.1238')
  " au CmdLineEnter /,\? :set hlsearch
  " au CmdLineLeave /,\? :set nohlsearch
  " nohlsearchする代わりに出力が常に消える
  " visual modeがバグる
  " au CursorMoved * call feedkeys(":silent nohlsearch\<cr>\<c-l>")

  " Diff Mode: {{{
  " diffモード用の設定を適用する

  " diffモードで起動したバッファーに適用
  au VimEnter * call my#option#set_diff_mode_on_vimenter()

  " optionがセットされたときに適用
  au OptionSet diff if v:option_new | call my#option#set_diff_mode(0, 0) |  endif
  "}}}

  " Foldmethod: {{{
  au BufEnter * call s:set_foldmethod()

  function! s:set_foldmethod() abort
    " diffモードなら何もしない || modelineで設定されたならなにもしない
    if &diff || u#capture('verbose setl foldmethod?') =~# 'modeline'
      return
    endif

    " window単位なのでbuf毎の設定などはできない
    if u#is_include(['vim', 'markdown', 'sshconfig', 'neosnippet', 'zsh'], &filetype)
      set foldmethod=marker
    elseif u#is_include(['diff'], &filetype)
      set foldmethod=diff
    else
      " dein#is_sourced('nvim-treesitter') だと noplugin で落ちる
      setl foldmethod=expr
      setl foldexpr=nvim_treesitter#foldexpr()
    endif
  endfunction
  "}}}

  " Terminal: {{{
  if has('nvim')
    au TermOpen * ++nested call s:term_open()
    au TermClose * call s:term_close()

    function! s:term_buf_enter() abort

      " 挿入モードになる前にfeedkeysのキューを空にする
      " 一部のプラグインが実行するfeedkeysがターミナルに入力されるのを防ぐ
      call feedkeys('', 'x')

      startinsert
      " au BufEnter <buffer> normal! a
      " au BufEnter <buffer> call feedkeys('a')
      " call feedkeys("exec zsh\<cr>\<c-l>") " Bug
    endfunction

    function s:term_open()
      " 初回
      call s:term_buf_enter()

      " 2回目以降
      au BufEnter <buffer> call s:term_buf_enter()
    endfunction

    function! s:term_close() abort
      if u#is_include(['quickrun-output'], &filetype)
        return
      endif

      if v:event.status == 0
        execute 'silent bdelete! ' . expand('<abuf>')
      endif
    endfunction
  endif
  "}}}

  " Sync Clipboard: {{{
  if '' !=# $DISPLAY
    " 今は無くても大丈夫そう
    " let @" = @*
    " au TextYankPost * let @* = @" | let @+ = @"
  endif
  "}}}

  " Fcitx: {{{
  if executable('fcitx5-remote')
    " 最初の一度のみ先頭入れ替えバグは無関係だった
    au InsertLeave,FocusGained  * FcitxOff
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
      hi! BadSpace cterm=NONE ctermfg=197 ctermbg=197 gui=NONE  guifg=#c02070 guibg=#c02070
    endif
  endfunction

  function! s:badspace() abort
    if &buflisted && u#is_writable_buf() && !u#is_include(['', 'markdown', 'calendar', 'gitcommit', 'diff', 'defx'], &filetype)
      syn match BadSpace display excludenl '\s\+$\|\%u180E\|\%u2000\|\%u2001\|\%u2002\|\%u2003\|\%u2004\|\%u2005\|\%u2006\|\%u2007\|\%u2008\|\%u2009\|\%u200A\|\%u2028\|\%u2029\|\%u202F\|\%u205F\|\%u3000' containedin=ALL
    endif
  endfunction
  "}}}

  " Local Config: {{{
  " Load each location config.
  au BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))

  function! s:vimrc_local(loc)
    let l:files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
    for l:file in reverse(filter(l:files, 'filereadable(v:val)'))
      echo 'detected local config:' l:file
      echo 'Please rename to .nvimrc or .exrc'
      source `=file`
    endfor
  endfunction
  "}}}

  " Auto Mkdir: {{{
  au BufWritePre * call s:auto_mkdir(expand('%:p:h'))

  function! s:auto_mkdir(dir)
    " ++pで似たようなことができるようになった
    " https://github.com/neovim/neovim/commit/d337814906b1377e34aa2c2dfd8aa16285328692
    if bufname('%') !~# '\v^.*://' && !isdirectory(a:dir) && !u#is_file(a:dir)
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
  "}}}

  " Startup: {{{
  au VimEnter * call s:vimenter()
  au StdinReadPost * call s:stdin_config()

  function! s:vimenter()
    if argc() == 0
      setl buftype=nowrite
    elseif argc() == 1 && !exists('g:swapname')
      " many side effect.
      " e.g invalid behavior smart_quit() of vimfiler.
      " e.g swap, grep
      " lcd %:p:h
    endif
  endfunction

  function! s:stdin_config()
    call my#option#set_minimal_window()
    call my#option#set_as_scratch()
    setl number

    goto
    silent! %foldopen!
  endfunction
  "}}}

  " Auto Defx: {{{
  autocmd BufEnter,BufRead,BufNew,BufAdd * call s:browse_check(expand('<amatch>'))

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

  " CmdWin: {{{
  au myac CmdwinEnter * call s:cmdwin_config()
  function! s:cmdwin_config()
    nnoremap <silent><buffer>q <cmd>quit<cr>
    set foldcolumn=0 signcolumn=no nonumber
  endfunction
  " }}}
augroup END
