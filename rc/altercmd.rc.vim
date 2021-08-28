" Altercmd:

if exists(':CAlterCommand') != 2
  finish
endif

CAlterCommand rec[ache] Recache
CAlterCommand den[ite] Denite
CAlterCommand gi[na] Gina
CAlterCommand maps Maps

CAlterCommand lint ALELint
CAlterCommand fix ALEFix

CAlterCommand ww w!
CAlterCommand naw Naw
CAlterCommand t tabedit
" CAlterCommand ftd[etect] filetype detect
" CAlterCommand br botright sp
" CAlterCommand qq q!
" CAlterCommand me[s] mes

CAlterCommand tmpb[uffer] TmpBuffer
CAlterCommand tmpc[ommit] TmpCommit
CAlterCommand note Note

if has('nvim')
  CAlterCommand www w suda://%
else
  CAlterCommand www w !sudo tee > /dev/null %
endif
