" after/ftplugin.vimの中じゃないとプラグインとかに上書きされる

" need to old vim(probably ~7.4.160).
 if !exists('#u10ac')
   augroup u10ac
   augroup END
 endif

au u10ac FileType * call RemoveOptVal('formatoptions', 'jro')
au u10ac FileType * setl formatoptions+=Bnq
" r 改行でコメントを挿入
" o	ノーマルモードで'o'、'O'を打った後に、現在のコメント指示を自動的に挿入する。
" B multi-byte charの結合で空白を挿入しない
" q gqでコメントを結合
" j コメントを結合する時に可能であればコメントリーダーを削除する

" elseやrescueに移動しない
au u10ac FileType vim  let b:match_words='\<fu\%[nction]\>:\<endf\%[unction]\>,\<\(wh\%[ile]\|for\)\>:\<end\(w\%[hile]\|fo\%[r]\)\>,\<if\>:\<en\%[dif]\>,\<try\>:\<endt\%[ry]\>,\<aug\%[roup]\s\+\%(END\>\)\@!\S:\<aug\%[roup]\s\+END\>,(:)'
au u10ac FileType sh   let b:match_words='\%(;\s*\|^\s*\)\@<=if\>:\%(;\s*\|^\s*\)\@<=fi\>,\%(;\s*\|^\s*\)\@<=\%(for\|while\)\>:\%(;\s*\|^\s*\)\@<=done\>,\%(;\s*\|^\s*\)\@<=case\>:\%(;\s*\|^\s*\)\@<=esac\>'
au u10ac FileType zsh  let b:match_words='(:),{:},[:],\<if\>:\<fi\>,\<case\>:^\s*([^)]*):\<esac\>,\<\%(select\|while\|until\|repeat\|for\%(each\)\=\)\>:\<done\>'
