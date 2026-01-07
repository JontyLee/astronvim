return {
  "Saghen/blink.cmp",
  opts = {
    cmdline = {
      keymap = {
        ["<Tab>"] = { "show_and_insert", "select_next" },
        ["<S-Tab>"] = { "show_and_insert", "select_prev" },
        ["<CR>"] = { "accept_and_enter", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
      },
      completion = {
        menu = {
          auto_show = function(_) return vim.fn.getcmdtype() == ":" or vim.fn.getcmdtype() == "@" end,
        },
        list = {
          selection = {
            preselect = false,
          },
        },
      },
    },
  },
}
