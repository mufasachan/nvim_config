# Requirements for the configuration

The configuration has a lot of plugins and some require some third-party tools in order to work.

- `neorg` Image rendering
    - You need a terminal emulator with a image rendering backend, [see the documentation](https://github.com/3rd/image.nvim?tab=readme-ov-file#rendering-backend).
    - See [3rd/image](https://github.com/3rd/image.nvim?tab=readme-ov-file#imagemagick) install notes for your system. It is necessary to render image and LaTeX in neorg.
- `neovide.lua` for GUI client
    - I do not use it anymore. The module does not bring any conflict.
- `telescope` needs `fd` as a finder, see the concise [installation section](https://github.com/sharkdp/fd?tab=readme-ov-file#installation) of the project. The fuzzy search is done by a nvim plugin.
