" Config:
let s:denite_win_width_percent = 0.8
let s:denite_win_width = &columns * s:denite_win_width_percent
let s:denite_win_col_pos = (&columns - s:denite_win_width) / 2
let s:denite_win_height_percent = 0.6
let s:denite_win_height = &lines * s:denite_win_height_percent
let s:denite_win_row_pos = (&lines - s:denite_win_height) / 2

call denite#custom#option('default', {
  \ 'start_filter': v:true,
  \ 'smartcase': v:true,
  \ 'prompt': '>',
  \ 'source_names': 'short',
  \ 'highlight_filter_background': 'CursorLine',
  \ 'split': 'floating',
  \ 'winwidth': float2nr(s:denite_win_width),
  \ 'wincol': float2nr(s:denite_win_col_pos),
  \ 'winheight': float2nr(s:denite_win_height),
  \ 'winrow': float2nr(s:denite_win_row_pos),
  \ })

  "\ 'direction': 'aboveleft',
  "\ 'highlight_window_background'


" CustomActions:
call denite#custom#action('buffer,command,directory,file,openable,source,word', 'show_context', { context -> Debug(context) })
call denite#custom#action('file', 'qfreplace', { context ->  s:action_qfreplace(context)})
" call denite#custom#action('file', 'test', { context -> execute('let g:foo = 1') })
" call denite#custom#action('file', 'test2', { context -> denite#do_action(context, 'open', context['targets']) })

function! s:action_qfreplace(context)
  call denite#do_action(a:context, 'quickfix', a:context['targets'])
  Qfreplace
  cclose
endfunction

" call denite#custom#source('grep', 'args', ['', '', '!'])
call denite#custom#source('grep', 'sorters', ['sorter/word'])
call denite#custom#source('tag', 'matchers', ['matcher/substring'])
call denite#custom#source('output', 'matchers', ['matcher/substring'])
" call denite#custom#source('file', 'matchers', ['matcher/fruzzy'])
" call denite#custom#source('file/rec', 'matchers', ['matcher/fruzzy'])
" call denite#custom#source('file/rec', 'matchers', ['matcher/substring'])
" call denite#custom#source('file', 'matchers', ['matcher/regexp'])
" call denite#custom#source('file/rec', 'matchers', ['matcher/regexp'])
" call denite#custom#source('file/rec', 'matchers', ['matcher/regexp', 'matcher/hide_hidden_files'])
call denite#custom#source('file/rec', 'matchers', ['matcher/substring', 'matcher/hide_hidden_files'])
call denite#custom#source('file/rec', 'sorters', ['sorter/word'])
" call denite#custom#source('file/old', 'matchers', ['matcher/fruzzy', 'matcher/project_files'])
call denite#custom#source('file/old', 'converters', ['converter/relative_word'])
" call denite#custom#source('buffer', 'matchers', ['matcher/fuzzy', 'matcher/ignore_current_buffer'])

" call denite#custom#alias('source', 'file/rec/git', 'file/rec')
" call denite#custom#var('file/rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs', [ '.git/', '.ropeproject/', '__pycache__/', 'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

if executable('rg') " ripgrep
  " https://github.com/BurntSushi/ripgrep
  call denite#custom#var('file/rec', 'command', ['rg', '--files', '--hidden', '--glob', '!.git'])

  call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
  call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading', '--smart-case'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
elseif executable('ag')
  " https://github.com/ggreer/the_silver_searcher
  call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif
