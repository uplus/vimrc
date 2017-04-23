let s:base_b = ['#bf60ff', 141]
let s:base_g = ['#60ff3f', 156]
let s:base_r = ['#ffb90f', 214]

let s:gray = ['#20202f', 234]
let s:black = ['#000000', 0]

let s:yellow  = ['#f5c900', 136]
let s:orange  = s:base_r " ['#db4b16', 166]
let s:red     = ['#ff0030', 124]
let s:magenta = s:base_b " ['#d33682', 125]
let s:violet  = ['#6c71c4', 61]
let s:blue    = ['#268bd2', 33]
let s:cyan    = ['#2aa198', 37]
let s:green   = s:base_g " ['#85a901', 64]

let s:base03  = ['#002b36', 234]
let s:base02  = ['#073642', 235]
let s:base01  = ['#586e75', 239]
let s:base00  = ['#657b83', 240]
let s:base0   = ['#839496', 244]
let s:base1   = ['#93a1a1', 245]
let s:base2   = ['#eee8d5', 187]
let s:base3   = ['#fdf6e3', 230]


let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
" name = [[first_pos], [second_pos], [third_pos], ...]
let s:p.normal.left     = [[s:base03, s:magenta], [s:magenta, s:gray]]
let s:p.normal.right    = [[s:base03, s:magenta], [s:magenta, s:gray]]
let s:p.insert.left     = [[s:base03, s:green], [s:green, s:gray]]
let s:p.insert.right    = [[s:base03, s:green], [s:green, s:gray]]
let s:p.replace.left    = [[s:base03, s:red],    [s:red, s:gray]]
let s:p.replace.right   = [[s:base03, s:red],    [s:red, s:gray]]
let s:p.visual.left     = [[s:base03, s:orange], [s:orange, s:gray]]
let s:p.visual.right    = [[s:base03, s:orange], [s:orange, s:gray]]
" terminal
" command

let s:p.inactive.right  = [[s:base03, s:base00], [s:base0,  s:base02]]
let s:p.inactive.left   = [[s:base2,  s:base02], [s:base0,  s:base02]]
let s:p.normal.middle   = [[s:base1,  s:black]]
let s:p.inactive.middle = [[s:base01, s:base02]]

let s:p.tabline.left    = [[s:base03, s:base00]]
let s:p.tabline.tabsel  = [[s:base03, s:base1]]
let s:p.tabline.middle  = [[s:base0,  s:base02]]
let s:p.tabline.right   = copy(s:p.normal.right)

let s:p.normal.error    = [[s:base03, s:red]]
let s:p.normal.warning  = [[s:base03, s:yellow]]
let s:p.normal.git      = [[s:red, s:gray]]

let g:lightline#colorscheme#mellow#palette = lightline#colorscheme#flatten(s:p)

" #94d11f
" #09d3bf
" #00b7e0
" #39424d
" #656e78
