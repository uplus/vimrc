" Altercmd:

if exists(':AlterCommand') != 2
  finish
endif

AlterCommand rec[ache] Recache
AlterCommand gi[na] Gina
AlterCommand ti[g] tabnew\ +Tig
AlterCommand tigb[lame] TigBlame
AlterCommand tb TigBlame
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
AlterCommand ogf OpenGithubFile
AlterCommand ogc GitBlameOpenCommitURL

if has('nvim')
  AlterCommand www w\ suda://%
else
  AlterCommand www w\ !sudo\ tee\ >\ /dev/null\ %
endif
