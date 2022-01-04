" Altercmd:

if exists(':AlterCommand') != 2
  finish
endif

AlterCommand rec[ache] Recache
AlterCommand den[ite] Denite
AlterCommand gi[na] Gina
AlterCommand ti[g] Tig
AlterCommand tigb[lame] TigBlame
AlterCommand maps Maps

AlterCommand lint ALELint
AlterCommand fix ALEFix

AlterCommand ww w!
AlterCommand naw Naw
AlterCommand t tabedit
" AlterCommand ftd[etect] filetype detect
" AlterCommand br botright sp
" AlterCommand qq q!
" AlterCommand me[s] mes

AlterCommand tmpb[uffer] TmpBuffer
AlterCommand tmpc[ommit] TmpCommit
AlterCommand note Note

if has('nvim')
  AlterCommand www w\ suda://%
else
  AlterCommand www w\ !sudo\ tee\ >\ /dev/null\ %
endif
