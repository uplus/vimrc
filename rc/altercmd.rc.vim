" Altercmd:
if exists(':CAlterCommand') != 2
  finish
endif

CAlterCommand ins[tall] Install
CAlterCommand rec[ache] Recache

CAlterCommand ww w!
CAlterCommand naw Naw
CAlterCommand qq q!
CAlterCommand me[s] mes
CAlterCommand ftd[etect] filetype detect

CAlterCommand lint ALELint
CAlterCommand fix ALEFix

CAlterCommand movetotab MoveToTab
CAlterCommand maps Maps
CAlterCommand t T
CAlterCommand br botright sp
CAlterCommand tmpb[uffer] TmpBuffer
CAlterCommand tmpc[ommit] TmpCommit

CAlterCommand log Log
CAlterCommand vsh[ell] VimShell
CAlterCommand vsi VimShellInteractive
CAlterCommand den[ite] Denite
CAlterCommand g[ina] Gina
CAlterCommand qr QuickRun
CAlterCommand note Note

if has('nvim')
  CAlterCommand www w suda://%
else
  CAlterCommand www w !sudo tee > /dev/null %
endif
