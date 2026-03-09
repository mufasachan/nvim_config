return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  version = "1.*",
  opts = {
    -- mason tinymist
    dependencies_bin = { tinymist = "tinymist" },
    -- else no open window opens :( + mute output
    open_cmd = "firefox --new-window %s 2>&1 > /dev/null",
    debug = true,
  },
}
