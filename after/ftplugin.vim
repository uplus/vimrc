" after/ftplugin.vimの中じゃないとプラグインとかに上書きされる

au uAutoCmd FileType * setl formatoptions-=ro
au uAutoCmd FileType * setl formatoptions+=Bjn
" r When type <return> in insert-mode auto insert commentstring
" o	ノーマルモードで'o'、'O'を打った後に、現在のコメント指示を自動的に挿入する。
" B multi-byte charの結合で空白を挿入しない
" j コメントを結合する時に可能であればコメントリーダーを削除する

" ft=textのときjplusで結合するとテキストが消える
au uAutoCmd FileType text setl formatoptions-=j
