" オプション設定系
" vim: foldlevel=0

function! my#option#set_tab(num) abort "{{{
  let &l:tabstop     = a:num " Tab表示幅
  let &l:softtabstop = a:num " Tab押下時のカーソル移動量
  let &l:shiftwidth  = a:num " インデント幅

  call my#option#set_breakindentopt()
endfunction "}}}

function! my#option#set_breakindentopt() abort "{{{
  let l:shift = 0 == &l:tabstop ? 0 : &l:tabstop - 2

  " shift:{n} shift num
  " sbr       ^の位置ではなく0の位置に入れる
  let &l:breakindentopt = printf('shift:%d', l:shift)
endfunction "}}}

function! my#option#set_syntax() abort "{{{
  " treesitterでハイライトがサポートされているならsyntaxを設定せずに終了
  if luaeval("require'nvim-treesitter.configs'.is_enabled('highlight', vim.bo.filetype)") " && !vimrc#is_include([], &filetype)
    return
  endif

  if &l:syntax ==# 'OFF'
    return
  endif

  " (treesitterでサポートされてない or 明示した) filetypeならsyntaxを設定する
  let &l:syntax=&l:filetype
endfunction "}}}

function! my#option#auto_cursorcolumn() abort "{{{
  if &buftype !=# '' || &filetype ==# 'markdown'
    setlocal nocursorcolumn
    return
  endif

  if virtcol('.')-1 <= indent('.') && 1 < virtcol('.')
    setlocal cursorcolumn
  else
    setlocal nocursorcolumn
  endif
endfunction "}}}

function! my#option#set_as_scratch() abort "{{{
  nnoremap <silent><buffer>q <cmd>quit<cr>
  setl buftype=nofile
  setl bufhidden=wipe
  setl nobuflisted
  setl noswapfile

  let alt_buf = bufnr('#')
  if -1 != alt_buf
    let &l:filetype = nvim_buf_get_option(alt_buf, 'filetype')
  endif
endfunction "}}}

function! my#option#set_diff_mode_on_vimenter() abort "{{{
  let diff_win_nrs = filter(nvim_list_wins(), { idx,win_nr -> nvim_win_get_option(win_nr, 'diff') })

  for win_nr in diff_win_nrs
    call my#option#set_diff_mode(win_nr, nvim_win_get_buf(win_nr))
  endfor
endfunction "}}}

" diffモード用の設定
function! my#option#set_diff_mode(win_nr, bufnr) abort "{{{
  call nvim_win_set_option(a:win_nr, 'signcolumn', 'no')

  let opts = { 'silent': v:true, 'noremap': v:true, 'nowait': v:true }
  call nvim_buf_set_keymap(a:bufnr, '', 'q', '<cmd>call my#option#close_current_tab_diff_wins()<cr>', opts)
  " 範囲選択対応のため <cmd>は使わない
  call nvim_buf_set_keymap(a:bufnr, '', 'do', ':diffget | diffupdate<cr>', opts)
  call nvim_buf_set_keymap(a:bufnr, '', 'dp', ':diffput | diffupdate<cr>', opts)
  " do dpで良さそう? なので廃止予定
  call nvim_buf_set_keymap(a:bufnr, '', 'gdg', ':diffget | diffupdate<cr>', opts)
  call nvim_buf_set_keymap(a:bufnr, '', 'gdp', ':diffput | diffupdate<cr>', opts)
endfunction "}}}

function! my#option#close_current_tab_diff_wins() abort " {{{
  windo if &diff == v:true | wincmd q | endif
  " echo nvim_tabpage_list_wins(tabpagenr())->filter({_,v -> nvim_win_get_option(v, 'diff') == v:true })
endfunction " }}}
