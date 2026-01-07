-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "gotmpl",
      "json",
      "jsonc",
      "php",
      "javascript",
      "vue",
      "typescript",
      "css",
      "html",
      "http",
      "yaml",
      "xml",
      "dockerfile",
      "bash",
      "markdown",
      "markdown_inline",
      "toml",
    },
  },
}
