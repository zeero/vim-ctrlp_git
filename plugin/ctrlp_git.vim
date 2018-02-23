" =============================================================================
" File:          plugin/ctrlp_git.vim
" Description:   CtrlP Extension for git.
" =============================================================================

if exists('g:loaded_ctrlp_git') && (! exists('g:ctrlp_git#debug') )
  finish
endif
let g:loaded_ctrlp_git = 1

let s:save_cpo = &cpo
set cpo&vim

" Variables

" Commands
command! CtrlPGitBranch call ctrlp#init(ctrlp#git_branch#id())
command! CtrlPGitLog call ctrlp#init(ctrlp#git_log#id())

" Keymaps


let &cpo = s:save_cpo
unlet s:save_cpo

