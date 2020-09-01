" Config:

call denite#custom#option('default', {
  \ 'start_filter': v:true,
  \ 'smartcase': v:true,
  \ 'prompt': '>',
  \ 'source_names': 'short',
  \ 'highlight_filter_background': 'CursorLine',
  \ 'split': 'floating',
  \ })
  "\ 'direction': 'aboveleft',
  "\ 'highlight_window_background'

function! s:set_denite_win(height_percent, width_percent) abort
  let denite_win_width = &columns * a:width_percent
  let denite_win_col_pos = (&columns - denite_win_width) / 2
  let denite_win_height = &lines * a:height_percent
  let denite_win_row_pos = (&lines - denite_win_height) / 2

  call denite#custom#option('default', 'winwidth',  float2nr(denite_win_width))
  call denite#custom#option('default', 'wincol',    float2nr(denite_win_col_pos))
  call denite#custom#option('default', 'winheight', float2nr(denite_win_height))
  call denite#custom#option('default', 'winrow',    float2nr(denite_win_row_pos))
endfunction

call s:set_denite_win(0.7, 0.8)
au myac VimEnter,VimResized * call s:set_denite_win(0.7, 0.8)

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
  call denite#custom#var('file/rec', 'command', ['rg', '--files', '--hidden', '--glob', '!.git', '--color', 'never'])

  call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
  call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading', '--smart-case'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'max_path_length', 999)

elseif executable('ag')
  " https://github.com/ggreer/the_silver_searcher
  call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif
