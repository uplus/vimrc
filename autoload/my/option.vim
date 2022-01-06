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
  if luaeval("require'nvim-treesitter.parsers'.list[vim.bo.filetype] ~= nil") && !vimrc#is_include(['vim', 'dockerfile', 'markdown'], &filetype)
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
  nnoremap <silent><buffer>q :quit<CR>
  setl buftype=nofile
  setl bufhidden=hide
  setl noswapfile
  setl nobuflisted
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

  let opts = { 'silent': v:true, 'noremap': v:true }
  call nvim_buf_set_keymap(a:bufnr, '', 'q', '<cmd>quit<cr>', opts)
  " 範囲選択対応のため <cmd>は使わない
  call nvim_buf_set_keymap(a:bufnr, '', 'gdp', ':diffput | diffupdate<cr>', opts)
  call nvim_buf_set_keymap(a:bufnr, '', 'gdg', ':diffget | diffupdate<cr>', opts)
endfunction "}}}
