-- Customize Treesitter

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    highlight = true, -- enable/disable treesitter based highlighting
    indent = true, -- enable/disable treesitter based indentation
    auto_install = true, -- enable/disable automatic installation of detected languages
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
