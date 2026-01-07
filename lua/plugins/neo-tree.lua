return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.filesystem.filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = false,
      hide_by_name = {
        "node_modules",
        ".DS_Store",
        ".git",
        ".github",
      },
    }
    opts.sources = {
      "filesystem",
    }
    opts.window.width = 50
  end,
}
