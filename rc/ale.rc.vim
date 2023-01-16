" Disable features
let g:ale_disable_lsp = 1
let g:ale_completion_enabled = 0

let g:ale_echo_cursor = 0
let g:ale_set_highlights = 0
let g:ale_set_signs = 1
let g:ale_virtualtext_cursor = 2

" Lint config
let g:ale_lint_delay = 10
let g:ale_lint_on_enter = 1
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_text_changed = 'always'

" Fixer
let g:ale_fix_on_save = 0
" let g:ale_fix_on_save_ignore = {}

" Sign
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
" let g:ale_sign_info = '🛈'
let g:ale_sign_info = 'ℹ'

" Virtualtext
" let g:ale_virtualtext_prefix = '    ■ '
let g:ale_virtualtext_prefix = '%comment% '
" let g:ale_virtualtext_delay = 10

" List
let g:ale_set_quickfix = 1
let g:ale_set_loclist = !g:ale_set_quickfix
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 1
let g:ale_list_window_open_type= 'botright'

function! s:set_ale_win_height(percent) abort
  let height = float2nr(&lines * a:percent)
  let g:ale_list_window_size = u#clamp(height, 5, 15)
endfunction

call s:set_ale_win_height(0.1)
au myac VimEnter,VimResized * call s:set_ale_win_height(0.1)

" Lint
let g:ale_linter_aliases = {
  \ 'javascriptreact': ['javascript'],
  \ 'jsx': ['javascriptreact'],
  \ 'typescriptreact': ['typescript'],
  \ 'vue': ['javascript'],
  \ }

let g:ale_linters = {
  \ 'c': ['clang'],
  \ 'javascript': ['eslint'],
  \ 'json': ['jq'],
  \ 'jsx': ['eslint'],
  \ 'markdown': [],
  \ 'go': [],
  \ 'python': ['flake8'],
  \ 'ruby': ['rubocop'],
  \ 'rust': ['rustc', 'rustfmt'],
  \ 'terraform': ['terraform'],
  \ 'typescript': ['eslint'],
  \ }

let g:ale_fixers = {
  \ 'c': ['clang-format'],
  \ 'cpp': ['clang-format'],
  \ 'go': ['gofmt'],
  \ 'javascript': ['eslint'],
  \ 'json': ['jq'],
  \ 'python': ['autopep8'],
  \ 'ruby': ['rubocop'],
  \ 'terraform': ['terraform'],
  \ 'typescript': ['eslint'],
  \ 'vim': ['vint'],
  \ }

let g:ale_pattern_options = {
  \ '\.min\.js$': { 'ale_enabled': 0 },
  \ '\.toml$': { 'ale_enabled': 0 },
  \ '\.gql$': { 'ale_enabled': 0 },
  \ '\.gem/ruby/': { 'ale_enabled': 0 },
  \ 'src/gems/': { 'ale_enabled': 0 },
  \ 'src/npm/': { 'ale_enabled': 0 },
  \ }

" General text lint
let g:ale_warn_about_trailing_whitespace = 1
let g:ale_warn_about_trailing_blank_lines = 1

" Languages Config:
" let g:ale_ruby_rubocop_auto_correct_all = 1

" Docker:
" .vimrc.localに以下のようなものを記載
" let b:ale_command_wrapper = 'docker-compose exec -T -- api bundle exec'
" let b:ale_filename_mappings = { '*': [[expand('<sfile>:p:h'), './']] }
