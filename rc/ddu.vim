" hook_add {{{

nnoremap <space>d :Ddu<space>
nnoremap <space>r <Cmd>Ddu -name=search -resume -refresh<CR>

" 動かない (↓ これ？)
" > does not work before |ddu-autocmd-Ddu:uiReady|
" preview使いやすいから別にいいかも
" nnoremap [d
"  \ <Cmd>call ddu#ui#multi_actions([['cursorPrevious'], ['itemAction']], 'search')<CR>
" nnoremap ]d
"  \ <Cmd>call ddu#ui#multi_actions([['cursorNext'], ['itemAction']], 'search')<CR>

" TODO
" nnoremap <silent>;s  <cmd>Denite neosnippet<cr>

" #### file search ####
nnoremap \f
      \ <Cmd>Ddu -name=search
      \ file_point
      \ file_old_rel -source-option-file_old_rel-maxItems=5
      \ file_rg
      \ file -source-param-file-new -source-option-file-volatile
      \ -unique
      \ -sync
      \ -ui-param-ff-displaySourceName=short
      \ <CR>

      " エンターでディレクトリを辿れる
      "\ file -source-option-file-volatile

nnoremap \F
      \ <Cmd>Ddu -name=search
      \ file_point -source-option-file_point-path=`expand('%:h')`
      \ file_rg -source-option-file_rg-path=`expand('%:h')`
      \ -unique
      \ -sync
      \ -ui-param-ff-displaySourceName=short
      \ <CR>

nnoremap \\f
      \ <Cmd>Ddu -name=search
      \ file_old
      \ -unique
      \ -sync
      \ -ui-param-ff-displaySourceName=short
      \ <CR>

nnoremap \b
      \ <Cmd>Ddu -name=search buffer
      \ -sync
      \ -ui-param-ff-displaySourceName=short
      \ <CR>

" #### text search ####

nnoremap s/ <Cmd>Ddu
      \ -name=search line -resume=v:false
      \ -ui-param-ff-ignoreEmpty
      \ <CR>

nnoremap s* <Cmd>Ddu
     \ -name=search line -resume=v:false
     \ -input=`expand('<cword>')`
     \ <CR>

nnoremap g* <Cmd>Ddu
      \ -name=search rg -resume=v:false
      \ -ui-param-ff-ignoreEmpty
      \ -source-param-rg-input='`'<cword>'->expand()`'
      \ <CR>

" 選択範囲を検索
xnoremap g* y<Cmd>Ddu
      \ -name=search rg -resume=v:false
      \ -ui-param-ff-ignoreEmpty
      \ -source-param-rg-input='`'Pattern: '->cmdline#input(v:register->getreg())`'
      \ <CR>

nnoremap sg <Cmd>Ddu
      \ -name=search rg -resume=v:false
      \ -source-option-rg-volatile
      \ <CR>

" 少し対話的に検索(ディレクトリを事前に絞れる)
nnoremap g# <Cmd>Ddu
      \ -name=search rg -resume=v:false
      \ -ui-param-ff-ignoreEmpty
      \ -source-param-rg-input='`'Pattern: '->cmdline#input('<cword>'->expand())`'
      \ -source-option-rg-path='`'Directory: '->cmdline#input($'{getcwd()}/', 'dir')`'
      \ <CR>

" command! Todo     Denite -auto-resize -ignorecase -buffer-name=todo grep:%::(todo|fix|xxx)\:

" #### output ####

nnoremap ;O <Cmd>Ddu
      \ -name=output output
      \ -source-param-output-command=
      \'`'Command: '->cmdline#input('', 'command')`'
      \ <CR>

command! Maps Ddu
      \ -name=output output
      \ -source-param-output-command='map\|map!\|tmap'


" #### misc ####

nnoremap ;r <Cmd>Ddu
      \ -name=register register
      \ -source-option-register-defaultAction=`'.'->col() == 1 ? 'insert' : 'append'`
      \ -ui-param-ff-autoResize
      \ <CR>

