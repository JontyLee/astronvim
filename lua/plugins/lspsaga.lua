return {
  "nvimdev/lspsaga.nvim",
  branch = "main",
  event = "LspAttach",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["]d"] = { "<Cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next diagnostic" }
        maps.n["[d"] = { "<Cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Previous diagnostic" }
        maps.n["]e"] = {
          "<Cmd>lua require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>",
          desc = "Diagnostic Error Next",
        }
        maps.n["[e"] = {
          "<Cmd>lua require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>",
          desc = "Diagnostic Error Previous",
        }
        maps.n["<Leader>ld"] = { "<Cmd>Lspsaga show_buf_diagnostics<CR>", desc = "Buffer diagnostics" }
        maps.n["<Leader>lw"] = { "<Cmd>Lspsaga show_workspace_diagnostics<CR>", desc = "Workspace diagnostics" }
      end,
    },
    {
      "AstroNvim/astrolsp",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["K"] = { "<Cmd>Lspsaga hover_doc<CR>", desc = "Hover symbol details", cond = "textDocument/hover" }

        -- call hierarchy
        maps.n["<Leader>lc"] =
          { "<Cmd>Lspsaga incoming_calls<CR>", desc = "Incoming calls", cond = "callHierarchy/incomingCalls" }
        maps.n["<Leader>lC"] =
          { "<Cmd>Lspsaga outgoing_calls<CR>", desc = "Outgoing calls", cond = "callHierarchy/outgoingCalls" }

        -- code action
        maps.n["<Leader>la"] =
          { "<Cmd>Lspsaga code_action<CR>", desc = "LSP code action", cond = "textDocument/codeAction" }
        maps.x["<Leader>la"] =
          { ":<C-U>Lspsaga code_action<CR>", desc = "LSP code action", cond = "textDocument/codeAction" }
        maps.n["gra"] = { "<Cmd>Lspsaga code_action<CR>", desc = "LSP code action", cond = "textDocument/codeAction" }
        maps.x["gra"] = { ":<C-U>Lspsaga code_action<CR>", desc = "LSP code action", cond = "textDocument/codeAction" }

        -- definition
        maps.n["<Leader>lp"] =
          { "<Cmd>Lspsaga peek_definition<CR>", desc = "Peek definition", cond = "textDocument/definition" }
        maps.n["<Leader>lP"] =
          { "<Cmd>Lspsaga peek_type_definition<CR>", desc = "Peek type definition", cond = "textDocument/definition" }
        maps.n["<Leader>lg"] = { "<Cmd>Lspsaga goto_definition<CR>", desc = "Goto definition" }
        maps.n["<Leader>lG"] = { "<Cmd>Lspsaga goto_type_definition<CR>", desc = "Goto type definition" }
        maps.n["grt"] = { "<Cmd>Lspsaga goto_definition<CR>", desc = "Goto definition" }

        -- outline
        maps.n["<Leader>lS"] =
          { "<Cmd>Lspsaga outline<CR>", desc = "Symbols outline", cond = "textDocument/documentSymbol" }

        -- references
        maps.n["<Leader>lR"] = {
          "<Cmd>Lspsaga finder<CR>",
          desc = "Search references",
          cond = function(client)
            return client:supports_method "textDocument/references"
              or client:supports_method "textDocument/implementation"
          end,
        }
        maps.n["grr"] = {
          "<Cmd>Lspsaga finder ref<CR>",
          desc = "Search references",
          cond = function(client)
            return client:supports_method "textDocument/references"
              or client:supports_method "textDocument/implementation"
          end,
        }
        maps.n["gri"] = {
          "<Cmd>Lspsaga finder imp<CR>",
          desc = "Search references",
          cond = function(client)
            return client:supports_method "textDocument/references"
              or client:supports_method "textDocument/implementation"
          end,
        }

        -- rename
        maps.n["<Leader>lr"] =
          { "<Cmd>Lspsaga rename<CR>", desc = "Rename current symbol", cond = "textDocument/rename" }
        maps.n["grn"] = { "<Cmd>Lspsaga rename<CR>", desc = "Rename current symbol", cond = "textDocument/rename" }
      end,
    },
  },
  opts = function()
    local astroui = require "astroui"
    local get_icon = function(icon) return astroui.get_icon(icon, 0, true) end
    return {
      request_timeout = 3000,
      ui = {
        code_action = get_icon "DiagnosticHint",
        actionfix = "󰁨 ",
        devicon = false,
        title = true,
        expand = get_icon "FoldClosed",
        collapse = get_icon "FoldOpened",
      },
      beacon = {
        enable = false,
        frequency = 12,
      },
      scroll_preview = {
        scroll_down = "<C-f>",
        scroll_up = "<C-b>",
      },
      callhierarchy = {
        edit = { "e", "<CR>" },
        vsplit = "s",
        split = "i",
        tabe = "t",
        quit = { "q", "<ESC>" },
        shuttle = "[w",
        toggle_or_req = "u",
        close = "<C-c>k",
      },
      finder = {
        keys = {
          shuttle = "[w",
          toggle_or_open = { "<CR>", "o" },
          vsplit = "s",
          split = "i",
          tabe = "t",
          tabnew = "r",
          quit = { "q", "<ESC>" },
          close = "<C-c>k",
        },
        default = "imp+ref",
      },
      definition = {
        edit = "<C-c>o",
        vsplit = "<C-c>v",
        split = "<C-c>s",
        tabe = "<C-c>t",
        quit = { "q", "ESC" },
      },
      code_action = {
        num_shortcut = true,
        show_server_name = true,
        extend_gitsigns = require("astrocore").is_available "gitsigns.nvim",
        keys = {
          quit = { "q", "<ESC>" },
          exec = "<CR>",
        },
      },
      lightbulb = {
        enable = true,
        sign = true,
        enable_in_insert = true,
        sign_priority = 20,
        virtual_text = false,
      },
      diagnostic = {
        text_hl_follow = true,
        show_code_action = true,
        border_follow = true,
        extend_relatedInformation = true,
        jump_num_shortcut = true,
        diagnostic_only_current = false,
        show_layout = "float",
        keys = {
          exec_action = "r",
          quit = "q",
          expand_or_jump = { "<CR>", "o" },
          quit_in_show = { "q", "<ESC>" },
        },
      },
      rename = {
        in_select = false,
        auto_save = true,
        keys = {
          quit = { "q", "<ESC>" },
          exec = "<CR>",
          select = "x",
        },
      },
      outline = {
        win_position = "right",
        win_width = 30,
        auto_preview = false,
        detail = true,
        auto_close = true,
        close_after_jump = true,
        keys = {
          toggle_or_jump = { "o" },
          quit = { "q", "<ESC>" },
          jump = { "<CR>", "e" },
        },
      },
      symbol_in_winbar = { enable = false },
      implement = {
        enable = true,
        sign = true,
        virtual_text = true,
        priority = 100,
      },
    }
  end,
}
