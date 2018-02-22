This is template for CtrlP Extension.
Filenames and descriptions in template can be replaced with rake.
```
rake name=your_extension_name
```
Below is README template.

---
# vim-ctrlp_template
CtrlP Extension for template.

## Install
Install with package manager.

[dein.vim](https://github.com/Shougo/dein.vim):
```dein.toml
[[plugin]]
repo = 'zeero/vim-ctrlp_template'
depends = ['ctrlp.vim']
lazy = 1
on_cmd = ['CtrlPTemplate']
```

## Usage
```
:CtrlPTemplate
```

If may add keymap into your vimrc like below:
```
nnoremap <leader>t :<C-u>CtrlPTemplate<CR>
```

