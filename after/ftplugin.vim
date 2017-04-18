" after/ftplugin.vimの中じゃないとプラグインとかに上書きされる

" " need to old vim(probably ~7.4.160).
" if !exists('#myac')
"   augroup myac
"   augroup END
" endif

function! s:filetype_all() abort
  call vimrc#remove_opt_val('formatoptions', 'jro')
  setl formatoptions+=Bnql
  " r 改行でコメントを挿入
  " o ノーマルモードで'o'、'O'を打った後に、現在のコメント指示を自動的に挿入する。
  " B multi-byte charの結合で空白を挿入しない
  " q gqでコメントを結合
  " j コメントを結合する時に可能であればコメントリーダーを削除する

  " echomsg 'filetype_all'
endfunction

augroup myac
  au FileType * call s:filetype_all()

  " elseやrescueに移動しない
  au FileType sh   let b:match_words='\%(;\s*\|^\s*\)\@<=if\>:\%(;\s*\|^\s*\)\@<=fi\>,\%(;\s*\|^\s*\)\@<=\%(for\|while\)\>:\%(;\s*\|^\s*\)\@<=done\>,\%(;\s*\|^\s*\)\@<=case\>:\%(;\s*\|^\s*\)\@<=esac\>'
  au FileType zsh  let b:match_words='(:),{:},[:],\<if\>:\<fi\>,\<case\>:^\s*([^)]*):\<esac\>,\<\%(select\|while\|until\|repeat\|for\%(each\)\=\)\>:\<done\>'
  au FileType neosnippet set noexpandtab
augroup END
