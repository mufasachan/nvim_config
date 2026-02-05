-- Bootstrap lazy.nvim
local root = vim.fn.stdpath("data") .. "/lazy-pager"
local lazypath = root .. "/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  root = root,
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock-pager.json",
  state = vim.fn.stdpath("state") .. "/lazy-pager/state.json",
  spec = {
    { "EdenEast/nightfox.nvim" },
  },
})

vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd.colorscheme("carbonfox")

vim.o.number = false
vim.o.relativenumber = false
vim.o.signcolumn = "no"
vim.o.laststatus = 0
vim.keymap.set("n", "q", "<CMD>q<CR>")
