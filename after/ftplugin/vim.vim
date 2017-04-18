
let b:match_words =
      \ '\<fu\%[nction]\>:\<endf\%[unction]\>,' .
      \ '\<\(wh\%[ile]\|for\)\>:\<end\(w\%[hile]\|fo\%[r]\)\>,' .
      \ '\<if\>:\<en\%[dif]\>,' .
      \ '\<try\>:\<endt\%[ry]\>,' .
      \ '\<aug\%[roup]\s\+\%(END\>\)\@!\S:\<aug\%[roup]\s\+END\>,' .
      \ '(:)'

let b:match_words='\%(;\s*\|^\s*\)\@<=if\>:\%(;\s*\|^\s*\)\@<=fi\>,\%(;\s*\|^\s*\)\@<=\%(for\|while\)\>:\%(;\s*\|^\s*\)\@<=done\>,\%(;\s*\|^\s*\)\@<=case\>:\%(;\s*\|^\s*\)\@<=esac\>'
