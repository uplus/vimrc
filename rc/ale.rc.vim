" Disable features
let g:ale_history_enabled = 0
let g:ale_disable_lsp = 1
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 0

let g:ale_set_signs = 1
let g:ale_virtualtext_cursor = 1
let g:ale_set_highlights = 0
let g:ale_echo_cursor = 0

" Lint config
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_save = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_insert_leave = 0
" let g:ale_lint_delay = 1000

" Sign
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = '🛈'

" Virtualtext
let g:ale_virtualtext_prefix = ' ← '
" let g:ale_virtualtext_delay = 10

" List
let g:ale_set_quickfix = 1
let g:ale_set_loclist = !g:ale_set_quickfix
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 1
let g:ale_list_window_size = 5
let g:ale_list_window_open_type= 'botright'

" General text lint
let g:ale_warn_about_trailing_whitespace = 1
let g:ale_warn_about_trailing_blank_lines = 1

" Buffer only samples
" let b:ale_ruby_rubocop_executable = 'bundle exec rubocop'
" let b:ale_ruby_rubocop_executable = 'docker-compose exec api bundle exec rubocop'
" let b:ale_typescriptreact_eslint_executable = 'docker-compose exec ui yarn lint'

let g:ale_linters = {
  \ 'markdown': [],
  \ 'ruby': ['rubocop'],
  \ 'c': ['clang'],
  \ 'rust': ['rustc', 'rustfmt'],
  \ 'jsx': ['eslint'],
  \ 'javascript': ['eslint'],
  \ 'typescript': ['eslint'],
  \ }

let g:ale_linter_aliases = {
  \ 'javascriptreact': ['javascript', 'jsx'],
  \ 'typescriptreact': ['typescript'],
  \ }

" :ALEFix
let g:ale_fixers = {
  \ 'vim': ['vint'],
  \ 'ruby': ['rubocop'],
  \ 'c': ['clang-format'],
  \ 'cpp': ['clang-format'],
  \ 'go': ['gofmt'],
  \ 'jsx': ['eslint'],
  \ 'javascript': ['eslint'],
  \ 'typescript': ['eslint'],
  \ 'typescriptreact': ['eslint'],
  \ }

let g:ale_pattern_options = {
  \ '\.min\.js$': { 'ale_enabled': 0 },
  \ '\.toml$': { 'ale_enabled': 0 },
  \ '\.gql$': { 'ale_enabled': 0 },
  \ '\.gem/ruby/': { 'ale_enabled': 0 },
  \ 'src/gems/': { 'ale_enabled': 0 },
  \ }
