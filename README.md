This is git for CtrlP Extension.
Filenames and descriptions in git can be replaced with rake.
```
rake name=your_extension_name
```
Below is README git.

---
# vim-ctrlp_git
CtrlP Extension for git.

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
```
:CtrlPGit
```

If may add keymap into your vimrc like below:
```
nnoremap <leader>t :<C-u>CtrlPGit<CR>
```

