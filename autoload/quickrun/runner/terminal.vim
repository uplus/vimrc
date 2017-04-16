" quickrun: runner/terminal Runs by termopen()
" Author : thinca <thinca+vim@gmail.com>
" License: zlib License


let s:save_cpo = &cpo
set cpo&vim

let s:runner = {
\   'config': {
\     'split': 'botright',
\     'timeout': 60*1000,
\   }
\ }

function! s:runner.init(session) abort
  let a:session.config.outputter = 'null'
endfunction

function! s:runner.validate() abort
  if !exists('*termopen')
    throw 'Needs termopen()'
  endif
endfunction

function! s:runner.run(commands, input, session) abort
  if a:input !=# ''
    let inputfile = a:session.tempname()
    call writefile(split(a:input, "\n", 1), inputfile, 'b')
  endif

  " TODO cとかだとコンパイルが終わる前に実行してえらー
  let jobid = 0
  for cmd in a:commands
    ConsoleLog 
    if -1 == jobwait([jobid], self.config.timeout)
      return 
    endif
    exec self.config.split 'new'
    let jobid = termopen(cmd)
    startinsert
    if v:shell_error != 0
      break
    endif
  endfor
endfunction


function! quickrun#runner#terminal#new() abort
  return deepcopy(s:runner)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
