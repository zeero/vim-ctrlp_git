" =============================================================================
" File:          autoload/ctrlp/git_log.vim
" Description:   CtrlP Extension for git log.
" =============================================================================

" To load this extension into ctrlp, add this to your vimrc:
"
"     let g:ctrlp_extensions = ['git_log']
"
" Where 'git_log' is the name of the file 'git_log.vim'
"
" For multiple extensions:
"
"     let g:ctrlp_extensions = [
"         \ 'my_extension',
"         \ 'my_other_extension',
"         \ ]

" Load guard
if ( exists('g:loaded_ctrlp_git_log') && (! exists('g:ctrlp_git#debug') ) )
  \ || v:version < 700 || &cp
  finish
endif
let g:loaded_ctrlp_git_log = 1


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
\ 'init': 'ctrlp#git_log#init()',
\ 'accept': 'ctrlp#git_log#accept',
\ 'lname': 'git_log',
\ 'sname': 'log',
\ 'type': 'line',
\ 'enter': 'ctrlp#git_log#enter()',
\ 'exit': 'ctrlp#git_log#exit()',
\ 'opts': 'ctrlp#git_log#opts()',
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
function! ctrlp#git_log#init()
  let padding = &columns - 50
  let result = s:Process.execute([
  \ 'git', 'log', '-100', '--date=format:%Y/%m/%d %H:%M:%S', "--pretty=format:%h\t%<(" . padding . ',trunc)%s%<(16,trunc)%an%cd',
  \])
  let logs = split(result.output, "\n")

  " highlight
  call ctrlp#hicheck('CtrlPGitLogHash', 'Identifier')
  syn match CtrlPGitLogHash / [a-z0-9]\{7}\t/

  return logs
endfunction


" The action to perform on the selected string
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
"
function! ctrlp#git_log#accept(mode, str)
  call ctrlp#exit()
  let hash = strpart(a:str, 0, 7)
  let result = s:Process.execute([
  \ 'git', 'show', hash,
  \])
  echo result.output
endfunction


" (optional) Do something before enterting ctrlp
function! ctrlp#git_log#enter()
endfunction


" (optional) Do something after exiting ctrlp
function! ctrlp#git_log#exit()
endfunction


" (optional) Set or check for user options specific to this extension
function! ctrlp#git_log#opts()
endfunction


" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

" Allow it to be called later
function! ctrlp#git_log#id()
  return s:id
endfunction

