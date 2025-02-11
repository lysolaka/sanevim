# SaneVim
This repository is meant to be my personalised neovim config. I've put it as public so others might learn from it.

## Why "SaneVim"
A lot of ready neovim configs have "Vim" appended to their names like "LazyVim" or "LunarVim". The "Sane" part is because I almost lost my sanity doing it from scratch, but also because the contents of this config are pretty reasonable: not much bloat, good looks (I'm pedantic) and simplicity.

## TODOs
- Comment all the files for others to read and learn
- Do a list of plugins

# General overview
All the config files are contained inside the `lua` directory. The config is split into two parts: plugins and their configuration. The `plugins` directory contains plugin specs used by `lazy.nvim`. The `config` directory is used to configure those plugins and supply the `opts` parameter for the plugin specs.

Anathomy of the `config` directory:
- `keybinds`:
  * `keybinds.lua`: define LSP on-attach keybinds, rest is defined in plugins' specs or opts
  * `init.lua`: apply those keybinds
- `lsp`:
  * `init.lua`: apply LSP server configurations
  * `<lang_name>.lua`: supply the aforementioned configuration, if the server name is not present, the server will use the defaults from `nvim-lspconfig`
- `plugins`: each file contains opts to be required by the corresponding file name in the `plugins` directory
- `lazy.lua`: bootstrap `lazy.nvim`, set neovim options
- `ui.lua`: configure visual builtins like diagnostics or highlight groups

Anathomy of the `plugins` directory:
- `completion.lua`: `nvim_cmp` and friends
- `lsp.lua`: LSP support
- `tex.lua`: might be renamed to `lang.lua` in the future, currently used only for `vimtex`, but might be used for other language or filetype specific plugins
- `treesitter.lua`: `nvim-treesitter`
- `ui.lua`: all the visual plugins
