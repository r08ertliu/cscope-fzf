# cscope-fzf
Integrate cscope with fzf in vim.

## What cscope-fzf is
Performs cscope queries against
- Native cscope database
  - cscope.out
- With cscope_dynamic
  - .cscope.big
  - .cscope.small

Uses fzf-vim to display results and previews.
![vim-cscope-fzf-preview](https://user-images.githubusercontent.com/15187947/153445493-4229f42c-84a8-4e34-8558-c54211d45019.png)

## Installation

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'r08ertliu/cscope-fzf'
```

## Dependencies

### Must have
[fzf.vim](https://github.com/junegunn/fzf.vim): Things you can do with fzf and Vim.

### Optional
[cscope_dynamic](https://github.com/erig0/cscope_dynamic): Enables very fast automatic cscope database updates with two database; a large one, and
a small one


## Usage

### Key maps
```vim
nnoremap <silent> <Leader>cg :call CscopeFZF("g", 0, "<C-R>=expand('<cword>')<CR>")<CR>
nnoremap <silent> <Leader>cc :call CscopeFZF("c", 0, "<C-R>=expand('<cword>')<CR>")<CR>
nnoremap <silent> <Leader>cf :call CscopeFZF("f", 0, "<C-R>=expand('<cfile>')<CR>")<CR>
nnoremap <silent> <Leader>cs :call CscopeFZF("s", 0, "<C-R>=expand('<cword>')<CR>")<CR>
nnoremap <silent> <Leader>ct :call CscopeFZF("t", 0, "<C-R>=expand('<cword>')<CR>")<CR>

nnoremap <Leader>cG :CsFZFGlobal<SPACE>
nnoremap <Leader>cC :CsFZFCaller<SPACE>
nnoremap <Leader>cF :CsFZFFile<SPACE>
nnoremap <Leader>cT :CsFZFText<SPACE>
nnoremap <Leader>cS :CsFZFSymbol<SPACE>
```

### Commands
| Command                   | Description                                    |
| ---                       | ---                                            |
| `:CsFZFAssign [SYMBOL]`   | Find assignments to this symbol                |
| `:CsFZFCaller [FUNCTION]` | Find functions calling this function           |
| `:CsFZFCallee [FUNCTION]` | Find functions called by this function         |
| `:CsFZFEgrep [PATTERN]`   | Find this egrep pattern                        |
| `:CsFZFFile [FILE]`       | Find this file                                 |
| `:CsFZFGlobal [SYMBOL]`   | Find this definition                           |
| `:CsFZFInc [FILE]`        | Find files #including this file                |
| `:CsFZFSymbol [SYMBOL]`   | Find this C symbol                             |
| `:CsFZFText [TEXT]`       | Find this text string                          |

Add `!` right behind the command would trigger full screen preview
