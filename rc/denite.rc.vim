" Config:
let s:denite_win_width_percent = 0.8
let s:denite_win_width = &columns * s:denite_win_width_percent
let s:denite_win_col_pos = (&columns - s:denite_win_width) / 2
let s:denite_win_height_percent = 0.6
let s:denite_win_height = &lines * s:denite_win_height_percent
let s:denite_win_row_pos = (&lines - s:denite_win_height) / 2

call denite#custom#option('default', {
  \ 'start_filter': v:true,
  \ 'direction': 'dynamictop',
  \ 'prompt': '>',
  \ 'source_names': 'short',
  \ 'split': 'floating',
  \ 'highlight_filter_background': 'CursorLine',
  \ 'winwidth': float2nr(s:denite_win_width),
  \ 'wincol': float2nr(s:denite_win_col_pos),
  \ 'winheight': float2nr(s:denite_win_height),
  \ 'winrow': float2nr(s:denite_win_row_pos),
  \ })

" Mappings:
nnoremap <space>d :Denite<space>
nnoremap [d :Denite -resume -cursor-pos=-1 -immediately<cr>
nnoremap ]d :Denite -resume -cursor-pos=+1 -immediately<cr>

nnoremap <silent>\b :<c-u>Denite buffer<cr>
nnoremap <silent>\f :<c-u>Denite file/rec<cr>
nnoremap <silent>\F :<c-u>DeniteBufferDir file/rec<cr>
nnoremap <silent>\\f :<c-u>Denite file_mru<cr>
nnoremap <silent><space>r :<c-u>Denite -resume -refresh<cr>

nnoremap <silent>s/ :<c-u>Denite line:all<cr>
" nnoremap <silent>s? :<c-u>Denite -auto-resize -no-quit vg<cr>
nnoremap <silent>s* :<c-u>DeniteCursorWord line:forward:wrap<cr>
nnoremap <silent>s# :<c-u>DeniteCursorWord line:backward:wrap<cr>
nnoremap <silent>g* :<c-u>DeniteCursorWord grep<cr>
nnoremap <silent>sg :<c-u>Denite grep<cr>
nnoremap <silent>st :<c-u>Denite tag<cr>
nnoremap <silent>so :<c-u>Denite -auto-resize outline<cr>
nnoremap <silent>sm :<c-u>Denite -no-empty mark<cr>
nnoremap <silent>;r :<c-u>Denite register neoyank<cr>
nnoremap <silent>;uj :<c-u>Denite jump -auto-resize<cr>
nnoremap <silent>;: :<c-u>Denite command_history<cr>
nnoremap <silent>;uc :<c-u>Denite command<cr>
nnoremap <silent>;ut :<c-u>Denite tag<cr>
nnoremap <silent>;un :<c-u>Denite file/rec -path=`system('note --dir')`<cr>
nnoremap <silent>;u <Nop>

command! -nargs=* Maps execute 'Denite output:map\|map!\|tmap -input=' . <q-args> 
command! -nargs=+ Out execute 'Denite output:' . escape(<q-args>, ' ')

" command! Todo     Denite -auto-resize -ignorecase -buffer-name=todo grep:%::(todo|fix|xxx)\:
" nnoremap <silent> [Window]<Space> :<C-u>Denite file/rec:~/.vim/rc<cr>
" nnoremap <silent> [Window]s :<C-u>Denite file/point file/old -sorters=sorter/rank `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'` file file:new<cr>
" nnoremap <silent> <C-t> :<C-u>Denite -select=`tabpagenr()-1` -mode=normal deol:zsh<cr>

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
  call denite#custom#var('grep', 'command', ['rg', '--threads', '1', '--smart-case'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
elseif executable('ag')
  " https://github.com/ggreer/the_silver_searcher
  call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif
