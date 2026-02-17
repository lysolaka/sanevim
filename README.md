# SaneVim
This repository is meant to be my personalised Neovim config. I've put it as public so others might learn from it.

## Why "SaneVim"
A lot of ready neovim configs have "Vim" appended to their names like "LazyVim" or "LunarVim". The "Sane" part is because I almost lost my sanity doing it from scratch, but also because the contents of this config are pretty reasonable: not much bloat, good looking and simple scripts (I'm pedantic).

# TODOs

This config is suitable for daily use, but there is still some work to be done. Mainly:
- [x] Setup `texlab` with `tex-fmt` as the formatter, remove `vimtex`.
- [x] Make highlight groups from `tree-sitter-comment` of higher priority than LSP. Now the LSP overrides the special highlighting of TODO or FIXME comments.
- [x] Use `ruff` for Python formatting.
- [ ] Write snippets for `LuaSnip`. In the past there were some snippets, but they are no longer useful to me. I will get to it on a case by case basis: if I find a need for a new snippet - I will make one.

Other TODOs are:
- [ ] Properly comment all files and explain what's going on.
- [ ] Present features and looks of this neovim config.
- [ ] Do a plugin list.
