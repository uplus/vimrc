call smartinput_endwise#define_default_rules()
call smartinput#map_to_trigger('i', '<Plug>(smartinput_cr)', '<Enter>', '<Enter>')
call smartinput#map_to_trigger('i', '<Bar>', '<Bar>', '<Bar>')

call smartinput#define_rule({
      \   'at'       : '\%(\<struct\>\|\<class\>\|\<enum\>\)\s*\w\+.*\%#',
      \   'char'     : '{',
      \   'input'    : '{};<Left><Left>',
      \   'filetype' : ['c','cpp'],
      \   })

call smartinput#define_rule({
      \   'at'       : '\\\%(\|%\|z\)\%#',
      \   'char'     : '(',
      \   'input'    : '(\)<Left><Left>',
      \   'filetype' : ['vim'],
      \   })

call smartinput#define_rule({
      \   'at'       : '\\(\%#\\)',
      \   'char'     : '<BS>',
      \   'input'    : '<Del><Del><BS><BS>',
      \   'filetype' : ['vim'],
      \   })

call smartinput#define_rule({
      \   'at'       : '\\[%z](\%#\\)',
      \   'char'     : '<BS>',
      \   'input'    : '<Del><Del><BS><BS><BS>',
      \   'filetype' : ['vim'],
      \   })

call smartinput#define_rule({
      \   'at': '\({\|\<do\>\)\s*\%#',
      \   'char': '<Bar>',
      \   'input': '<Bar><Bar><Left>',
      \   'filetype': ['ruby'],
      \ })

call smartinput#define_rule({
      \   'at': '\({\|\<do\>\)\s*|.*\%#|',
      \   'char': '<Bar>',
      \   'input': '<Right>',
      \   'filetype': ['ruby'],
      \ })

call smartinput#define_rule({
      \   'at': '\({\|\<do\>\)\s*|\%#|',
      \   'char': '<BS>',
      \   'input': '<Del><BS>',
      \   'filetype': ['ruby'],
      \ })
