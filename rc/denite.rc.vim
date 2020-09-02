" Config:

" Set Default Options:
call denite#custom#option('default', {
  \ 'start_filter': v:true,
  \ 'smartcase': v:true,
  \ 'prompt': '>',
  \ 'source_names': 'short',
  \ 'highlight_filter_background': 'CursorLine',
  \ 'split': 'floating',
  \ 'filter_split_direction': 'floating',
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

" Set Floating Window Size:
call s:set_denite_win(0.7, 0.8)
au myac VimEnter,VimResized * call s:set_denite_win(0.7, 0.8)

" Custom Actions:
call denite#custom#action('buffer,command,directory,file,openable,source,word', 'show_context', { context -> Debug(context) })
call denite#custom#action('file', 'qfreplace', { context -> s:action_qfreplace(context)})
" call denite#custom#action('file', 'test', { context -> execute('let g:foo = 1') })
" call denite#custom#action('file', 'test2', { context -> denite#do_action(context, 'open', context['targets']) })

function! s:action_qfreplace(context)
  call denite#do_action(a:context, 'quickfix', a:context['targets'])
  Qfreplace
  cclose
endfunction

" Filters:
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs', [ '.git/', '.ropeproject/', '__pycache__/', 'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])
call denite#custom#filter('matcher/clap', 'clap_path', expand('$CACHE/dein') . '/repos/github.com/liuchengxu/vim-clap')

" Matchers:
let s:default_matcher = 'matcher/regexp'
call denite#custom#source('_', 'matchers', [s:default_matcher])
call denite#custom#source('buffer', 'matchers', [s:default_matcher, 'matcher/ignore_current_buffer'])
call denite#custom#source('file/rec', 'matchers', [s:default_matcher, 'matcher/hide_hidden_files'])

" Sorters:
" 空にすればファイル順になるソースもある(lineと同じ)
call denite#custom#source('grep', 'sorters', [])
call denite#custom#source('file/rec', 'sorters', ['sorter/path'])

" Converters:
call denite#custom#source('file/old', 'converters', ['converter/relative_word'])

" Aliases:
" call denite#custom#alias('source', 'file/rec/git', 'file/rec')

" Vars:
" call denite#custom#var('file/rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])

if executable('rg') " ripgrep
  " https://github.com/BurntSushi/ripgrep
  call denite#custom#var('file/rec', 'command', ['rg', '--files', '--hidden', '--glob', '!.git', '--color', 'never'])
  call denite#custom#var('grep', {
        \ 'command': ['rg', '--threads', '1'],
        \ 'default_opts': ['--vimgrep', '--no-heading', '--smart-case'],
        \ 'recursive_opts': [],
        \ 'final_opts': [],
        \ 'separator': ['--'],
        \ 'max_path_length': 999,
        \ })
elseif executable('ag')
  " https://github.com/ggreer/the_silver_searcher
  call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif
