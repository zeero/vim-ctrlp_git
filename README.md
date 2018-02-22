# vim-ctrlp_git
CtrlP Extension for git branch and log.

## Install
Install with package manager.

[dein.vim](https://github.com/Shougo/dein.vim):
```dein.toml
[[plugin]]
repo = 'zeero/vim-ctrlp_git'
depends = ['ctrlp.vim']
lazy = 1
on_cmd = ['CtrlPGit']
```

## Usage

### Git Branch
```
:CtrlPGitBranch
```

If may add keymap into your vimrc like below:
```
nnoremap <leader>t :<C-u>CtrlPGitBranch<CR>
```

### Git Log
```
:CtrlPGitLog
```

If may add keymap into your vimrc like below:
```
nnoremap <leader>t :<C-u>CtrlPGitLog<CR>
```

