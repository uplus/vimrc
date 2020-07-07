let g:ale_fix_on_save = 0
let g:ale_history_enabled = 0
let g:ale_completion_enabled = 0
let g:ale_max_buffer_history_size = 10

let g:ale_warn_about_trailing_whitespace = 1
let g:ale_warn_about_trailing_blank_lines = 1

let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_save = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_delay = 1000

let g:ale_set_signs = 0
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_style_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_sign_style_warning = '--'
let g:ale_sign_info = '--'

" let g:syntastic_error_symbol   = '✗'
" let g:syntastic_warning_symbol = '⚠'
" let g:syntastic_ruby_mri_args        = '-W1'

let g:ale_disable_lsp = 1
let g:ale_virtualtext_cursor = 0
let g:ale_echo_cursor = 0
let g:ale_set_highlights = 0

let g:ale_set_quickfix = 1
let g:ale_set_loclist = !g:ale_set_quickfix
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 1
let g:ale_list_window_size = 5
let g:ale_list_window_open_type= 'botright'

let b:ale_ruby_rubocop_executable = 'bundle exec rubocop'
" let b:ale_ruby_rubocop_executable = 'docker-compose exec --rm api bundle exec rubocop'
" let b:ale_typescriptreact_eslint_executable = 'docker-compose exec ui yarn lint'

let g:ale_linters = {
  \ 'markdown': [],
  \ 'ruby': ['rubocop'],
  \ 'c': ['clang'],
  \ 'rust': ['rustc', 'rustfmt'],
  \ 'javascript': ['eslint'],
  \ 'typescript': ['eslint'],
  \ }

let g:ale_linter_aliases = {
  \ 'javascriptreact': ['javascript', 'jsx'],
  \ 'typescriptreact': ['typescript', 'tsx'],
  \ }

" :ALEFix
let g:ale_fixers = {
  \ 'vim': ['vint'],
  \ 'ruby': ['rubocop'],
  \ 'c': ['clang-format'],
  \ 'cpp': ['clang-format'],
  \ 'go': ['gofmt'],
  \ 'javascript': ['eslint'],
  \ 'typescript': ['eslint'],
  \ 'typescriptreact': ['eslint'],
  \ }

let g:ale_pattern_options = {
  \ '\.min\.js$': { 'ale_enabled': 0 },
  \ '\.toml$': { 'ale_enabled': 0 },
  \ '.gem/ruby/': { 'ale_enabled': 0 },
  \ 'src/gems/': { 'ale_enabled': 0 },
  \ '.gql': { 'ale_enabled': 0 },
  \ }

" This option prevents ALE autocmd commands from being run for particular
" filetypes which can cause issues.
let g:ale_filetype_blacklist = [
  \ 'dirvish',
  \ 'qf',
  \ 'tags',
  \ 'denite',
  \ 'defx'
  \]
