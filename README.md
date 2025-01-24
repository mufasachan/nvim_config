## Neovim config

My personal neovim configuration.

### LSP setup

Arguably, my setup is (too) complicated. Specifically, `mason-lspconfig` have their `handlers` to keep solid default configurations while keeping manual configurations possible. But, it would mean to have plugin setup *and* LSP configurations in the same place; I do not like this.

Thus, the `plugins` remain, as far as I can, the location where plugins are configured. LSP, and other dev tools, should be configured else where, after the plugin init, namely in `lua/after/lsp`. `others.lua` setup default `lsp_config` and other files set up LSP manually.

