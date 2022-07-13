" DDC:

" Global:
call ddc#custom#patch_global('sourceOptions', {
    \ '_': {
    \   'ignoreCase': v:true,
    \   'matchers': ['matcher_head'],
    \   'sorters': ['sorter_rank'],
    \   'converters': ['converter_remove_overlap'],
    \ },
    \ 'around': {
    \   'mark': '[A]',
    \   'matchers': ['matcher_head', 'matcher_length'],
    \ },
    \ 'buffer': {
    \   'mark': '[B]',
    \   'matchers': ['matcher_head', 'matcher_length'],
    \   'minAutoCompleteLength': 1,
    \ },
    \ 'cmdline': {
    \   'mark': '[cmdline]',
    \   'forceCompletionPattern': '\S/\S*',
    \ },
    \ 'cmdline-history': {
    \   'mark': '[history]',
    \   'sorters': [],
    \ },
    \ 'necovim': {'mark': '[vim]'},
    \ 'neosnippet': {
    \   'mark': '[ns]',
    \   'dup': v:true,
    \   'minAutoCompleteLength': 1,
    \ },
    \ 'mocword': {
    \   'mark': '[mocword]',
    \   'minAutoCompleteLength': 1,
    \   'maxItems': 6,
    \   'isVolatile': v:true,
    \ },
    \ 'nvim-lsp': {
    \   'mark': '[lsp]',
    \   'forceCompletionPattern': '\.\w*|:\w*|->\w*'
    \ },
    \ 'rtags': {
    \   'mark': '[R]',
    \   'forceCompletionPattern': '\.\w*|:\w*|->\w*'
    \ },
    \ 'file': {
    \   'mark': '[F]',
    \   'isVolatile': v:true,
    \   'minAutoCompleteLength': 1,
    \   'forceCompletionPattern': '\S/\S*',
    \   'sorters': [],
    \ },
    \ 'shell-history': {'mark': '[shell]'},
    \ 'zsh': {
    \   'mark': '[zsh]',
    \   'isVolatile': v:true,
    \   'minAutoCompleteLength': 1,
    \   'forceCompletionPattern': '\S/\S*'
    \ },
    \ 'rg': {
    \   'mark': '[rg]',
    \   'matchers': ['matcher_head', 'matcher_length'],
    \   'minAutoCompleteLength': 1,
    \ },
    \ 'line': {
    \   'mark': '[L]',
    \   'matchers': ['matcher_head', 'matcher_length'],
    \   'minAutoCompleteLength': 1,
    \ },
    \ })

call ddc#custom#patch_global('sourceParams', {
   \ 'buffer': {
   \   'requireSameFiletype': v:false,
   \   'limitBytes': 5000000,
   \   'fromAltBuf': v:true,
   \   'forceCollect': v:true,
   \ },
   \ })

call ddc#custom#patch_global(
    \ 'sources', ['neosnippet', 'around', 'buffer', 'file']
    \ )

" Use pum.vim
call pum#set_option({
 \ 'border': 'single'
 \ })
call ddc#custom#patch_global('autoCompleteEvents', [
  \ 'InsertEnter', 'TextChangedI', 'TextChangedP',
  \ 'CmdlineEnter', 'CmdlineChanged',
  \ ])
call ddc#custom#patch_global('completionMenu', 'pum.vim')


" Filetype:

let s:sources_text = ['neosnippet', 'around', 'buffer', 'rg', 'mocword']
let s:sources_pg = ['neosnippet', 'nvim-lsp', 'around']
let s:lsp_filetypes = ['ruby', 'go', 'rust', 'typescript', 'python', 'yaml']

call ddc#custom#patch_filetype(['help', 'markdown', 'gitcommit', 'text'], 'sources', s:sources_text)

if has('nvim')
  call ddc#custom#patch_filetype(s:lsp_filetypes, 'sources', s:sources_pg)
endif

call ddc#custom#patch_filetype(['deol'], {
  \ 'keywordPattern': '[0-9a-zA-Z_./-]',
  \ 'sources': ['zsh', 'shell-history', 'around'],
  \ })

call ddc#custom#patch_filetype(['vim'],
  \ 'sources',
  \ ['neosnippet', 'necovim', 'around', 'file']
  \ )

call ddc#custom#patch_filetype(['zsh', 'bash'],
  \ 'sources',
  \ ['neosnippet', 'zsh', 'around', 'file']
  \ )

" Context:
" TODO: '_'  で指定したい. 正規表現が使いたい

call ddc#custom#set_context(extend(s:lsp_filetypes, ['vim']), { -> s:context_syntax() })

" 上書きしたいオプションを返す
function! s:context_syntax() abort
  if ddc#syntax#in(['TSNone'])
    " Rubyの "#{}" など
    return {}
  elseif ddc#syntax#in(['String', 'TSString', 'Comment', 'TSComment', 'zshComment', 'vimComment', 'vimLineComment'])
    return  { 'sources': ['file', 'around', 'mocword', 'neosnippet'] }
  else
    return {}
  endif
endfunction

call ddc#enable()
