return {
  {
    "L3MON4D3/LuaSnip",
    -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    version = "v2.*",
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
  { "rafamadriz/friendly-snippets" },
}
