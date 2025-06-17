## Neovim config

My personal neovim configuration.

### Actually readme

The configuration is highly customized and have some assumptions on how to use neovim and what binaries should be accessible. This section aims to document this.

#### Binaries that should be in your path

- `make`
- `fd`: telescope uses it
- `yarn`: needed for the build of `iamcco/markdown-preview.nvim`.
- `lazygit`: The mapping `<Leader>L` is **for** lazygit.

#### Overridding default neovim defaults

- see [options.lua](./lua/user/options.lua) for the set of options in use. Some important options are:
    * **!!** `exrc` is ON
    * `number` and `relativenumber` FTW
    * mouse disable (so the pad is not getting in the way)
    * search `/` with `ignorecase` and `smartcase`
    * `wrap` is on 
    * indent options: 
    * `cmdheight=0` and `helpheight=42`
- `[i` and so on: it goes to the conditional, not the definition of a term. See `:h include-search` for more details. 

### Missing features

Those features would make this configuration covers all my needs.

- [ ] Python notebook
- [ ] DAP
- [ ] Runner
- [ ] Document the workflow

### About neovide

> **TL;DR** It has been year since I've used this.

I have been using GPU accelerated terminal and tmux as my main workflow for a year now. Then, I did not use neovide as GUI. But, I feel that I am orienting my workflow towards tabs a lot for managing multiple things (lazygit, my terminal, future DAP?, future runner?). If the workflow matures such that I do not need tmux (or any other compositor/WM), then I would resume using neovide.
