-- Customize Mason plugins

---@type LazySpec
return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ui = {
        icons = {
          package_pending = " ",
          package_installed = "󰄳 ",
          package_uninstalled = " 󰚌",
        },
      }
    end,
  },
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "lua_ls",
        "gopls",
        "intelephense",
        "bashls",
        "eslint",
        "tsserver",
        "volar",
        "html",
        "cssls",
        "emmet_ls",
        "docker_compose_language_service",
        "dockerls",
        "jsonls",
        "marksman",
        "pyright",
        "ruff_lsp",
        "yamlls",
        "lemminx",
      })
      opts.automatic_installation = true
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        -- lua,
        "stylua",
        "selene",

        -- go
        "goimports-reviser",
        "gomodifytags",
        "impl",
        "json-to-struct",
        "iferr",

        -- php
        "php-cs-fixer",

        -- sh
        "shfmt",

        -- python
        "black",

        -- sql
        "sqlflull",

        -- common
        "refactoring",
        "prettierd",
      })
      opts.handlers = nil
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "python",
        "delve",
        -- add more arguments for adding more debuggers
      })
    end,
  },
}
