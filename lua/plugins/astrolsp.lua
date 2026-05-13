-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = true, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
      signature_help = true,
    },
    -- customize lsp formatting options
    formatting = {
      disabled = { -- disable formatting capabilities for the listed language servers
        "lua_ls",
        "intelephense",
      },
      timeout_ms = 3200, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "gopls",
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- lua_ls = {
      --   settings = {
      --     Lua = {
      --       format = {
      --         enable = false,
      --       },
      --       codeLens = {
      --         enable = true,
      --       },
      --       completion = {
      --         enable = true,
      --         autoRequire = true,
      --         callSnippet = "Both",
      --         displayContext = 5,
      --         keywordSnippet = "Both",
      --         postfix = "@",
      --         showParams = true,
      --         showWord = "Fallback",
      --         workspaceWord = true,
      --       },
      --       diagnostics = {
      --         enable = false,
      --       },
      --       hint = {
      --         enable = true,
      --         await = true,
      --         arrayIndex = "Auto",
      --         paramName = "All",
      --         paramType = true,
      --         semicolon = "SameLine",
      --         setType = false,
      --       },
      --       workspace = {
      --         ignoreDir = {
      --           ".vscode",
      --           ".git",
      --         },
      --         ignoreSubmodules = true,
      --         useGitIgnore = true,
      --       },
      --     },
      --   },
      -- },
      -- marksman = {
      --   -- autostart = marksmanEnable(),
      --   enable = marksmanEnable(),
      -- },
      -- volar = {
      --   init_options = {
      --     vue = {
      --       hybridMode = false,
      --     },
      --   },
      --   settings = {
      --     vue = {
      --       inlayHints = {
      --         inlineHandlerLeading = true,
      --         missingProps = true,
      --         optionsWrapper = true,
      --         destructuredProps = true,
      --         vBindShorthand = true,
      --       },
      --       codeActions = {
      --         enabled = true,
      --       },
      --       doctor = {
      --         status = true,
      --       },
      --       codeLens = {
      --         enabled = true,
      --       },
      --       autoInsert = {
      --         bracketSpacing = true,
      --         dotValue = true,
      --         parentheses = true,
      --       },
      --       updateImportsOnFileMove = {
      --         enabled = true,
      --       },
      --       server = {
      --         fullCompletionList = true,
      --         petiteVue = {
      --           supportHtmlFile = true,
      --         },
      --       },
      --       format = {
      --         template = {
      --           initialIndent = false,
      --         },
      --         style = {
      --           initialIndent = false,
      --         },
      --         script = {
      --           initialIndent = false,
      --         },
      --         wrapAttributes = "auto",
      --       },
      --     },
      --   },
      -- },
      -- ts_ls = {
      --   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
      --   settings = {
      --     typescript = {
      --       tsdk = tsdk_path,
      --       format = { enable = false },
      --       autoClosingTags = true,
      --       suggest = {
      --         enabled = true,
      --         paths = true,
      --         autoImports = true,
      --         completeFunctionCalls = true,
      --         classMemberSnippets = {
      --           enabled = true,
      --         },
      --         completeJSDocs = true,
      --         jsdoc = {
      --           generateReturns = true,
      --         },
      --         objectLiteralMethodSnippets = {
      --           enabled = true,
      --         },
      --         includeCompletionsForImportStatements = true,
      --         includeAutomaticOptionalChainCompletions = true,
      --       },
      --       suggestionActions = {
      --         enabled = true,
      --       },
      --       surveys = {
      --         enabled = false,
      --       },
      --       validate = {
      --         enable = true,
      --       },
      --       referencesCodeLens = {
      --         enabled = true,
      --       },
      --       implementationsCodeLens = {
      --         enabled = true,
      --       },
      --       tsserver = {
      --         useSeparateSyntaxServer = true,
      --       },
      --       inlayHints = {
      --         enumMemberValues = {
      --           enabled = true,
      --         },
      --         functionLikeReturnTypes = {
      --           enabled = true,
      --         },
      --         parameterNames = {
      --           enabled = "all",
      --           suppressWhenArgumentMatchesName = true,
      --         },
      --         parameterTypes = {
      --           enabled = true,
      --         },
      --         propertyDeclarationTypes = {
      --           enabled = true,
      --         },
      --         variableTypes = {
      --           enabled = true,
      --           suppressWhenTypeMatchesName = true,
      --         },
      --       },
      --       updateImportsOnFileMove = {
      --         enabled = "prompt",
      --       },
      --     },
      --     javascript = {
      --       suggest = {
      --         autoImports = true,
      --         classMemberSnippets = {
      --           enabled = true,
      --         },
      --         enabled = true,
      --         completeJSDocs = true,
      --         completeFunctionCalls = true,
      --         jsdoc = {
      --           generateReturns = true,
      --         },
      --         includeCompletionsForImportStatements = true,
      --         includeAutomaticOptionalChainCompletions = true,
      --         paths = true,
      --         names = true,
      --       },
      --       suggestionActions = {
      --         enabled = true,
      --       },
      --       autoClosingTags = true,
      --       validate = {
      --         enable = true,
      --       },
      --       updateImportsOnFileMove = {
      --         enabled = "prompt",
      --       },
      --       inlayHints = {
      --         functionLikeReturnTypes = {
      --           enabled = true,
      --         },
      --         parameterNames = {
      --           enabled = "all",
      --           suppressWhenArgumentMatchesName = true,
      --         },
      --         parameterTypes = {
      --           enabled = true,
      --         },
      --         enumMemberValues = {
      --           enabled = true,
      --         },
      --         propertyDeclarationTypes = {
      --           enabled = true,
      --         },
      --         variableTypes = {
      --           enabled = true,
      --           suppressWhenTypeMatchesName = true,
      --         },
      --       },
      --     },
      --   },
      -- },
      -- yamlls = {
      --   settings = {
      --     redhat = {
      --       telemetry = {
      --         enabled = false,
      --       },
      --     },
      --     yaml = {
      --       completion = true,
      --       disableAdditionalProperties = true,
      --       format = {
      --         bracketSpacing = true,
      --         enable = true,
      --         printWidth = 2000,
      --         proseWrap = "never",
      --         singleQuote = true,
      --       },
      --       hover = true,
      --       maxItemsComputed = 5000,
      --       validate = true,
      --     },
      --   },
      -- },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed

      -- 修复 lemminx 返回 null 导致的崩溃
      lemminx = function(_, opts)
        opts = opts or {}
        local original_handler = vim.lsp.handlers["textDocument/codeAction"]
        opts.handlers = opts.handlers or {}
        opts.handlers["textDocument/codeAction"] = function(err, result, ctx, config)
          if result == nil then result = {} end
          if original_handler then
            original_handler(err, result, ctx, config)
          else
            vim.lsp.handlers["textDocument/codeAction"](err, result, ctx, config)
          end
        end
        -- 直接修改 opts 即可，AstroNvim 会负责调用 setup
      end,
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_codelens_refresh = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/codeLens",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "InsertLeave", "BufEnter" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.enable(true, { bufnr = args.buf }) end
          end,
        },
      },
      lsp_auto_format = {
        cond = function(client, _)
          local formatting_disabled = vim.tbl_get(require("astrolsp").config, "formatting", "disabled")
          return formatting_disabled ~= true
            and client:supports_method "textDocument/formatting"
            and not vim.tbl_contains(formatting_disabled, client.name)
        end,
        {
          event = "BufWritePre",
          desc = "Autoformat on save",
          callback = function(_, _, bufnr)
            if vim.bo[bufnr].filetype == "go" and #vim.lsp.get_clients { name = "gopls" } >= 1 then
              local params = vim.lsp.util.make_range_params(0, "utf-16")
              params.context = { only = { "source.organizeImports" } }
              -- buf_request_sync defaults to a 1000ms timeout. Depending on your
              -- machine and codebase, you may want longer. Add an additional
              -- argument after params if you find that you have to write the file
              -- twice for changes to be saved.
              -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
              local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 5000)
              for cid, res in pairs(result or {}) do
                for _, r in pairs(res.result or {}) do
                  if r.edit then
                    local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                    vim.lsp.util.apply_workspace_edit(r.edit, enc)
                  end
                end
              end
            end
            local astrolsp = require "astrolsp"
            local autoformat = assert(astrolsp.config.formatting.format_on_save)
            local buffer_autoformat = vim.b[bufnr].autoformat
            if buffer_autoformat == nil then buffer_autoformat = autoformat.enabled end
            if buffer_autoformat and ((not autoformat.filter) or autoformat.filter(bufnr)) then
              vim.lsp.buf.format(vim.tbl_deep_extend("force", astrolsp.format_opts, { bufnr = bufnr }))
            end
          end,
        },
      },
      lsp_go_tidy_on_save = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        cond = function(_, bufnr) return vim.bo[bufnr].filetype == "gomod" end,
        -- list of auto commands to set

        {
          -- events to trigger
          event = "BufWritePost",
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Go mod tidy",
          callback = function() -- 4. 触发回调函数
            -- 提供一个非阻塞的通知，让你知道命令正在运行
            vim.notify('go.mod saved, running "go mod tidy"...', vim.log.levels.INFO, { title = "Go" })

            -- 5. 异步执行 shell 命令，避免冻结编辑器
            vim.fn.jobstart("go mod tidy", {
              on_exit = function(_, code)
                if code == 0 then
                  vim.notify('"go mod tidy" finished successfully.', vim.log.levels.INFO, { title = "Go" })
                else
                  vim.notify('"go mod tidy" failed with code: ' .. code, vim.log.levels.ERROR, { title = "Go" })
                end
                -- 6. 异步执行 :checktime，Neovim会检测到 go.sum 的变动并提示你
                vim.cmd "checktime"
              end,
            })
          end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {},
    },
  },
}
