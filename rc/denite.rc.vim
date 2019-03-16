" Denite:

nnoremap <space>u :Denite<space>

nnoremap <silent>\b :<c-u>Denite buffer<cr>
nnoremap <silent>\f :<c-u>Denite file/rec<cr>
nnoremap <silent>\F :<c-u>DeniteBufferDir file/rec<cr>
nnoremap <silent>\\f :<c-u>Denite file_mru<cr>
nnoremap <silent><space>r :<c-u>Denite -resume -mode=insert<cr>

nnoremap <silent>s/ :<c-u>Denite line:all<cr>
" nnoremap <silent>s? :<c-u>Denite -auto-resize -no-quit vg<cr>
nnoremap <silent>s* :<c-u>DeniteCursorWord line:forward:wrap<cr>
nnoremap <silent>s# :<c-u>DeniteCursorWord line:backward:wrap<cr>
nnoremap <silent>sg :<c-u>Denite grep<cr>
nnoremap <silent>g* :<c-u>DeniteCursorWord grep<cr>

nnoremap <silent>;r :<c-u>Denite register neoyank<cr>
xnoremap <silent>;r :<c-u>Denite register neoyank -default-action=replace<cr>

nnoremap <silent><space>m :<c-u>Denite -no-empty mark<cr>
nnoremap <silent>;uj :<c-u>Denite jump -auto-resize<cr>

nnoremap <silent>;: :<c-u>Denite command_history<cr>
nnoremap <silent>;uc :<c-u>Denite command<cr>
nnoremap <silent>;u <Nop>

" " search

" nnoremap <silent>st :Denite tag<cr>
" nmap     <silent>sn :<C-u>UniteResume search%`bufnr('%')` -no-force-redraw<cr><Plug>(unite_loop_cursor_down)
" nnoremap <silent>sh :Denite -auto-resize headline<cr>
" nnoremap <silent>so :Denite -auto-resize -resume -input= outline<cr>
" nnoremap <silent>sT :Todo<cr>

" nnoremap <silent>;gs :Denite -auto-resize -no-empty -no-quit -buffer-name=git/status giti/status<cr>
" nnoremap <silent>;q :Denite -auto-resize -no-empty -no-quit -direction=botright quickfix -buffer-name=quickfix<cr>

" nnoremap <silent> [Window]<Space> :<C-u>Denite file/rec:~/.vim/rc<cr>
" nnoremap <silent> / :<C-u>Denite -buffer-name=search -auto-highlight line<cr>
" nnoremap <silent> * :<C-u>DeniteCursorWord -buffer-name=search -auto-highlight -mode=normal line<cr>
" nnoremap <silent> [Window]s :<C-u>Denite file/point file/old -sorters=sorter/rank `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'` file file:new<cr>

" nnoremap <silent><expr> tt  &filetype == 'help' ?  "g\<C-]>" : ":\<C-u>DeniteCursorWord -buffer-name=tag -immediately tag:include\<cr>"
" nnoremap <silent><expr> tp  &filetype == 'help' ? ":\<C-u>pop\<cr>" : ":\<C-u>Denite -mode=normal jump\<cr>"
" nnoremap <silent> [Window]n :<C-u>Denite dein<cr>
" nnoremap <silent> [Window]g :<C-u>Denite ghq<cr>
" nnoremap <silent> ;g :<C-u>Denite -buffer-name=search -no-empty -mode=normal grep<cr>
" nnoremap <silent> n :<C-u>Denite -buffer-name=search -resume -mode=normal -refresh<cr>
" nnoremap <silent> ft :<C-u>Denite filetype<cr>
" nnoremap <silent> <C-t> :<C-u>Denite -select=`tabpagenr()-1` -mode=normal deol:zsh<cr>
" nnoremap <silent> <C-k> :<C-u>Denite -mode=normal change jump<cr>

" nnoremap <silent> [Space]gs :<C-u>Denite gitstatus<cr>
" nnoremap <silent> ;; :<C-u>Denite command command_history<cr>

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

call denite#custom#source('tag', 'matchers', ['matcher/substring'])
" call denite#custom#source('file', 'matchers', ['matcher/fruzzy'])
" call denite#custom#source('file/rec', 'matchers', ['matcher/fruzzy'])
" call denite#custom#source('file/rec', 'matchers', ['matcher/substring'])
" call denite#custom#source('file', 'matchers', ['matcher/regexp'])
" call denite#custom#source('file/rec', 'matchers', ['matcher/regexp'])
call denite#custom#source('file/rec', 'matchers', ['matcher/regexp', 'matcher/hide_hidden_files'])
" call denite#custom#source('file/old', 'matchers', ['matcher/fruzzy', 'matcher/project_files'])
call denite#custom#source('file/old', 'converters', ['converter/relative_word'])
" call denite#custom#source('buffer', 'matchers', ['matcher/fuzzy', 'matcher/ignore_current_buffer'])

" call denite#custom#alias('source', 'file/rec/git', 'file/rec')
" call denite#custom#var('file/rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])

call denite#custom#option('default', {
      \ 'auto_accel': v:true,
      \ 'prompt': '>',
      \ 'source_names': 'short',
      \ })

let s:menus = {}
let s:menus.vim = { 'description': 'Vim', }
let s:menus.vim.file_candidates = [
    \ ['    > Edit configuration file (init.vim)', '~/.config/nvim/init.vim']
    \ ]
call denite#custom#var('menu', 'menus', s:menus)

call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/', 'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

" call denite#custom#action('file', 'test', { context -> execute('let g:foo = 1') })
" call denite#custom#action('file', 'test2', { context -> denite#do_action(context, 'open', context['targets']) })

" call denite#custom#map('insert', ';', 'vimrc#sticky_func()', 'expr')
" call denite#custom#map('insert', '<c-w>', '<denite:move_up_path>', 'noremap')
call denite#custom#map('insert', '<bs>',  '<denite:smart_delete_char_before_caret>', 'noremap')
call denite#custom#map('insert', '<c-h>', '<denite:smart_delete_char_before_caret>', 'noremap')
call denite#custom#map('insert', '<c-a>', '<denite:move_caret_to_head>', 'noremap')

call denite#custom#map('insert', '<c-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('normal', '<c-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<c-p>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('normal', '<c-p>', '<denite:move_to_previous_line>', 'noremap')

call denite#custom#map('insert', '<esc>', '<denite:leave_mode>', 'noremap')
call denite#custom#map('normal', '<esc>', '<denite:leave_mode>', 'noremap')
call denite#custom#map('insert', '<c-j>', '<denite:do_action:default>', 'noremap')

" Action mappings
call denite#custom#map('normal', 't', '<denite:do_action:tabopen>', 'noremap')
call denite#custom#map('normal', 's', '<denite:do_action:split>', 'noremap')
call denite#custom#map('normal', 'v', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('normal', 'r', '<denite:do_action:qfreplace>', 'noremap')
call denite#custom#map('normal', 'R', '<denite:multiple_mappings:denite:toggle_select_all,denite:do_action:qfreplace>', 'noremap')

" Custom action
call denite#custom#action('buffer,command,directory,file,openable,source,word', 'show_context', { context -> Debug(context) })
call denite#custom#action('file', 'qfreplace', { context ->  s:action_qfreplace(context)})

function! s:action_qfreplace(context)
  call denite#do_action(a:context, 'quickfix', a:context['targets'])
  Qfreplace
  cclose
endfunction
