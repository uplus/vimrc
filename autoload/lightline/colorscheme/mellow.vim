" hi Normalと同じ
let s:nocontent = ['#0c0b09', 0]
let s:gray = ['#20202f', 234]
let s:black = ['#202020', 0]

let s:yellow  = ['#f5c900', 136]
let s:orange  = ['#ffb90f', 214]
let s:red     = ['#ff2040', 124]
let s:magenta = ['#d079ff', 141]
let s:violet  = ['#6c71c4', 61]
let s:blue    = ['#00c8ff', 141]
let s:cyan    = ['#2aa198', 37]
let s:green   = ['#75d435', 156]

let s:mode_n = s:blue
let s:mode_i = s:green
let s:mode_r = s:orange
let s:mode_v = s:magenta

let s:base03  = ['#002b36', 234]
let s:base02  = ['#073642', 235]
let s:base01  = ['#586e75', 239]
let s:base00  = ['#657b83', 240]
let s:base0   = ['#839496', 244]
let s:base1   = ['#93a1a1', 245]
let s:base2   = ['#cec8e5', 187]
let s:base3   = ['#fdf6e3', 230]

let s:tab_active = ['#20202f', 234]
let s:tab_inactive = ['#40404e', 240]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

" format
"   name = [[first_pos], [second_pos], [third_pos], ...]

" each mode colors
let s:p.normal.left     = [[s:base03, s:mode_n], [s:mode_n, s:gray]]
let s:p.normal.right    = [[s:base03, s:mode_n], [s:mode_n, s:gray]]
let s:p.insert.left     = [[s:base03, s:mode_i], [s:mode_i, s:gray]]
let s:p.insert.right    = [[s:base03, s:mode_i], [s:mode_i, s:gray]]
let s:p.replace.left    = [[s:base03, s:mode_r], [s:mode_r, s:gray]]
let s:p.replace.right   = [[s:base03, s:mode_r], [s:mode_r, s:gray]]
let s:p.visual.left     = [[s:base03, s:mode_v], [s:mode_v, s:gray]]
let s:p.visual.right    = [[s:base03, s:mode_v], [s:mode_v, s:gray]]

" middle
let s:p.normal.middle   = [[s:base2, s:black]]
let s:p.inactive.middle = [[s:base2, s:gray]]

" inactive
let s:p.inactive.left   = [[s:base2, s:gray], [s:base2,  s:gray]]
let s:p.inactive.right  = [[s:base2, s:gray], [s:base2,  s:gray]]

" tab
let s:p.tabline.tabsel  = [[s:base3, s:tab_active]]
let s:p.tabline.left    = [[s:base3, s:tab_inactive]]
let s:p.tabline.middle  = [[s:base3, s:nocontent]]
let s:p.tabline.right   = [[s:base3, s:nocontent]]

" expand
let s:p.normal.error    = [[s:black, s:red]]
let s:p.normal.warning  = [[s:base03, s:yellow]]
let s:p.normal.git      = [[s:red, s:gray]]

let g:lightline#colorscheme#mellow#palette = lightline#colorscheme#flatten(s:p)
