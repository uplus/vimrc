" DDC:

" Global:
call ddc#custom#patch_global(
    \ 'sources', ['neosnippet', 'around', 'file', 'rg']
    \ )
call ddc#custom#patch_global('sourceOptions', {
    \ '_': {
    \   'ignoreCase': v:true,
    \   'matchers': ['matcher_head'],
    \   'sorters': ['sorter_rank'],
    \   'converters': ['converter_remove_overlap'],
    \ },
    \ 'around': {
    \   'mark': 'A',
    \   'matchers': ['matcher_head', 'matcher_length'],
    \ },
    \ 'buffer': {
    \   'mark': 'B',
    \   'matchers': ['matcher_head', 'matcher_length'],
    \   'minAutoCompleteLength': 1,
    \ },
    \ 'cmdline': {
    \   'mark': 'cmdline',
    \   'forceCompletionPattern': '\S/\S*',
    \ },
    \ 'cmdline-history': {
    \   'mark': 'history',
    \   'sorters': [],
    \ },
    \ 'necovim': {'mark': 'vim'},
    \ 'neosnippet': {
    \   'mark': 'ns',
    \   'dup': v:true,
    \   'minAutoCompleteLength': 1,
    \ },
    \ 'nextword': {
    \   'mark': 'nextword',
    \   'minAutoCompleteLength': 1,
    \   'maxItems': 10,
    \   'isVolatile': v:true,
    \ },
    \ 'nvim-lsp': {
    \   'mark': 'lsp',
    \   'forceCompletionPattern': '\.\w*|:\w*|->\w*'
    \ },
    \ 'rtags': {
    \   'mark': 'R',
    \   'forceCompletionPattern': '\.\w*|:\w*|->\w*'
    \ },
    \ 'file': {
    \   'mark': 'F',
    \   'isVolatile': v:true,
    \   'minAutoCompleteLength': 1,
    \   'forceCompletionPattern': '\S/\S*',
    \   'sorters': [],
    \ },
    \ 'shell-history': {'mark': 'shell'},
    \ 'zsh': {
    \   'mark': 'zsh',
    \   'isVolatile': v:true,
    \   'minAutoCompleteLength': 1,
    \   'forceCompletionPattern': '\S/\S*'
    \ },
    \ 'rg': {
    \   'mark': 'rg',
    \   'matchers': ['matcher_head', 'matcher_length'],
    \   'minAutoCompleteLength': 1,
    \ },
    \ 'line': {
    \   'mark': 'L',
    \   'matchers': ['matcher_head', 'matcher_length'],
    \   'minAutoCompleteLength': 1,
    \ },
    \ })
call ddc#custom#patch_global('sourceParams', {
    \ 'buffer': {
    \   'requireSameFiletype': v:false,
    \   'limitBytes': 5000000,
    \   'fromAltBuf': v:false,
    \   'forceCollect': v:false,
    \ },
    \ })

" Use pum.vim
call ddc#custom#patch_global('autoCompleteEvents', [
  \ 'InsertEnter', 'TextChangedI', 'TextChangedP',
  \ 'CmdlineEnter', 'CmdlineChanged',
  \ ])
call ddc#custom#patch_global('completionMenu', 'pum.vim')


" Filetype:
call ddc#custom#patch_filetype(['help', 'markdown', 'gitcommit', 'text'],
  \ 'sources',
  \ ['neosnippet', 'around', 'buffer', 'nextword']
  \ )

if has('nvim')
  call ddc#custom#patch_filetype(['ruby', 'rust', 'typescript', 'go', 'python'],
    \ 'sources',
    \ ['neosnippet', 'nvim-lsp', 'around']
    \ )
endif

call ddc#custom#patch_filetype(['deol'], {
  \ 'keywordPattern': '[0-9a-zA-Z_./-]',
  \ 'sources': ['zsh', 'shell-history', 'around'],
  \ })

call ddc#custom#patch_filetype(['vim'],
  \ 'sources',
  \ ['necovim', 'neosnippet', 'around', 'file']
  \ )

call ddc#custom#patch_filetype(['zsh', 'bash'],
  \ 'sources',
  \ ['zsh', 'neosnippet', 'around', 'file']
  \ )

" Context:
" TODO: '_'  で指定したい. 正規表現が使いたい

call ddc#custom#set_context(['ruby', 'c', 'go', 'rust', 'python', 'zsh', 'vim'],
  \ { -> s:context_syntax() }
  \ )

function! s:context_syntax() abort
  if ddc#syntax#in(['Comment', 'TSComment'])
    return { 'sources': ['around', 'nextword', 'neosnippet'] }
  elseif ddc#syntax#in(['String', 'TSString', 'zshComment', 'vimComment', 'vimLineComment'])
    return  { 'sources': ['file', 'around', 'nextword', 'neosnippet'] }
  else
    return {}
  endif
endfunction

call ddc#enable()
