" quickrun: runner/terminal Runs by termopen()

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
  let opts = {}
  if has('lambda')
    let opts.on_exit = {-> a:session.sweep()}
  endif

  exec self.config.split 'new'
  call termopen(cmd, opts)
  setf quickrun-output
  startinsert
endfunction

function! quickrun#runner#my_terminal#new() abort
  return deepcopy(s:runner)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
