-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  -- { import = "astrocommunity.recipes.heirline-nvchad-statusline" },
  { import = "astrocommunity.recipes.telescope-nvchad-theme" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                      bars-and-lines                      │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
  { import = "astrocommunity.bars-and-lines.vim-illuminate" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                       code-runner                        │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.code-runner.sniprun" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                          color                           │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.color.twilight-nvim" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                       colorscheme                        │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },
  { import = "astrocommunity.colorscheme.nightfox-nvim" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                         comment                          │
  --  ╰──────────────────────────────────────────────────────────╯
  -- { import = "astrocommunity.comment.mini-comment" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                        completion                        │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.completion.cmp-cmdline" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                        debugging                         │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.debugging.nvim-bqf" },
  { import = "astrocommunity.debugging.nvim-dap-repl-highlights" },
  { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
  { import = "astrocommunity.debugging.persistent-breakpoints-nvim" },
  { import = "astrocommunity.debugging.telescope-dap-nvim" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                       diagnostics                        │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                     editing-support                      │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.editing-support.comment-box-nvim" },
  { import = "astrocommunity.editing-support.cutlass-nvim" },
  { import = "astrocommunity.editing-support.dial-nvim" },
  { import = "astrocommunity.editing-support.hypersonic-nvim" },
  { import = "astrocommunity.editing-support.multicursors-nvim" },
  {
    "smoka7/multicursors.nvim",
    keys = {
      {
        mode = { "v", "n" },
        "<Leader>m",
        "<Cmd>MCstart<CR>",
        desc = "󰪷 Create selection ",
      },
    },
  },
  { import = "astrocommunity.editing-support.neogen" },
  { import = "astrocommunity.editing-support.nvim-devdocs" },
  { import = "astrocommunity.editing-support.nvim-treesitter-endwise" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.refactoring-nvim" },
  { import = "astrocommunity.editing-support.stickybuf-nvim" },
  { import = "astrocommunity.editing-support.suda-vim" },
  { import = "astrocommunity.editing-support.telescope-undo-nvim" },
  { import = "astrocommunity.editing-support.text-case-nvim" },
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
  -- { import = "astrocommunity.editing-support.ultimate-autopair-nvim" },
  -- {
  --   "altermo/ultimate-autopair.nvim",
  --   opts = function(_, opts)
  --     local cond = opts.extensions.rule
  --     opts.extensions = { cond = cond }
  --     return opts
  --   end,
  -- },
  { import = "astrocommunity.editing-support.vim-move" },
  { import = "astrocommunity.editing-support.yanky-nvim" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                       fuzzy-finder                       │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.fuzzy-finder.telescope-zoxide" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                           git                            │
  --  ╰──────────────────────────────────────────────────────────╯
  -- { import = "astrocommunity.git.blame-nvim" },
  { import = "astrocommunity.git.diffview-nvim" },
  {
    "sindrets/diffview.nvim",
    opts = function(_, opts) opts.view = { merge_tool = { layout = "diff3_mixed" } } end,
  },
  {
    "NeogitOrg/neogit",
    endable = false,
    -- dependencies = {
    --   {
    --     "sindrets/diffview.nvim",
    --     opts = function(_, opts) opts.view = { merge_tool = { layout = "diff3_mixed" } } end,
    --   },
    --   { "nvim-telescope/telescope.nvim" },
    -- },
  },
  { import = "astrocommunity.git.octo-nvim" },
  { import = "astrocommunity.git.openingh-nvim" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                          indent                          │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.indent.indent-blankline-nvim" },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = function(_, opts)
      local highlight = {
        "CursorColumn",
        "Whitespace",
      }
      opts.indent = { char = "╎", highlight = highlight }
      opts.whitespace = { highlight = highlight, remove_blankline_trail = false }
    end,
  },
  -- { import = "astrocommunity.indent.mini-indentscope" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                           lsp                            │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.lsp.garbage-day-nvim" },
  -- { import = "astrocommunity.lsp.inc-rename-nvim" },
  { import = "astrocommunity.lsp.lsp-signature-nvim" },
  {
    "ray-x/lsp_signature.nvim",
    opts = function(_, opts)
      opts.hint_enable = true
      opts.hint_prefix = " "
    end,
  },
  { import = "astrocommunity.lsp.lsplinks-nvim" },
  { import = "astrocommunity.lsp.lspsaga-nvim" },
  { import = "astrocommunity.lsp.nvim-lsp-file-operations" },
  { import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                    markdown-and-latex                    │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.markdown-and-latex.glow-nvim" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  { import = "astrocommunity.markdown-and-latex.markmap-nvim" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                          motion                          │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.flit-nvim" },
  { import = "astrocommunity.motion.grapple-nvim" },
  { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.motion.marks-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.portal-nvim" },
  { import = "astrocommunity.motion.vim-matchup" },
  -- ╭─────────────────────────────────────────────────────────╮
  -- │                          pack                           │
  -- ╰─────────────────────────────────────────────────────────╯
  { import = "astrocommunity.pack.full-dadbod" },
  { import = "astrocommunity.pack.markdown" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │              programming-language-support                │
  --  ╰──────────────────────────────────────────────────────────╯
  -- { import = "astrocommunity.programming-language-support.dooku-nvim" },
  -- { import = "astrocommunity.programming-language-support.rest-nvim" },
  {
    {
      "vhyrro/luarocks.nvim",
      priority = 1000,
      config = true,
      opts = {
        luarocks_build_args = {
          "--with-lua-include=/usr/include",
        },
        rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
      },
    },
    {
      "rest-nvim/rest.nvim",
      ft = "http",
      dependencies = { "luarocks.nvim" },
      config = function() require("rest-nvim").setup() end,
    },
  },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                         project                          │
  --  ╰──────────────────────────────────────────────────────────╯
  -- { import = "astrocommunity.project.project-nvim" },
  -- {
  --   "ahmedkhalf/project.nvim",
  --   opts = function(_, opts)
  --     opts.scope_chdir = "tab"
  --     return opts
  --   end,
  -- },
  { import = "astrocommunity.project.nvim-spectre" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                         register                         │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.register.nvim-neoclip-lua" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                        scrolling                         │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.scrolling.neoscroll-nvim" },
  { import = "astrocommunity.scrolling.nvim-scrollbar" },
  -- { import = "astrocommunity.scrolling.satellite-nvim" },
  { import = "astrocommunity.scrolling.vim-smoothie" },
  -- ╭─────────────────────────────────────────────────────────╮
  -- │                         search                          │
  -- ╰─────────────────────────────────────────────────────────╯
  { import = "astrocommunity.search.nvim-hlslens" },
  { import = "astrocommunity.search.sad-nvim" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                     split-and-window                     │
  --  ╰──────────────────────────────────────────────────────────╯
  -- { import = "astrocommunity.split-and-window.edgy-nvim" },
  -- { import = "astrocommunity.split-and-window.minimap-vim" },
  { import = "astrocommunity.split-and-window.windows-nvim" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                          syntax                          │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.syntax.hlargs-nvim" },
  { import = "astrocommunity.syntax.vim-cool" },
  { import = "astrocommunity.syntax.vim-easy-align" },
  { import = "astrocommunity.syntax.vim-sandwich" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                   terminal-integration                   │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.terminal-integration.flatten-nvim" },
  -- { import = "astrocommunity.terminal-integration.vim-tmux-yank" },
  -- { import = "astrocommunity.terminal-integration.vim-tpipeline" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                           test                           │
  --  ╰──────────────────────────────────────────────────────────╯
  -- { import = "astrocommunity.test.neotest" },
  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = { "nvim-neotest/neotest-go" },
  --   opts = function(_, opts)
  --     if not opts.adapters then opts.adapters = {} end
  --     table.insert(opts.adapters, require "neotest-go"(require("astrocore").plugin_opts "neotest-go"))
  --   end,
  -- },
  { import = "astrocommunity.test.nvim-coverage" },
  -- {
  --   "andythigpen/nvim-coverage",
  --   config = function()
  --     require("coverage").setup {
  --       commands = true, -- create commands
  --       highlights = {
  --         -- customize highlight groups created by the plugin
  --         covered = { fg = "#75e36b" }, -- supports style, fg, bg, sp (see :h highlight-gui)
  --         uncovered = { fg = "#F07178" },
  --       },
  --       signs = {
  --         -- use your own highlight groups or text markers
  --         covered = { hl = "CoverageCovered", text = "▎" },
  --         uncovered = { hl = "CoverageUncovered", text = "▎" },
  --       },
  --       summary = {
  --         -- customize the summary pop-up
  --         min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
  --       },
  --       lang = {
  --         -- customize language specific settings
  --       },
  --     }
  --   end,
  -- },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                         utility                          │
  --  ╰──────────────────────────────────────────────────────────╯
  -- { import = "astrocommunity.utility.neodim" },
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
  -- { import = "astrocommunity.utility.nvim-toggler" },
  { import = "astrocommunity.utility.telescope-fzy-native-nvim" },
  { import = "astrocommunity.utility.telescope-live-grep-args-nvim" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                         workflow                         │
  --  ╰──────────────────────────────────────────────────────────╯
  -- { import = "astrocommunity.workflow.hardtime-nvim" },
}
