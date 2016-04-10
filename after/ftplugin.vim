" after/ftplugin.vimの中じゃないとプラグインとかに上書きされる

au u10ac FileType toml setl commentstring=#\ %s
au u10ac FileType * setl formatoptions-=ro
au u10ac FileType * setl formatoptions+=Bn
" r When type <return> in insert-mode auto insert commentstring
" o	ノーマルモードで'o'、'O'を打った後に、現在のコメント指示を自動的に挿入する。
" B multi-byte charの結合で空白を挿入しない
" j コメントを結合する時に可能であればコメントリーダーを削除する

" elseやrescueに移動しない
au u10ac FileType vim  let b:match_words='\<fu\%[nction]\>:\<endf\%[unction]\>,\<\(wh\%[ile]\|for\)\>:\<end\(w\%[hile]\|fo\%[r]\)\>,\<if\>:\<en\%[dif]\>,\<try\>:\<endt\%[ry]\>,\<aug\%[roup]\s\+\%(END\>\)\@!\S:\<aug\%[roup]\s\+END\>,(:)'
au u10ac FileType sh   let b:match_words='\%(;\s*\|^\s*\)\@<=if\>:\%(;\s*\|^\s*\)\@<=fi\>,\%(;\s*\|^\s*\)\@<=\%(for\|while\)\>:\%(;\s*\|^\s*\)\@<=done\>,\%(;\s*\|^\s*\)\@<=case\>:\%(;\s*\|^\s*\)\@<=esac\>'
au u10ac FileType zsh  let b:match_words='(:),{:},[:],\<if\>:\<fi\>,\<case\>:^\s*([^)]*):\<esac\>,\<\%(select\|while\|until\|repeat\|for\%(each\)\=\)\>:\<done\>'
