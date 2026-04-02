## Neovim config

My personal neovim configuration.

### Actually readme

The configuration is highly customized and have some assumptions on how to use neovim and what binaries should be accessible. This section aims to document this.

#### Terminal specs

I use kitty for image rendering in general and I can use `<Enter>` with modifier because of the kitty protocol. So if kitty is not used, related configurations might break.

#### markdown experience

**Note**: this section does not include code execution capabilities, [see next section](#notebook-support-with-molten.nvim).

Basically `render-markdown` plugin does all the job. Re

- `image.nvim` requires a support terminal protocol. I use `kitty`, change the `backend` options in `render-markdown` according to your setup.
  - **Note**: it works kind of. I do not know if it's a problem with my setup but using tmux messes up the image rendering when I use other windows than the first. I correctly configured the 3 options in the documentation. Also tried folke's `snacks` image plugin and the result is the same with tmux.
    - this impacts figure rendering in notebook.
- latex rendering with [`libtexprintf/utftex`](https://github.com/bartp5/libtexprintf)
  - grabs latest release
  - `./configure --prefix=$HOME/.local` and `make`, `make check`, `make install`.
- mermaid support *not included*, would need `3rd/diagram.nvim`.

#### notebook support with `molten.nvim`

I will try to condense the **mess** of notebook setup on neovim using molten. Here my fast breakdown with my own words of the roles of different programs and plugins. `molten` uses the `quatro` capabilities (binary+plugin, not the file format `.qmd`) to run code in documents. It uses the `markdown` format, therefore `quatro` leverages `otter.nvim` to run execution in code cell. In order to use these `markdown` code execution on notebook, the program `jupytext` seamlessly transfers notebook <=> markdown content. `molten`, which manages mainly the connection to ipython kernel, adds necessary glue between these elements to provide a top notch experience e.g. notebook output import, auto kernel init. Read documentation [1](https://github.com/benlubas/molten-nvim/blob/main/docs/Not-So-Quick-Start-Guide.md) [2](https://github.com/benlubas/molten-nvim/blob/main/docs/Notebook-Setup.md)  for more information. 

- Python dependencies for notebook support:
    - in current dev env: 
        - run `uv add --dev ipykernel`
        - makes project's kernel visible for remote plugin `jupyter_client`: `python -m ipykernel install --user --name my_project`
    - in a venv for molten's remote plugin dependencies
        - ```bash
            uv venv ~/.local/share/nvim/nvim-python --python 3.12
            uv pip install \
                --python $HOME/.local/share/nvim/nvim-python/bin/python \
            pynvim jupyter_client cairosvg pnglatex plotly kaleido pyperclip nbformat
            ```
- [quarto](https://quarto.org/) should be in your $PATH.

- Troubleshooting
   - **Symptom**: molten's command are not accessible. **Cause**: If for any reason at installation time the molten python dependencies are not met, the lazy `build` will silently fail (`:UpdateRemotePlugin`). You should run the command by yourself and see whether it succeed or not.

 
#### Binaries that should be in your path

- `make`
- `fd`: `fzf-lua` uses it
- `lazygit`: The mapping `<Leader>L` is **for** lazygit.
- For markdown (without code execution)
- `quarto`: [see notebook section](#notebook-support-with-molten.nvim)
- `jupytext`: `uv tool install jupytext`

#### Overridding default neovim defaults

- see [options.lua](./lua/user/options.lua) for the set of options in use. Some important options are:
    * **!!** `exrc` is ON
    * `number` and `relativenumber` FTW
    * mouse disable (so the pad is not getting in the way)
    * search `/` with `ignorecase` and `smartcase`
    * `wrap` is on 
    * indent options: 
    * `helpheight=42`
- `[i` and so on: it goes to the conditional, not the definition of a term. See `:h include-search` for more details. 

### Missing features

Those features would make this configuration covers all my needs.

- [ ] Python notebook
- [ ] Runner
- [ ] Document the workflow

### About neovide

> **TL;DR** It has been year since I've used this.

I have been using GPU accelerated terminal and tmux as my main workflow for a year now. Then, I did not use neovide as GUI. But, I feel that I am orienting my workflow towards tabs a lot for managing multiple things (lazygit, my terminal, future DAP?, future runner?). If the workflow matures such that I do not need tmux (or any other compositor/WM), then I would resume using neovide.

**Update 27/02**: Maybe I will actually resume to it if it has a more stable support for the notebook usage I have. I should investigate image.nvim support.
