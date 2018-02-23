" =============================================================================
" File:          autoload/ctrlp/git_branch.vim
" Description:   CtrlP Extension for git_branch.
" =============================================================================

" To load this extension into ctrlp, add this to your vimrc:
"
"     let g:ctrlp_extensions = ['git_branch']
"
" Where 'git_branch' is the name of the file 'git_branch.vim'
"
" For multiple extensions:
"
"     let g:ctrlp_extensions = [
"         \ 'my_extension',
"         \ 'my_other_extension',
"         \ ]

" Load guard
if ( exists('g:loaded_ctrlp_git_branch') && (! exists('g:ctrlp_git#debug') ) )
  \ || v:version < 700 || &cp
  finish
endif
let g:loaded_ctrlp_git_branch = 1


" Add this extension's settings to g:ctrlp_ext_vars
"
" Required:
"
" + init: the name of the input function including the brackets and any
"         arguments
"
" + accept: the name of the action function (only the name)
"
" + lname & sname: the long and short names to use for the statusline
"
" + type: the matching type
"   - line : match full line
"   - path : match full line like a file or a directory path
"   - tabs : match until first tab character
"   - tabe : match until last tab character
"
" Optional:
"
" + enter: the name of the function to be called before starting ctrlp
"
" + exit: the name of the function to be called after closing ctrlp
"
" + opts: the name of the option handling function called when initialize
"
" + sort: disable sorting (enabled by default when omitted)
"
" + specinput: enable special inputs '..' and '@cd' (disabled by default)
"
call add(g:ctrlp_ext_vars, {
\ 'init': 'ctrlp#git_branch#init()',
\ 'accept': 'ctrlp#git_branch#accept',
\ 'lname': 'git_branch',
\ 'sname': 'branch',
\ 'type': 'line',
\ 'enter': 'ctrlp#git_branch#enter()',
\ 'exit': 'ctrlp#git_branch#exit()',
\ 'opts': 'ctrlp#git_branch#opts()',
\ 'sort': 0,
\ 'specinput': 0,
\})

" Vital
let s:V = vital#ctrlp_git#new()
let s:Process = s:V.import('System.Process')


" Provide a list of strings to search in
"
" Return: a Vim's List
"
function! ctrlp#git_branch#init()
  let result = s:Process.execute([
  \ 'git', 'branch', '-a',
  \])
  let branches = uniq(sort(map(split(substitute(result.output, 'remotes/origin/', '', ''), "\n"), 'strpart(v:val, 2)')))
  return branches
endfunction


" The action to perform on the selected string
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
"
function! ctrlp#git_branch#accept(mode, str)
  call ctrlp#exit()
  let result = s:Process.execute([
  \ 'git', 'checkout', a:str,
  \])
  echo result.output
endfunction


" (optional) Do something before enterting ctrlp
function! ctrlp#git_branch#enter()
endfunction


" (optional) Do something after exiting ctrlp
function! ctrlp#git_branch#exit()
endfunction


" (optional) Set or check for user options specific to this extension
function! ctrlp#git_branch#opts()
endfunction


" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

" Allow it to be called later
function! ctrlp#git_branch#id()
  return s:id
endfunction

