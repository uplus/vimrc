" DDC:

" Global:
"   keywordPattern: 補完アイテムが記号でも継続できるようにする
" lspのforceCompletionPatternはuga-rosa/ddc-source-lsp-setupで設定される
call ddc#custom#patch_global('sourceOptions', {
    \ '_': {
    \   'ignoreCase': v:true,
    \   'matchers': ['matcher_head'],
    \   'sorters': ['sorter_rank'],
    \   'converters': ['converter_remove_overlap', 'converter_truncate_abbr'],
    \   'keywordPattern': '[a-zA-Z_+-]\w*'
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
    \   'maxItems': 5,
    \   'minAutoCompleteLength': 1,
    \ },
    \ 'mocword': {
    \   'mark': '[mocword]',
    \   'minAutoCompleteLength': 1,
    \   'maxItems': 5,
    \   'isVolatile': v:true,
    \ },
    \ 'copilot': {
    \     'mark': '[copilot]',
    \     'matchers': [],
    \     'minAutoCompleteLength': 0,
    \     'isVolatile': v:true,
    \ },
    \ 'lsp': {
    \   'mark': '[lsp]',
    \   'minAutoCompleteLength': 1,
    \   'maxItems': 10,
    \   'forceCompletionPattern': '(?:\.|:|->)(?:\w|-|\+)*'
    \ },
    \ 'nvim-lua': {
    \   'mark': '[lua]',
    \   'forceCompletionPattern': '(?:\.|:|->)(?:\w|-|\+)*'
    \ },
    \ 'rtags': {
    \   'mark': '[R]',
    \   'forceCompletionPattern': '(?:\.|:|->)(?:\w|-|\+)*'
    \ },
    \ 'file': {
    \   'mark': '[F]',
    \   'isVolatile': v:true,
    \   'minAutoCompleteLength': 1,
    \   'forceCompletionPattern': '\S/\S*',
    \   'sorters': [],
    \ },
    \ 'shell-history': {'mark': '[shell]'},
    \ 'shell-native': {
    \   'mark': '[shell]',
    \   'isVolatile': v:true,
    \   'minAutoCompleteLength': 1,
    \   'forceCompletionPattern': '\S/\S*'
    \ },
    \ 'rg': {
    \   'mark': '[rg]',
    \   'matchers': ['matcher_head', 'matcher_length'],
    \   'minAutoCompleteLength': 1,
    \   'maxItems': 5,
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
   \ 'lsp': {
   \    'enableResolveItem': v:true,
   \    'enableAdditionalTextEdit': v:true,
   \ },
   \ 'shell-native': { 'shell': 'zsh' },
   \ })

call ddc#custom#patch_global(
    \ 'sources', ['neosnippet', 'around', 'buffer', 'file']
    \ )

call ddc#custom#patch_global({
  \ 'autoCompleteEvents': [
  \   'InsertEnter', 'TextChangedI', 'TextChangedP',
  \   'CmdlineEnter', 'CmdlineChanged',
  \ ],
  \ })

" Use pum.vim
call ddc#custom#patch_global('ui', 'pum')
call pum#set_option({
  \ 'border': 'single',
  \ 'scrollbar_char': '│',
  \ 'auto_select': v:false,
  \ 'use_setline': v:true,
  \ 'max_width': 80,
  \ })


" Filetype:

let s:sources_text = ['neosnippet', 'around', 'buffer', 'rg', 'mocword']
let s:sources_pg = ['copilot', 'neosnippet', 'lsp', 'around', 'buffer']
let s:lsp_filetypes = ['ruby', 'go', 'rust', 'typescript', 'javascript', 'python', 'dockerfile', 'scala', 'lua']

call ddc#custom#patch_filetype(['help', 'markdown', 'gitcommit', 'text'], 'sources', s:sources_text)

call ddc#custom#patch_filetype(s:lsp_filetypes, 'sources', s:sources_pg)

call ddc#custom#patch_filetype(['yaml', 'json'],
  \ 'sources',
  \ ['neosnippet', 'lsp', 'around', 'file', 'mocword']
  \ )

call ddc#custom#patch_filetype(['deol'], {
  \ 'keywordPattern': '[0-9a-zA-Z_./-]',
  \ 'sources': ['shell-native', 'shell-history', 'around'],
  \ })

call ddc#custom#patch_filetype(['vim'],
  \ 'sources',
  \ ['neosnippet', 'necovim', 'around', 'file']
  \ )

call ddc#custom#patch_filetype(['lua'],
 \ 'sources',
 \ ['neosnippet', 'nvim-lua', 'lsp', 'around', 'file']
 \ )

call ddc#custom#patch_filetype(['zsh', 'bash'],
  \ 'sources',
  \ ['neosnippet', 'shell-native', 'around', 'file']
  \ )

" Context:
" TODO: '_'  で指定したい. 正規表現が使いたい

call ddc#custom#set_context_filetype(extend(s:lsp_filetypes, ['vim']), { -> s:context_syntax() })

" 上書きしたいオプションを返す
function! s:context_syntax() abort
  " treesitter由来は小文字始まり
  if ddc#syntax#in(['none'])
    " Rubyの "#{}" など
    return {}
  elseif ddc#syntax#in(['String', 'string', 'Comment', 'comment', 'zshComment', 'vimComment', 'vimLineComment'])
    return  { 'sources': ['file', 'around', 'mocword', 'neosnippet'] }
  else
    return {}
  endif
endfunction

call ddc#enable()
