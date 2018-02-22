" =============================================================================
" File:          plugin/ctrlp_template.vim
" Description:   CtrlP Extension for template.
" =============================================================================

if exists('g:loaded_plugin_ctrlp_template') && (! exists('g:ctrlp_template#debug') )
  finish
endif
let g:loaded_plugin_ctrlp_template = 1

let s:save_cpo = &cpo
set cpo&vim

" Variables

" Commands
" command! CtrlPTemplate call ctrlp#init(ctrlp#template#id())

" Keymaps


let &cpo = s:save_cpo
unlet s:save_cpo

