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
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        async = true,
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
          -- "vue",
        },
      },
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
      "gopls",
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      gopls = {
        settings = {
          gopls = {
            env = {
              GOOS = "linux",
              GOARCH = "amd64",
            },
            buildFlags = {
              "-tags=unit",
            },
            directoryFilters = {
              "-**node_modules",
              "-.git",
            },
            templateExtensions = { "tmpl" },
            gofumpt = true,
            codelenses = {
              generate = false,
              regenerate_cgo = false,
              run_govulncheck = false,
              test = false,
              tidy = true,
              upgrade_dependency = false,
              vendor = false,
              vulncheck = false,
            },
            analyses = {
              lostcancel = false,
              shadow = true,
            },
            staticcheck = "unset",
            vulncheck = "Off",
            diagnosticsTrigger = "Save",
            hints = {
              assignVariableTypes = false,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            importShortcut = "Definition",
          },
        },
        before_init = function(_, config)
          if vim.fn.executable "go" ~= 1 then return end

          local module = vim.fn.trim(vim.fn.system "go list -m")
          if vim.v.shell_error ~= 0 then return end
          module = module:gsub("\n", ",")

          config.settings.gopls["local"] = module
        end,
      },
      html = {
        filetypes = { "html", "phtml" },
        settings = {
          html = {
            autoClosingTags = true,
            suggest = {
              html5 = true,
            },
            validate = {
              styles = true,
              scripts = true,
            },
            hover = {
              references = true,
              documentation = true,
            },
            format = {
              enable = true,
              indentHandlebars = true,
              indentInnerHtml = true,
              templating = true,
            },
          },
        },
      },
      intelephense = {
        filetypes = { "php", "phtml" },
        settings = {
          intelephense = {
            format = {
              enable = false,
              braces = "k&r",
            },
            telemetry = {
              enabled = false,
            },
            stubs = {
              "aerospike",
              "amqp",
              "apache",
              "apcu",
              "ast",
              "bcmath",
              "blackfire",
              "bz2",
              "calendar",
              "cassandra",
              "com_dotnet",
              "Core",
              "couchbase",
              "couchbase_v2",
              "crypto",
              "ctype",
              "cubrid",
              "curl",
              "date",
              "dba",
              "decimal",
              "dio",
              "dom",
              "ds",
              "eio",
              "elastic_apm",
              "enchant",
              "Ev",
              "event",
              "exif",
              "expect",
              "fann",
              "FFI",
              "ffmpeg",
              "fileinfo",
              "filter",
              "fpm",
              "ftp",
              "gd",
              "gearman",
              "geoip",
              "geos",
              "gettext",
              "gmagick",
              "gmp",
              "gnupg",
              "grpc",
              "hash",
              "http",
              "ibm_db2",
              "iconv",
              "igbinary",
              "imagick",
              "imap",
              "inotify",
              "interbase",
              "intl",
              "json",
              "judy",
              "ldap",
              "leveldb",
              "libevent",
              "libsodium",
              "libvirt-php",
              "libxml",
              "lua",
              "LuaSandbox",
              "lzf",
              "mailparse",
              "mapscript",
              "mbstring",
              "mcrypt",
              "memcache",
              "memcached",
              "meminfo",
              "meta",
              "ming",
              "mongo",
              "mongodb",
              "mosquitto-php",
              "mqseries",
              "msgpack",
              "mssql",
              "mysql",
              "mysql_xdevapi",
              "mysqli",
              "ncurses",
              "newrelic",
              "oauth",
              "oci8",
              "odbc",
              "openssl",
              "opentelemetry",
              "pam",
              "parallel",
              "Parle",
              "pcntl",
              "pcov",
              "pcre",
              "pdflib",
              "PDO",
              "pdo_ibm",
              "pdo_mysql",
              "pdo_pgsql",
              "pdo_sqlite",
              "pgsql",
              "Phar",
              "phpdbg",
              "posix",
              "pq",
              "pspell",
              "pthreads",
              "radius",
              "random",
              "rar",
              "rdkafka",
              "readline",
              "recode",
              "redis",
              "Reflection",
              "regex",
              "relay",
              "rpminfo",
              "rrd",
              "SaxonC",
              "session",
              "shmop",
              "simple_kafka_client",
              "SimpleXML",
              "snappy",
              "snmp",
              "soap",
              "sockets",
              "sodium",
              "solr",
              "SPL",
              "SplType",
              "SQLite",
              "sqlite3",
              "sqlsrv",
              "ssh2",
              "standard",
              "stats",
              "stomp",
              "suhosin",
              "superglobals",
              "svm",
              "svn",
              "swoole",
              "sybase",
              "sync",
              "sysvmsg",
              "sysvsem",
              "sysvshm",
              "tidy",
              "tokenizer",
              "uopz",
              "uploadprogress",
              "uuid",
              "uv",
              "v8js",
              "wddx",
              "win32service",
              "winbinder",
              "wincache",
              "wordpress",
              "xcache",
              "xdebug",
              "xdiff",
              "xhprof",
              "xlswriter",
              "xml",
              "xmlreader",
              "xmlrpc",
              "xmlwriter",
              "xsl",
              "xxtea",
              "yaf",
              "yaml",
              "yar",
              "zend",
              "Zend OPcache",
              "ZendCache",
              "ZendDebugger",
              "ZendUtils",
              "zip",
              "zlib",
              "zmq",
              "zookeeper",
              "zstd",
            },
          },
        },
      },
      lemminx = {
        settings = {
          xml = {
            server = {
              workDir = "~/.cache/lemminx",
            },
            format = {
              splitAttributes = false,
              joinCDATALines = false,
              joinContentLines = false,
              joinCommentLines = false,
              formatComments = false,
              spaceBeforeEmptyCloseTag = false,
            },
            capabilities = {
              formatting = true,
            },
            completion = {
              autoCloseTags = true,
            },
            useCache = false,
            validation = {
              noGrammar = "info",
              schema = true,
            },
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            format = {
              enable = false,
            },
            codeLens = {
              enable = true,
            },
            completion = {
              enable = true,
              autoRequire = true,
              callSnippet = "Both",
              displayContext = 5,
              keywordSnippet = "Both",
              postfix = "@",
              showParams = true,
              showWord = "Fallback",
              workspaceWord = true,
            },
            diagnostics = {
              enable = false,
            },
            hint = {
              enable = true,
              await = true,
              arrayIndex = "Auto",
              paramName = "All",
              paramType = true,
              semicolon = "SameLine",
              setType = false,
            },
            workspace = {
              ignoreDir = {
                ".vscode",
                ".git",
              },
              ignoreSubmodules = true,
              useGitIgnore = true,
            },
          },
        },
      },
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
      vuels = {
        settings = {
          vetur = {
            experimental = {
              templateInterpolationService = true,
            },
            format = {
              options = {
                tabSize = 4,
              },
              defaultFormatter = {
                html = "prettier",
                js = "none",
                ts = "none",
              },
              defaultFormatterOptions = {
                prettier = {
                  singleAttributePerLine = false,
                  tabWidth = 4,
                  printWidth = 10000,
                },
              },
            },
            validation = {
              interpolation = true,
              script = false,
              style = true,
              template = true,
              templateProps = true,
            },
          },
        },
      },
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
      yamlls = {
        settings = {
          redhat = {
            telemetry = {
              enabled = false,
            },
          },
          yaml = {
            completion = true,
            disableAdditionalProperties = true,
            format = {
              bracketSpacing = true,
              enable = true,
              printWidth = 2000,
              proseWrap = "never",
              singleQuote = true,
            },
            hover = true,
            maxItemsComputed = 5000,
            validate = true,
          },
        },
      },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
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
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
      lsp_auto_format = {
        cond = function(client, _)
          local formatting_disabled = vim.tbl_get(require("astrolsp").config, "formatting", "disabled")
          return formatting_disabled ~= true
            and client.supports_method "textDocument/formatting"
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
      n = {
        ["]d"] = {
          "<Cmd>lua require('lspsaga.diagnostic'):goto_prev()<CR>",
          desc = "Diagnostic next",
        },
        ["[d"] = {
          "<Cmd>lua require('lspsaga.diagnostic'):goto_next()<CR>",
          desc = "Diagnostic Previous",
        },
        ["]e"] = {
          "<Cmd>lua require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>",
          desc = "Diagnostic Error Next",
        },
        ["[e"] = {
          "<Cmd>lua require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>",
          desc = "Diagnostic Error Previous",
        },
        ["]w"] = {
          "<Cmd>lua require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.WARN })<CR>",
          desc = "Diagnostic warning Next",
        },
        ["[w"] = {
          "<Cmd>lua require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.WARN })<CR>",
          desc = "Diagnostic warning Previous",
        },
        K = {
          "<Cmd>Lspsaga hover_doc<CR>",
          desc = "Hover symbol",
        },
        ["<Leader>la"] = { "<Cmd>Lspsaga code_action<CR>", desc = "Code action" },
        ["<Leader>lc"] = { "<Cmd>Lspsaga incoming_calls<CR>", desc = "Incoming calls" },
        ["<Leader>lC"] = { "<Cmd>Lspsaga outgoing_calls<CR>", desc = "Outgoing calls" },
        ["<Leader>ld"] = { "<Cmd>Lspsaga show_buf_diagnostics<CR>", desc = "Buffer diagnostics" },
        ["<Leader>lD"] = { "<Cmd>Lspsaga show_workspace_diagnostics<CR>", desc = "Workspace diagnostics" },
        ["<Leader>lg"] = { "<Cmd>Lspsaga goto_definition<CR>", desc = "Goto definition" },
        ["gd"] = { "<Cmd>Lspsaga goto_definition<CR>", desc = "Goto definition" },
        ["gD"] = { function() require("snacks").picker.lsp_declarations() end, desc = "Declaratios" },
        ["<Leader>lG"] = { "<Cmd>Lspsaga goto_type_definition<CR>", desc = "Goto type definition" },
        ["<Leader>li"] = { "<Cmd>Lspsaga finder imp<CR>", desc = "Find implementation" },
        ["<Leader>lI"] = { "<Cmd>LspInfo<CR>", desc = "Lsp info" },
        ["gri"] = { "<Cmd>Lspsaga finder imp<CR>", desc = "Find implementation" },
        ["gy"] = { "<Cmd>Lspsaga goto_type_definition<CR>", desc = "Goto type definition" },
        ["<Leader>lr"] = { "<Cmd>Lspsaga rename mode=n<CR>", desc = "Rename symbol" },
        ["grn"] = { "<Cmd>Lspsaga rename mode=n<CR>", desc = "Rename symbol" },
        ["<Leader>lS"] = { "<Cmd>Lspsaga outline<CR>", desc = "Symbols Outline" },
        ["gO"] = { "<Cmd>Lspsaga outline<CR>", desc = "Symbols Outline" },
        ["<Leader>lp"] = { "<Cmd>Lspsaga peek_definition<CR>", desc = "Peek definition" },
        ["<Leader>lP"] = { "<Cmd>Lspsaga peek_type_definition<CR>", desc = "Peek type definition" },
        ["<Leader>lR"] = { "<Cmd>Lspsaga finder ref<CR>", desc = "Find references" },
        ["grr"] = { "<Cmd>Lspsaga finder ref<CR>", desc = "Find references" },
      },
    },
  },
}
