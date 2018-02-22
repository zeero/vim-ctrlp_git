" =============================================================================
" File:          plugin/ctrlp_git.vim
" Description:   CtrlP Extension for git.
" =============================================================================

if exists('g:loaded_plugin_ctrlp_git') && (! exists('g:ctrlp_git#debug') )
  finish
endif
let g:loaded_plugin_ctrlp_git = 1

let s:save_cpo = &cpo
set cpo&vim

" Variables

" Commands
" command! CtrlPGit call ctrlp#init(ctrlp#git#id())

" Keymaps


let &cpo = s:save_cpo
unlet s:save_cpo

