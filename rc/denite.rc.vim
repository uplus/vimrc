" Denite:

nnoremap <space>u :Denite<space>

nnoremap <silent>\b :<c-u>Denite -auto-resize -buffer-name=buffer buffer<cr>
nnoremap <silent>\f :<c-u>Denite file<cr>
nnoremap <silent>\F :<c-u>DeniteBufferDir file<cr>
nnoremap <silent>\\f :<c-u>Denite file file_mru<cr>
" nnoremap <silent><space>r :<c-u>UniteResume -no-start-insert -force-redraw<cr>

" nnoremap [denite] <Nop>
" nmap <C-c> [denite]

" nnoremap <silent> ;r :<C-u>Denite -buffer-name=register register neoyank<CR>
" xnoremap <silent> ;r :<C-u>Denite -default-action=replace -buffer-name=register register neoyank<CR>
" nnoremap <silent> [Window]<Space> :<C-u>Denite file/rec:~/.vim/rc<CR>
" nnoremap <silent> / :<C-u>Denite -buffer-name=search -auto-highlight line<CR>
" nnoremap <silent> * :<C-u>DeniteCursorWord -buffer-name=search -auto-highlight -mode=normal line<CR>
" nnoremap <silent> [Window]s :<C-u>Denite file/point file/old -sorters=sorter/rank `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'` file file:new<CR>

" nnoremap <silent><expr> tt  &filetype == 'help' ?  "g\<C-]>" : ":\<C-u>DeniteCursorWord -buffer-name=tag -immediately tag:include\<CR>"
" nnoremap <silent><expr> tp  &filetype == 'help' ? ":\<C-u>pop\<CR>" : ":\<C-u>Denite -mode=normal jump\<CR>"
" nnoremap <silent> [Window]n :<C-u>Denite dein<CR>
" nnoremap <silent> [Window]g :<C-u>Denite ghq<CR>
" nnoremap <silent> ;g :<C-u>Denite -buffer-name=search -no-empty -mode=normal grep<CR>
" nnoremap <silent> n :<C-u>Denite -buffer-name=search -resume -mode=normal -refresh<CR>
" nnoremap <silent> ft :<C-u>Denite filetype<CR>
" nnoremap <silent> <C-t> :<C-u>Denite -select=`tabpagenr()-1` -mode=normal deol:zsh<CR>
" nnoremap <silent> <C-k> :<C-u>Denite -mode=normal change jump<CR>

" nnoremap <silent> [Space]gs :<C-u>Denite gitstatus<CR>
" nnoremap <silent> ;; :<C-u>Denite command command_history<CR>

if executable('rg') " ripgrep
  " https://github.com/BurntSushi/ripgrep
  call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])
  call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
elseif executable('ag')
  " https://github.com/ggreer/the_silver_searcher
  call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif

call denite#custom#source('file/old', 'matchers', ['matcher/project_files'])
call denite#custom#source('file/old', 'converters', ['converter/relative_word'])
" call denite#custom#source('file/rec', 'matchers', ['matcher/fruzzy'])
call denite#custom#source('buffer',   'matchers', ['matcher/ignore_current_buffer'])
call denite#custom#source('tag',      'matchers', ['matcher/substring'])


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

call denite#custom#action('file', 'test', { context -> execute('let g:foo = 1') })
call denite#custom#action('file', 'test2', { context -> denite#do_action(context, 'open', context['targets']) })


call denite#custom#map('insert', "'", '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('normal', 'r', '<denite:do_action:quickfix>', 'noremap')
" call denite#custom#map('insert', ';', 'vimrc#sticky_func()', 'expr')
call denite#custom#map('insert', '<bs>',  '<denite:smart_delete_char_before_caret>', 'noremap')
call denite#custom#map('insert', '<c-h>', '<denite:smart_delete_char_before_caret>', 'noremap')
call denite#custom#map('insert', '<c-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<c-p>', '<denite:move_to_previous_line>', 'noremap')
" call denite#custom#map('insert', '<c-w>', '<denite:move_up_path>', 'noremap')
