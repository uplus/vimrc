" オプション設定系

function! my#option#set_tab(num) abort
  let &l:tabstop=a:num " Tab表示幅
  let &l:softtabstop = &l:tabstop " Tab押下時のカーソル移動量
  let &l:shiftwidth = &l:tabstop " インデント幅

  call my#option#set_breakindentopt()
endfunction

function! my#option#set_breakindentopt() abort
  let l:shift = 0 == &l:tabstop ? 0 : &l:tabstop - 2

  " shift:{n} shift num
  " sbr       ^の位置ではなく0の位置に入れる
  let &l:breakindentopt = printf('shift:%d', l:shift)
endfunction

function! my#option#set_syntax() abort
  if luaeval("require'nvim-treesitter.parsers'.list[vim.bo.filetype] ~= nil") && -1 == index(['vim', 'dockerfile'], &filetype)
    return
  endif

  " (treesitterでサポートされてない or 明示した) filetypeならsyntaxを設定する
  let &l:syntax=&l:filetype
endfunction
