-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints" },
  { import = "astrocommunity.recipes.picker-nvchad-theme" },
  -- { import = "astrocommunity.recipes.diagnostic-virtual-lines-current-line" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                           ai                             │
  --  ╰──────────────────────────────────────────────────────────╯
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                      bars-and-lines                      │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
  { import = "astrocommunity.bars-and-lines.vim-illuminate" },
  {
    "RRethy/vim-illuminate",
    opts = function(_, opts)
      opts.providers = { "regex" } -- only use regex to avoid heavy lifting and bugs in TS/LSP providers
      return opts
    end,
  },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                       code-runner                        │
  --  ╰──────────────────────────────────────────────────────────╯
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                          color                           │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.color.transparent-nvim" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                       colorscheme                        │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.colorscheme.dracula-nvim" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                         comment                          │
  --  ╰──────────────────────────────────────────────────────────╯
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                        completion                        │
  --  ╰──────────────────────────────────────────────────────────╯
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                        debugging                         │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.debugging.nvim-dap-repl-highlights" },
  { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
  { import = "astrocommunity.debugging.persistent-breakpoints-nvim" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                       diagnostics                        │
  --  ╰──────────────────────────────────────────────────────────╯
  -- ╭─────────────────────────────────────────────────────────╮
  -- │                         docker                          │
  -- ╰─────────────────────────────────────────────────────────╯
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                     editing-support                      │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.editing-support.comment-box-nvim" },
  { import = "astrocommunity.editing-support.hypersonic-nvim" },
  { import = "astrocommunity.editing-support.mcphub-nvim" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.quick-scope" },
  { import = "astrocommunity.editing-support.suda-vim" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function(_, opts)
      local default_keywords = {
        FIX = { icon = " " },
        TODO = { icon = " ", alt = { "WIP" } },
        HACK = { icon = " ", color = "hack" },
        WARN = { icon = " " },
        PERF = { icon = " " },
        NOTE = { icon = " ", alt = { "INFO", "NB" } },
        ERROR = { icon = " ", color = "error", alt = { "ERR" } },
        REFS = { icon = " " },
        SAFETY = { icon = " ", color = "hint" },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        SEE = { icon = " ", color = "info" },
        WIKI = { icon = "󰖬 ", color = "info" },
        LINK = { icon = "󱅷 ", color = "info" },
        DEBUG = { icon = "⏲ ", color = "test" },
        DEPRECATED = { icon = "󱒼 ", color = "hint" },
      }
      local final_keywords = {}
      -- Add lowercase versions of each keyword
      for key, val in pairs(default_keywords) do
        local key_lower = key:lower()
        local key_first_upper = key_lower:gsub("^%l", string.upper)
        final_keywords[key_lower] = val
        final_keywords[key_first_upper] = val
        final_keywords[key] = val
      end
      local custom_opts = {
        signs = true,
        keywords = final_keywords,
        merge_keywords = false,
        highlight = {
          multiline = true,
          multiline_pattern = "^.",
          comments_only = true,
          max_line_len = 400,
        },
        colors = {
          error = { "DiagnosticError" },
          warning = { "DiagnosticWarn" },
          info = { "DiagnosticInfo" },
          hint = { "DiagnosticHint" },
          hack = { "Function" },
          ref = { "FloatBorder" },
          default = { "Identifier" },
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          -- regex that will be used to match keywords.
          -- don't replace the (KEYWORDS) placeholder
          pattern = [[\b(KEYWORDS):]], -- ripgrep regex
          -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
        },
      }
      return vim.tbl_deep_extend("force", opts, custom_opts)
    end,
  },
  { import = "astrocommunity.editing-support.treesj" },
  { import = "astrocommunity.editing-support.vim-move" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                       fuzzy-finder                       │
  --  ╰──────────────────────────────────────────────────────────╯
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                           git                            │
  --  ╰──────────────────────────────────────────────────────────╯
  -- { import = "astrocommunity.git.neogit" },
  { import = "astrocommunity.git.diffview-nvim" },
  {
    "sindrets/diffview.nvim",
    opts = function(_, opts) opts.view = { merge_tool = { layout = "diff3_mixed" } } end,
  },
  { import = "astrocommunity.git.gitgraph-nvim" },
  { import = "astrocommunity.git.octo-nvim" },
  { import = "astrocommunity.git.openingh-nvim" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                          indent                          │
  --  ╰──────────────────────────────────────────────────────────╯
  -- { import = "astrocommunity.indent.indent-blankline-nvim" },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   opts = function(_, opts)
  --     local highlight = {
  --       "CursorColumn",
  --       "Whitespace",
  --     }
  --     opts.indent = { char = "╎", highlight = highlight }
  --     opts.whitespace = { highlight = highlight, remove_blankline_trail = false }
  --   end,
  -- },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                           lsp                            │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.lsp.nvim-lsp-endhints" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                    markdown-and-latex                    │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                          motion                          │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.motion.flash-nvim" },
  -- { import = "astrocommunity.motion.flit-nvim" },
  { import = "astrocommunity.motion.grapple-nvim" },
  -- { import = "astrocommunity.motion.harpoon" },
  { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.motion.marks-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.portal-nvim" },
  { import = "astrocommunity.motion.vim-matchup" },
  -- ╭─────────────────────────────────────────────────────────╮
  -- │                          pack                           │
  -- ╰─────────────────────────────────────────────────────────╯
  -- { import = "astrocommunity.pack.full-dadbod" },
  -- { import = "astrocommunity.pack.markdown" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │              programming-language-support                │
  --  ╰──────────────────────────────────────────────────────────╯
  -- { import = "astrocommunity.programming-language-support.dooku-nvim" },
  { import = "astrocommunity.programming-language-support.kulala-nvim" },
  { import = "astrocommunity.programming-language-support.nvim-jqx" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                         project                          │
  --  ╰──────────────────────────────────────────────────────────╯
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                         register                         │
  --  ╰──────────────────────────────────────────────────────────╯
  -- { import = "astrocommunity.register.nvim-neoclip-lua" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                        scrolling                         │
  --  ╰──────────────────────────────────────────────────────────╯
  -- { import = "astrocommunity.scrolling.neoscroll-nvim" },
  -- { import = "astrocommunity.scrolling.nvim-scrollbar" },
  -- { import = "astrocommunity.scrolling.satellite-nvim" },
  -- { import = "astrocommunity.scrolling.vim-smoothie" },
  -- ╭─────────────────────────────────────────────────────────╮
  -- │                         search                          │
  -- ╰─────────────────────────────────────────────────────────╯
  { import = "astrocommunity.search.nvim-hlslens" },
  { import = "astrocommunity.search.nvim-spectre" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                     split-and-window                     │
  --  ╰──────────────────────────────────────────────────────────╯
  -- { import = "astrocommunity.split-and-window.edgy-nvim" },
  -- { import = "astrocommunity.split-and-window.minimap-vim" },
  -- { import = "astrocommunity.split-and-window.windows-nvim" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                          syntax                          │
  --  ╰──────────────────────────────────────────────────────────╯
  -- { import = "astrocommunity.syntax.hlargs-nvim" },
  -- { import = "astrocommunity.syntax.vim-cool" },
  -- { import = "astrocommunity.syntax.vim-easy-align" },
  -- { import = "astrocommunity.syntax.vim-sandwich" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                   terminal-integration                   │
  --  ╰──────────────────────────────────────────────────────────╯
  -- { import = "astrocommunity.terminal-integration.flatten-nvim" },
  -- { import = "astrocommunity.terminal-integration.vim-tmux-yank" },
  -- { import = "astrocommunity.terminal-integration.vim-tpipeline" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                           test                           │
  --  ╰──────────────────────────────────────────────────────────╯
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                         utility                          │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.utility.noice-nvim" },
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      local spinners = require "noice.util.spinners"
      spinners.spinners["mine"] = {
        frames = {
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
          " ",
        },
        interval = 80,
      }
      opts.format = {
        spinner = {
          name = "mine",
          hl = "Constant",
        },
      }
      opts.presets.command_palette = false
      opts.lsp.signature = { enabled = false }
      local null_ls_filter = {
        filter = {
          event = "lsp",
          kind = "progress",
          cond = function(message)
            local client = vim.tbl_get(message.opts, "progress", "client")
            return client == "null-ls" -- skip null-ls progress
          end,
        },
        opts = { skip = true },
      }
      if opts.routes == nil then opts.routes = {} end
      table.insert(opts.routes, null_ls_filter)
    end,
  },
  -- { import = "astrocommunity.utility.vim-fetch" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                         workflow                         │
  --  ╰──────────────────────────────────────────────────────────╯
  -- { import = "astrocommunity.workflow.precognition-nvim" },
}
