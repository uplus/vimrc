" Altercmd:
if exists(':CAlterCommand') != 2
  finish
endif

CAlterCommand ww w!
CAlterCommand qq q!
CAlterCommand movetotab MoveToTab
CAlterCommand maps Maps
CAlterCommand tig Tig
CAlterCommand t T
CAlterCommand ao[nly] Aonly
CAlterCommand co[nly] Conly
CAlterCommand cap[ture] Capture
CAlterCommand capw[in] CaptureWin
CAlterCommand undoc[lear] UndoClear
CAlterCommand uc[lear] UndoClear
CAlterCommand ec[ho] PP
CAlterCommand br botright sp
CAlterCommand calc Calc
CAlterCommand note Note
CAlterCommand addr[epo] AddRepo
CAlterCommand rms[wap] RmSwap
CAlterCommand pry Pry
CAlterCommand ftd[etect] filetype detect
CAlterCommand tmp[buffer] TmpBuffer

CAlterCommand vsh[ell] VimShell
CAlterCommand vsi VimShellInteractive
CAlterCommand uni[te] Unite
CAlterCommand den[ite] Denite
CAlterCommand vgr[ep] Unite vimgrep
CAlterCommand ug[rep] Unite -auto-resize grep:%::
CAlterCommand qr QuickRun
CAlterCommand log Log
CAlterCommand colortoggle ColorToggle

CAlterCommand clear Clear
CAlterCommand ins[tall] Install
CAlterCommand rec[ache] Recache
CAlterCommand me[s] mes

if has('nvim')
  CAlterCommand www w suda://%
  command! WWW w suda://%
else
  CAlterCommand www w !sudo tee > /dev/null %
  command! WWW w !sudo tee > /dev/null %
endif