xnoremap <expr> ;r
      \ (mode() ==# 'V' ? '"_R<Esc>' : '"_d')
      \ .. '<Cmd>Ddu -name=register register
      \ -source-option-ff-defaultAction=insert
      \ -ui-param-ff-autoResize<CR>'

nnoremap ;: <Cmd>Ddu
      \ -name=command command_history
      \ -ui-param-ff-autoResize
      \ <CR>

nnoremap ;uc <Cmd>Ddu
      \ -name=command command
      \ -ui-param-ff-autoResize
      \ <CR>

nnoremap ;uh <Cmd>Ddu
      \ -name=help help
      \ <CR>

nnoremap ;uj <Cmd>Ddu
      \ -name=search jumplist
      \ -ui-param-ff-autoResize
      \ <CR>

nnoremap sm <Cmd>Ddu
      \ -name=search
      \ marklist -source-param-marklist-buf=`bufnr()`
      \ marklist
      \ -unique
      \ -sync
      \ -ui-param-ff-autoResize
      \ <CR>

nnoremap <silent>;un <cmd>Ddu
  \ -name=search
  \ file_rec -source-option-file_rec-path=`system('note --dir')`
  \ <CR>

nnoremap <silent>;u <nop>

xnoremap ;g <Cmd>call DduUrlItems()<CR>

function! DduUrlItems()
  const region = getregion( getpos('v'), getpos('.'), #{ type: mode() })
  if region->empty()
    return
  endif

  " Get selected URL
  const url = region[0]->substitute('\s*\n\?$', '', '')

  " Convert to items.
  const items = [url]
        \ ->map({ _, url -> #{
        \     word: url,
        \     kind: 'url',
        \     action: #{
        \       url: url,
        \     },
        \   }
        \ })

  "call ddu#start(#{
  "      \   sources: ['item'],
  "      \   sourceParams: #{
  "      \     item: #{
  "      \       items: items,
  "      \     },
  "      \   },
  "      \ })

  " Call chooseAction directly
  call ddu#start(#{
        \   sources: ['action'],
        \   sourceParams: #{
        \     action: #{
        \       items: items,
        \     },
        \   },
        \ })
endfunction

" Open filter window automatically
autocmd User Ddu:uiDone ++nested
  \ call ddu#ui#async_action('openFilterWindow')

" Initialize ddu.vim lazily.
" if !'g:shougo_s_github_load_state'->exists()
"   call timer_start(500, { _ -> LazyDdu() })
"   function LazyDdu()
"     call ddu#load('search', 'ui', ['ff'])
"     call ddu#load('search', 'kind', ['file'])
"     call ddu#load('search', 'source',
"          \   ['file_point', 'file_old', 'file_git', 'file']
"          \ )
"   endfunction
" endif

" }}}

" hook_source {{{

" ddu(=name)単位でaliasを設定する
call ddu#custom#alias("search", "source", "file_rg", "file_external")
call ddu#custom#alias("search", "source", "file_git", "file_external")
" matcher_relative を入れると実質カレントディレクトリからの探索になるので分ける
call ddu#custom#alias("search", "source", "file_old_rel", "file_old")
call ddu#custom#alias("search", "filter", "matcher_ignore_current_buffer", "matcher_ignores")
call ddu#custom#alias("search", "action", "tabopen", "open")
call ddu#custom#alias("search", "action", "split", "open")
call ddu#custom#alias("search", "action", "vsplit", "open")

