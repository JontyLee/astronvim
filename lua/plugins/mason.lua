-- Customize Mason plugins

---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- bash
        "bash-language-server",
        "shfmt",
        -- docker
        "docker-compose-language-service",
        "dockerfile-language-server",
        -- go
        -- "gopls",
        "delve",
        -- "gofumpt",
        -- "goimports-reviser",
        -- html/css/js/ts/vue
        "html-lsp",
        "css-lsp",
        "emmet-ls",
        "eslint_d",
        "typescript-language-server",
        "vetur-vls",
        -- "vue-language-server",
        -- json
        "json-lsp",
        -- lua
        "lua-language-server",
        "stylua",
        "selene",
        -- markdown
        "marksman",
        -- php
        "intelephense",
        "php-cs-fixer",
        -- python
        "pyright",
        "black",
        -- toml
        "taplo",
        -- yaml
        "yaml-language-server",
        -- xml
        "lemminx",

        -- common
        "prettierd",
      },
    },
  },
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
  {
    "nvimtools/none-ls.nvim",
    opts = {
      default_timeout = -1,
      diagnostics_format = "[#{c}] #{m} (#{s})",
      notify_format = "[null-ls] %s",
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "nvimtools/none-ls.nvim",
      "nvimtools/none-ls-extras.nvim",
    },
    opts = function(_, opts)
      local null_ls = require "null-ls"
      opts.handlers = {
        eslint_d = function()
          null_ls.register(require("none-ls.code_actions.eslint_d").with {
            condition = function(utils) return utils.root_has_file ".eslintrc.js" end,
          })
          null_ls.register(require("none-ls.formatting.eslint_d").with {
            condition = function(utils) return utils.root_has_file ".eslintrc.js" end,
          })
          null_ls.register(require("none-ls.diagnostics.eslint_d").with {
            condition = function(utils) return utils.root_has_file ".eslintrc.js" end,
          })
        end,
        -- goimports_reviser = function()
        --   local go_args = function()
        --     local args = { "-rm-unused", "$FILENAME" }
        --     if vim.fn.executable "go" ~= 1 then return args end
        --     local module = vim.fn.trim(vim.fn.system "go list -m")
        --     if module == "" then return args end
        --     module = module:gsub("\n", "")
        --     if module == "" then return args end
        --     return { "-rm-unused", "-project-name", module, "$FILENAME" }
        --   end
        --   null_ls.register(null_ls.builtins.formatting.goimports_reviser.with {
        --     -- condition = function(_)
        --     --   local clients = vim.lsp.get_clients { name = "gopls" }
        --     --   return #clients > 0
        --     -- end,
        --     args = go_args(),
        --   })
        -- end,
        phpcsfixer = function()
          null_ls.register(null_ls.builtins.formatting.phpcsfixer.with {
            args = {
              "--config=" .. vim.fn.stdpath "config" .. "/php-cs-fixer.php",
              "--no-interaction",
              "--quiet",
              "fix",
              "$FILENAME",
            },
          })
        end,
        prettierd = function()
          null_ls.register(null_ls.builtins.formatting.prettierd.with {
            condition = function(utils)
              return utils.root_has_file ".prettierrc"
                or utils.root_has_file ".prettierrc.json"
                or utils.root_has_file ".prettierrc.js"
            end,
          })
        end,
      }
    end,
  },
}
