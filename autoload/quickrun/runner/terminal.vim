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

  let cmd = join(a:commands, ' && ')
  " ConsoleLog a:session._temp_names
  exec self.config.split 'new'
  let s:session = a:session
  let sweep_lambda = { -> a:session.sweep() }
  call termopen(cmd, {'on_exit': sweep_lambda })
  startinsert

  " TODO こうしないとsweepが発火しない
  " au TermClose <buffer> call s:session.sweep()
endfunction

function! quickrun#runner#terminal#new() abort
  return deepcopy(s:runner)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
