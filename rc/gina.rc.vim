" Options:
call gina#custom#command#option(
  \ 'commit', '-v|--verbose'
  \)
call gina#custom#command#option(
  \ '/\%(status\|commit\)',
  \ '-u|--untracked-files'
  \)
call gina#custom#command#option(
  \ 'status',
  \ '-b|--branch'
  \)
" call gina#custom#command#option(
"  \ 'status',
"  \ '-s|--short'
"  \)
call gina#custom#command#option(
  \ '/\%(commit\|tag\)',
  \ '--restore'
  \)
call gina#custom#command#option(
  \ 'show',
  \ '--show-signature'
  \)

" Opener:
call gina#custom#command#option(
  \ '/\%(branch\)',
  \ '--opener', 'split'
  \)

call gina#custom#command#option(
  \ '/\%(diff\|d\|grep\)',
  \ '--opener', 'vsplit'
  \)

call gina#custom#command#option(
  \ '/\%(log\|l\|reflog\|status\|s\|blame\|b\|compare\|c\|patch\)',
  \ '--opener', 'tabedit'
  \)

" Command Alias:
call gina#custom#command#alias('status', 's')
call gina#custom#command#alias('compare', 'c')
call gina#custom#command#alias('diff', 'd')
call gina#custom#command#alias('blame', 'b')
call gina#custom#command#alias('log', 'l')

" Aliases:
call gina#custom#action#alias(
  \ 'branch', 'track',
  \ 'checkout:track'
  \)
call gina#custom#action#alias(
  \ 'branch', 'merge',
  \ 'commit:merge'
  \)
call gina#custom#action#alias(
  \ 'branch', 'rebase',
  \ 'commit:rebase'
  \)
call gina#custom#action#alias(
  \ '/\%(blame\|log\|reflog\)',
  \ 'preview',
  \ 'show:commit:preview',
  \)
call gina#custom#action#alias(
  \ '/\%(blame\|log\|reflog\)',
  \ 'changes',
  \ 'changes:of:preview',
  \)

" Mappings:
call gina#custom#mapping#nmap(
 \ '/\%(.*\)',
 \ '<tab>',
 \ ':<c-u>call gina#action#call(''builtin:choice'')<cr>',
 \ {'noremap': 1, 'silent': 1}
 \)

call gina#custom#mapping#nmap(
 \ '/\%(blame\|log\|reflog\)',
 \ 'p',
 \ ':<C-u>call gina#action#call(''preview'')<CR>',
 \ {'noremap': 1, 'silent': 1}
 \)

call gina#custom#mapping#nmap(
  \ 'blame',
  \ 'j',
  \ 'j<Plug>(gina-blame-echo)'
  \)

call gina#custom#mapping#nmap(
  \ 'blame',
  \ 'k',
  \ 'k<Plug>(gina-blame-echo)'
  \)

call gina#custom#mapping#nmap(
  \ 'blame',
  \ 'yy',
  \ '<Plug>(gina-yank-rev)'
  \)

call gina#custom#mapping#nmap(
 \ 'status',
 \ '<cr>',
 \ '<plug>(gina-diff)'
 \)

" pp と被る
" call gina#custom#mapping#nmap(
" \ 'status',
" \ 'p',
" \ '<cmd>call gina#action#call(''diff:preview'')<cr>',
" \ {'noremap': 1, 'silent': 1}
" \)

call gina#custom#mapping#nmap(
 \ 'status',
 \ 'u',
 \ '<plug>(gina-index-toggle)'
 \)

call gina#custom#mapping#nmap(
  \ 'status', 'C',
  \ '<cmd>Gina commit<cr>',
  \ {'noremap': 1, 'silent': 1, 'nowait': 1},
  \)

call gina#custom#mapping#nmap(
  \ 'status', 'F',
  \ '<cmd>Gina commit --amend<cr>',
  \ {'noremap': 1, 'silent': 1, 'nowait': 1},
  \)

" call gina#custom#mapping#nmap(
"  \ 'branch', 'g<CR>',
"  \ '<Plug>(gina-commit-checkout-track)'
"  \)
" call gina#custom#mapping#nmap(
"  \ 'status', '<C-^>',
"  \ ':<C-u>Gina commit<CR>',
"  \ {'noremap': 1, 'silent': 1}
"  \)
" call gina#custom#mapping#nmap(
"  \ 'commit', '<C-^>',
"  \ ':<C-u>Gina status<CR>',
"  \ {'noremap': 1, 'silent': 1}
"  \)
" call gina#custom#mapping#nmap(
"  \ 'status', '<C-6>',
"  \ ':<C-u>Gina commit<CR>',
"  \ {'noremap': 1, 'silent': 1}
"  \)
" call gina#custom#mapping#nmap(
"  \ 'commit', '<C-6>',
"  \ ':<C-u>Gina status<CR>',
"  \ {'noremap': 1, 'silent': 1}
"  \)
" call gina#custom#mapping#nmap(
"  \ '/\%(blame\|log\|reflog\)',
"  \ 'c',
"  \ ':<C-u>call gina#action#call(''changes'')<CR>',
"  \ {'noremap': 1, 'silent': 1}
"  \)

" Executes:
call gina#custom#execute(
  \ '/\%(.*\)',
  \ 'nnoremap <silent><buffer>q <cmd>call GinaSmartQuit()<cr>',
  \)
call gina#custom#execute(
  \ '/\%(.*\)',
  \ 'setlocal cursorline signcolumn=no',
  \)
call gina#custom#execute(
  \ '/\%(ls\|log\|reflog\|grep\)',
  \ 'setlocal noautoread',
  \)
call gina#custom#execute(
  \ '/\%(status\|branch\|ls\|log\|reflog\|grep\)',
  \ 'setlocal cursorline',
  \)

function! GinaSmartQuit() abort
  let tab_win_count = len(nvim_tabpage_list_wins(0))

  " 自身は無条件でquitする
  wincmd q

  " 自分以外にもウインドがあるなら、タブ内にあるdiffウィンドウを全てquitする
  " patch向け(patchのバッファはpatchやshowなどが使われる)
  if 2 <= tab_win_count
    call my#option#close_current_tab_diff_wins()
  endif
endfunction

" Gina diff --group=abc{bufnr('%')}
" vertical topleft split tags