call ddu#custom#patch_global(#{
      \   ui: 'ff',
      \   uiOptions: #{
      \     filer: #{
      \       toggle: v:true,
      \     },
      \   },
      \   uiParams: #{
      \     ff: #{
      \       split: 'floating',
      \       floatingBorder: 'single',
      \       updateTime: 0,
      \       maxHighlightItems: 200,
      \       inputFunc: "cmdline#input",
      \       inputOptsFunc: "cmdline#input_opts",
      \       highlights: #{
      \         floating: 'Normal',
      \         floatingBorder: 'SrceryCyan',
      \         filterText: "Statement",
      \       },
      \       autoAction: #{
      \         name: 'preview',
      \       },
      \
      \       winHeight: '&lines - 8',
      \       winWidth: '&columns / 2 - 2',
      \       previewFloating: v:true,
      \       previewFloatingBorder: 'single',
      \       previewHeight: '&lines - 8',
      \       previewWidth: '&columns / 2 - 2',
      \       previewRow: 1,
      \       previewCol: '&columns / 2 + 1',
      \     },
      \     filer: #{
      \       split: 'no',
      \       sort: 'filename',
      \       sortTreesFirst: v:true,
      \       toggle: v:true,
      \     },
      \   },
      \   sourceOptions: #{
      \     _: #{
      \       ignoreCase: v:true,
      \       matchers: ['matcher_substring'],
      \       smartCase: v:true,
      \     },
      \     file_old: #{
      \       matchers: [
      \         'matcher_substring',
      \         'matcher_ignore_current_buffer',
      \       ],
      \       converters: ['converter_hl_dir'],
      \     },
      \     file_old_rel: #{
      \       matchers: [
      \         'matcher_substring',
      \         'matcher_relative',
      \         'matcher_ignore_current_buffer',
      \       ],
      \       converters: ['converter_hl_dir'],
      \     },
      \     file_rec: #{
      \       matchers: [
      \         'matcher_substring', 'matcher_hidden',
      \       ],
      \       converters: ['converter_hl_dir'],
      \     },
      \     file: #{
      \       matchers: [
      \         'matcher_substring', 'matcher_hidden',
      \       ],
      \       sorters: ['sorter_alpha'],
      \       converters: ['converter_hl_dir'],
      \     },
      \     file_rg: #{
      \       matchers: [
      \         'matcher_substring', 'matcher_hidden',
      \       ],
      \       sorters: ['sorter_alpha'],
      \       converters: ['converter_hl_dir'],
      \     },
      \     file_git: #{
      \       matchers: [
      \         'matcher_relative',
      \         'matcher_substring',
      \       ],
      \       sorters: ['sorter_mtime'],
      \       converters: ['converter_hl_dir'],
      \     },
      \     buffer: #{
      \       matchers: [
      \         'matcher_substring',
      \         'matcher_hidden',
      \         'matcher_ignore_current_buffer',
      \       ],
      \       sorters: ['sorter_alpha'],
      \       converters: ['converter_hl_dir'],
      \     },
      \     dein: #{
      \       defaultAction: 'cd',
      \     },
      \     markdown: #{
      \       sorters: [],
      \     },
      \     line: #{
      \       matchers: [
      \         'matcher_substring',
      \       ],
      \     },
      \     path_history: #{
      \       defaultAction: 'uiCd',
      \     },
      \     rg: #{
      \       matchers: [
      \         'matcher_substring', 'matcher_files',
      \       ],
      \     },
      \     command_args: #{
      \       defaultAction: 'execute',
      \     },
      \     command_history: #{
      \       defaultAction: 'execute',
      \     },
      \     command: #{
      \       defaultAction: 'edit',
      \     },
      \     help: #{
      \       defaultAction: 'open',
      \     },
      \     jumplist: #{
      \       defaultAction: 'jump',
      \     },
      \     marklist: #{
      \       defaultAction: 'jump',
      \     },
      \   },
      \   sourceParams: #{
      \     file_git: #{
      \       cmd: ['git', 'ls-files', '-co', '--exclude-standard'],
      \     },
      \     rg: #{
      \       args: [
      \         '--smart-case', '--column', '--no-heading',
      \         '--color', 'never',
      \       ],
      \     },
      \     file_rg: #{
      \       cmd: [
      \         'rg', '--files',
      \         '--glob', '!.git',
      \         '--color', 'never',
      \         '--no-messages'],
      \       updateItems: 50000,
      \     },
      \   },
      \   filterParams: #{
      \     matcher_kensaku: #{
      \       highlightMatched: 'Search',
      \     },
      \     matcher_substring: #{
      \       highlightMatched: 'Search',
      \     },
      \     matcher_ignore_files: #{
      \       ignoreGlobs: ['test_*.vim'],
      \       ignorePatterns: [],
      \     },
      \     converter_hl_dir: #{
      \       hlGroup: ["Directory", "Keyword"],
      \     },
      \     matcher_ignore_current_buffer: #{
	    \       ignores: '%'->bufname()->fnamemodify(':p'),
	    \       actionKey: 'path',
      \     }
      \   },
      \   kindOptions: #{
      \     file: #{
      \       defaultAction: 'open',
      \     },
      \     word: #{
      \       defaultAction: 'append',
      \     },
      \     deol: #{
      \       defaultAction: 'switch',
      \     },
      \     action: #{
      \       defaultAction: 'do',
      \     },
      \     readme_viewer: #{
      \       defaultAction: 'open',
      \     },
      \     url: #{
      \       defaultAction: 'browse',
      \     },
      \   },
      \   kindParams: #{
      \     action: #{
      \       quit: v:true,
      \     },
      \   },
      \   actionOptions: #{
      \     narrow: #{
      \       quit: v:false,
      \     },
      \   },
      \   actionParams: #{
      \     tabopen: #{
      \       command: 'tabedit',
      \     },
      \     split: #{
      \       command: 'split',
      \     },
      \     vsplit: #{
      \       command: 'vsplit',
      \     },
      \   },
      \ })

" アクション後にタブを閉じないように設定できる
      "\     tabopen: #{
      "\       " quit: v:false,
      "\     },

call ddu#custom#action('kind', 'file', 'grep', { args -> GrepAction(args) })
function! GrepAction(args)
  call ddu#start(#{
        \   name: a:args.options.name,
        \   push: v:true,
        \   sources: [
        \     #{
        \       name: 'rg',
        \       params: #{
        \         path: a:args.items[0].action.path,
        \         input: 'Pattern: '->input(),
        \       },
        \     },
        \   ],
        \ })
endfunction

" Qfreplace
call ddu#custom#action('kind', 'file', 'qfreplace', { args -> s:action_qfreplace(args) })
function! s:action_qfreplace(args)
  call ddu#item_action('search', 'quickfix', a:args.items, {})
  Qfreplace
  cclose
endfunction

" Define cd action for "ddu-ui-filer"
call ddu#custom#action('kind', 'file', 'uiCd', { args -> UiCdAction(args) })
function! UiCdAction(args)
  const path = a:args.items[0].action.path
  const directory = path->isdirectory() ? path : path->fnamemodify(':h')

  call ddu#ui#do_action('itemAction',
        \ #{ name: 'narrow', params: #{ path: directory } })
endfunction
" }}}

" hook_post_update {{{
call ddu#set_static_import_path()
" }}}
