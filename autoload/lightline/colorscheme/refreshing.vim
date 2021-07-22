let s:blue    = ['#61AEEE', 141]
let s:green   = ['#28DA9E', 156]
let s:magenta = ['#D285FF', 214]
let s:yellow  = ['#FFEF4A', 136]
let s:red     = ['#FF375F', 124]

let s:black  = ['#202000', 0]
let s:gray   = ['#20202f', 234]
let s:base03 = ['#102b26', 234]
let s:base02 = ['#202632', 235]
let s:base01 = ['#586060', 239]
let s:base00 = ['#6a7073', 240]
let s:base0  = ['#8a9090', 244]
let s:base1  = ['#93a1a1', 245]
let s:base2  = ['#eee8d5', 187]
let s:base3  = ['#fdf6e3', 230]

let s:tab_active   = s:blue
let s:tab_inactive = ['#b8b8b8', 244]
let s:nocontent    = ['#0e0e0e', 0]
let s:text_bg      = ['#0e0e00', 0]

" base
let s:p = {
  \   'normal': {},
  \   'inactive': {},
  \   'insert': {},
  \   'replace': {},
  \   'visual': {},
  \   'tabline': {}
  \ }

" format
"   name = [[first_pos], [second_pos], [third_pos], ...]

" tab
let s:p.tabline.left   = [[s:text_bg, s:tab_inactive]]
let s:p.tabline.middle = [[s:text_bg, s:nocontent]]
let s:p.tabline.right  = [[s:text_bg, s:tab_active], [s:tab_active, s:tab_inactive]]
let s:p.tabline.tabsel = [[s:text_bg, s:tab_active]]

" middle
let s:p.normal.middle   = [[s:base1,  s:black]]
let s:p.inactive.middle = [[s:base01, s:nocontent]]

" inactive
let s:p.inactive.left  = [[s:text_bg, s:base0], [s:text_bg, s:base0], [s:base0, s:nocontent]]
let s:p.inactive.right = [[s:text_bg, s:base0], [s:base0,   s:nocontent]]

" each mode colors
let s:p.normal.left   = [[s:text_bg, s:blue],    [s:text_bg, s:blue],    [s:blue,    s:gray]]
let s:p.normal.right  = [[s:text_bg, s:blue],    [s:blue,    s:gray]]
let s:p.insert.left   = [[s:text_bg, s:green],   [s:text_bg, s:green],   [s:green,   s:gray]]
let s:p.insert.right  = [[s:text_bg, s:green],   [s:green,   s:gray]]
let s:p.replace.left  = [[s:text_bg, s:red],     [s:text_bg, s:red],     [s:red,     s:gray]]
let s:p.replace.right = [[s:text_bg, s:red],     [s:red,     s:gray]]
let s:p.visual.left   = [[s:text_bg, s:magenta], [s:text_bg, s:magenta], [s:magenta, s:gray]]
let s:p.visual.right  = [[s:text_bg, s:magenta], [s:magenta, s:gray]]

let s:p.normal.error   = [[s:black,   s:red]]
let s:p.normal.warning = [[s:text_bg, s:yellow]]
let s:p.normal.git     = [[s:red,     s:gray]]

let g:lightline#colorscheme#refreshing#palette = lightline#colorscheme#flatten(s:p)
