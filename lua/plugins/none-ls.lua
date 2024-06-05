-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- lua
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.selene,

      -- go
      null_ls.builtins.formatting.goimports_reviser,
      null_ls.builtins.code_actions.gomodifytags,
      null_ls.builtins.code_actions.impl,

      -- php
      null_ls.builtins.formatting.phpcsfixer.with {
        extra_args = {
          "--config=" .. vim.fn.stdpath "config" .. "/php-cs-fixer.php",
        },
      },

      -- sh
      null_ls.builtins.formatting.shfmt,

      -- python
      null_ls.builtins.formatting.black,

      -- common
      null_ls.builtins.code_actions.refactoring.with { filetypes = { "javascript", "lua", "python", "typescript" } },

      null_ls.builtins.formatting.prettierd.with {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "css",
          "scss",
          "less",
          "html",
          "json",
          "jsonc",
          "yaml",
          "markdown",
          "markdown.mdx",
          "graphql",
          "handlebars",
        },
        extra_args = { "--tab-width", "4" },
      },
    }
    config.on_attach = require("astrolsp").on_attach
    config.diagnostics_format = "[#{c}] #{m} (#{s})"
    config.default_timeout = -1
    return config -- return final config table
  end,
}
