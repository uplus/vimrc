
let s:c_opt = substitute($C_COMP_OPT, '-lm ', '','')

let s:config = {
      \ 'watchdogs_checker/_' : {
      \   'hook/close_unite_quickfix/enable_module_loaded'  : 1,
      \   'hook/clear_quickfix/enable_hook_loaded'          : 1,
      \   'hook/unite_quickfix/enable_exit'                 : 1,
      \   'hook/back_window/enable_exit'             : 0,
      \   'hook/back_window/priority_exit'           : 1,
      \   'hook/quickfix_status_enable/enable_exit'  : 1,
      \   'hook/quickfix_status_enable/priority_exit': 2,
      \   'hook/hier_update/enable_exit'             : 1,
      \   'hook/hier_update/priority_exit'           : 3,
      \ },
      \	'c/watchdogs_checker' : {
      \		'type'
      \			: executable('clang') ? 'watchdogs_checker/clang'
      \			: executable('gcc')   ? 'watchdogs_checker/gcc'
      \			:''
      \	},
      \	'cpp/watchdogs_checker' : {
      \		'type'
      \			: executable('clang-check') ? 'watchdogs_checker/clang_check'
      \			: executable('clang++')     ? 'watchdogs_checker/clang++'
      \			: executable('g++')         ? 'watchdogs_checker/g++'
      \			: executable('cl')          ? 'watchdogs_checker/cl'
      \			:'',
      \	},
      \	'watchdogs_checker/gcc'     : { 'cmdopt': s:c_opt },
      \	'watchdogs_checker/clang'   : { 'cmdopt': s:c_opt },
      \	'watchdogs_checker/g++'     : { 'cmdopt': $CPP_COMP_OPT },
      \	'watchdogs_checker/clang++' : { 'cmdopt': $CPP_COMP_OPT },
      \ 'watchdogs_checker/c89' : {
      \   'command': 'gcc',
      \   'exec': '%c %o -fsyntax-only %s:p',
      \   'cmdopt': s:c_opt . ' -std=c89',
      \ },
      \}

call extend(g:quickrun_config, s:config)
unlet s:config

call watchdogs#setup(g:quickrun_config)
