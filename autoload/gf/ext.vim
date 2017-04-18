" gf create new file
function! gf#ext#newfile() abort "{{{
  let path = expand('<cfile>')
  if !filereadable(path)
    echo path
    echo 'Create it?(y/N)'
    if nr2char(getchar()) !=? 'y'
      return 0
    end
  endif
  return {'path': expand(path), 'line': 0, 'col': 0,}
endfunction "}}}

function! gf#ext#ruby() abort "{{{
  " variables "{{{
  if !exists('g:ruby_version')
    " let g:ruby_version = matchstr(system('ruby --version'), '\v^ruby\s+\zs(\d\.?)+')
    let g:ruby_version = '2.4.0'
  endif

  if !exists('g:gf_ruby_path')
    " 標準の自動探査だと重い
    let g:gf_ruby_path = join([
          \ expand('~/.rubylib/'),
          \ expand('~/.gem/ruby/'.g:ruby_version),
          \ expand('~/.gem/ruby/'.g:ruby_version.'/gems'),
          \ '/usr/lib/ruby/vendor_ruby/'.g:ruby_version,
          \ '/usr/lib/ruby/vendor_ruby/'.g:ruby_version.'/x86_64-linux',
          \ '/usr/lib/ruby/vendor_ruby',
          \ '/usr/lib/ruby/'.g:ruby_version,
          \ '/usr/lib/ruby/'.g:ruby_version.'/x86_64-linux',
          \ ], ',')
          " \ '~/.gem/ruby/'.g:ruby_version.'/gems/did_you_mean-1.1.2/lib',
  endif
  "}}}

  let save_path = &l:path
  try
    let &l:path = g:gf_ruby_path
    let l:count = 1

    " require_relative
    if getline('.') =~# '\v^\s*require_relative\s*(["'']).*\1\s*$'
      let filepath = '%:h/' .  matchstr(getline('.'),'\v(["''])\zs.{-}\ze\1') . '.rb'

    " require | load | autoload
    elseif getline('.') =~# '^\s*\%(require[( ]\|load[( ]\|autoload[( ]:\w\+,\)\s*\s*\%(::\)\=File\.expand_path(\(["'']\)\.\./.*\1,\s*__FILE__)\s*$'
      let filepath =  '%:h/' . matchstr(getline('.'),'\(["'']\)\.\./\zs.\{-\}\ze\1') . '.rb'
    else
      if getline('.') =~# '^\s*\%(require \|load \|autoload :\w\+,\)\s*\(["'']\).*\1\s*$'
        let filepath = matchstr(getline('.'),'\(["'']\)\zs.\{-\}\ze\1')
      else
        let filepath = expand('<cfile>')
      end
      let filepath = fnameescape(findfile(filepath, &path, l:count))
    endif

    if filepath ==# ''
      return 0
    else
      return {'path': filepath, 'line': 0, 'col': 0,}
    endif
  finally
    let &l:path = save_path
  endtry
endfunction "}}}
