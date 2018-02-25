" =============================================================================
" File:          autoload/ctrlp/git_status.vim
" Description:   CtrlP Extension for git status.
" =============================================================================

" To load this extension into ctrlp, add this to your vimrc:
"
"     let g:ctrlp_extensions = ['git_status']
"
" Where 'git_status' is the name of the file 'git_status.vim'
"
" For multiple extensions:
"
"     let g:ctrlp_extensions = [
"         \ 'my_extension',
"         \ 'my_other_extension',
"         \ ]

" Load guard
if ( exists('g:loaded_ctrlp_git_status') && (! exists('g:ctrlp_git#debug') ) )
  \ || v:version < 700 || &cp
  finish
endif
let g:loaded_ctrlp_git_status = 1


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
\ 'init': 'ctrlp#git_status#init()',
\ 'accept': 'ctrlp#git_status#accept',
\ 'lname': 'git_status',
\ 'sname': 'status',
\ 'type': 'line',
\ 'enter': 'ctrlp#git_status#enter()',
\ 'exit': 'ctrlp#git_status#exit()',
\ 'opts': 'ctrlp#git_status#opts()',
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
function! ctrlp#git_status#init()
  let padding = &columns - 50
  let result = s:Process.execute([
  \ 'git', 'status', '--porcelain',
  \])
  let inputs = split(result.output, "\n")
  let inputs = map(inputs, 'strpart(v:val, 0, 2) . "\t" . strpart(v:val, 3)')

  " highlight
  hi CtrlPGitStatusModified         guifg=Blue
  hi CtrlPGitStatusModifiedIndexed  guibg=Blue guifg=White
  hi CtrlPGitStatusUntracked        guifg=Cyan
  hi CtrlPGitStatusUntrackedIndexed guibg=Cyan guifg=Black
  syn match CtrlPGitStatusModified         /.M\t.*/
  syn match CtrlPGitStatusModifiedIndexed  /M.\t.*/
  syn match CtrlPGitStatusUntracked        /??\t.*/
  syn match CtrlPGitStatusUntrackedIndexed /A.\t.*/

  return inputs
endfunction


" The action to perform on the selected string
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
"
function! ctrlp#git_status#accept(mode, str)
  call ctrlp#exit()

  let commands = ['git']
  let status = strpart(a:str, 0, 2)
  let filename = strpart(a:str, 3)

  if(status =~# '.M\|??')
    call add(commands, 'add')
  elseif(status =~# 'M.\|A.')
    call add(commands, 'reset')
    call add(commands, 'HEAD')
  endif
  if(len(commands) < 2)
    echoerr "CtrlPGitStatus[ERROR]: can't handle status '" . status . "' properly."
    return
  endif
  call add(commands, filename)
  let result = s:Process.execute(commands)
  if(result.status != 0)
    echoerr result.output
    return
  endif

  call ctrlp#init(ctrlp#git_status#id())
endfunction


" (optional) Do something before enterting ctrlp
function! ctrlp#git_status#enter()
endfunction


" (optional) Do something after exiting ctrlp
function! ctrlp#git_status#exit()
endfunction


" (optional) Set or check for user options specific to this extension
function! ctrlp#git_status#opts()
endfunction


" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

" Allow it to be called later
function! ctrlp#git_status#id()
  return s:id
endfunction

