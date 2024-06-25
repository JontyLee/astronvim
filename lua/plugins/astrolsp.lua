-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local formatting_enabled = function(client, _)
  local formatting_disabled = vim.tbl_get(require("astrolsp").config, "formatting", "disabled")
  return client.supports_method "textDocument/formatting"
    and formatting_disabled ~= true
    and not vim.tbl_contains(formatting_disabled, client.name)
end

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      autoformat = true, -- enable or disable auto formatting on start
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = true, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        "volar",
      },
      timeout_ms = 100000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
    }, -- customize how language servers are attached
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
        cond = formatting_enabled,
        {
          event = "BufWritePre",
          desc = "autoformat on save",
          callback = function(_, _, bufnr)
            if vim.bo[bufnr].filetype == "go" and #vim.lsp.get_clients { name = "gopls" } >= 1 then
              local params = vim.lsp.util.make_range_params()
              params.context = { only = { "source.organizeImports" } }
              -- buf_request_sync defaults to a 1000ms timeout. Depending on your
              -- machine and codebase, you may want longer. Add an additional
              -- argument after params if you find that you have to write the file
              -- twice for changes to be saved.
              -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
              local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 10000)
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
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        -- this mapping will only be set in buffers with an LSP attached
        K = {
          "<Cmd>Lspsaga hover_doc<CR>",
          desc = "Hover symbol details",
        },
        ["<Leader>ld"] = { "<Cmd>Lspsaga show_buf_diagnostics<CR>", desc = "Lspsaga show_buf_diagnostics" },
        ["<Leader>lv"] = { "<Cmd>lua require('lsp_lines').toggle()<CR>", desc = "Lsp lines" },
        ["<Leader>lw"] = {
          "<Cmd>Lspsaga show_workspace_diagnostics<CR>",
          desc = "Lspsaga show_workspace_diagnostics",
        },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
      require("lsp_signature").on_attach(client, bufnr)
    end,
  },
}
