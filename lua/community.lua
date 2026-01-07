-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints" },
  { import = "astrocommunity.recipes.picker-nvchad-theme" },
  { import = "astrocommunity.ai.kurama622-llm-nvim" },
  { import = "astrocommunity.recipes.diagnostic-virtual-lines-current-line" },
  {
    "Kurama622/llm.nvim",
    config = function()
      local tools = require "llm.tools"
      require("llm").setup {
        url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
        model = "gemini-2.5-flash",
        api_type = "openai",
        max_tokens = 8192,
        temperature = 0.3,
        save_session = true,
        max_history = 15,
        max_history_name_length = 20,
        app_handler = {
          OptimizeCode = {
            handler = tools.side_by_side_handler,
            -- opts = {
            --   streaming_handler = local_llm_streaming_handler,
            -- },
          },
          TestCode = {
            handler = tools.side_by_side_handler,
            prompt = [[ Write some test cases for the following code, only return the test cases.
            Give the code content directly, do not use code blocks or other tags to wrap it. ]],
            opts = {
              right = {
                title = " Test Cases ",
              },
            },
          },
          OptimCompare = {
            handler = tools.action_handler,
            opts = {
              fetch_key = function() return vim.env.GITHUB_TOKEN end,
              url = "https://models.inference.ai.azure.com/chat/completions",
              model = "gpt-4o",
              api_type = "openai",
            },
          },

          Translate = {
            handler = tools.qa_handler,
            opts = {
              fetch_key = function() return vim.env.GLM_KEY end,
              url = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
              model = "glm-4-flash",
              api_type = "zhipu",

              component_width = "60%",
              component_height = "50%",
              query = {
                title = " 󰊿 Trans ",
                hl = { link = "Define" },
              },
              input_box_opts = {
                size = "15%",
                win_options = {
                  winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
              },
              preview_box_opts = {
                size = "85%",
                win_options = {
                  winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
              },
            },
          },

          -- check siliconflow's balance
          UserInfo = {
            handler = function()
              local key = os.getenv "LLM_KEY"
              local res = tools.curl_request_handler(
                "https://api.siliconflow.cn/v1/user/info",
                { "GET", "-H", string.format("'Authorization: Bearer %s'", key) }
              )
              if res ~= nil then print("balance: " .. res.data.balance) end
            end,
          },
          WordTranslate = {
            handler = tools.flexi_handler,
            prompt = "Translate the following text to Chinese, please only return the translation",
            opts = {
              fetch_key = function() return vim.env.GLM_KEY end,
              url = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
              model = "glm-4-flash",
              api_type = "zhipu",
              args = [[return {url, "-N", "-X", "POST", "-H", "Content-Type: application/json", "-H", authorization, "-d", vim.fn.json_encode(body)}]],
              exit_on_move = true,
              enter_flexible_window = false,
            },
          },
          CodeExplain = {
            handler = tools.flexi_handler,
            prompt = "Explain the following code, please only return the explanation, and answer in Chinese",
            opts = {
              fetch_key = function() return vim.env.GLM_KEY end,
              url = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
              model = "glm-4-flash",
              api_type = "zhipu",
              enter_flexible_window = true,
            },
          },
          CommitMsg = {
            handler = tools.flexi_handler,
            prompt = function()
              -- Source: https://andrewian.dev/blog/ai-git-commits
              return string.format(
                [[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

1. First line: conventional commit format (type: concise description) (remember to use semantic types like feat, fix, docs, style, refactor, perf, test, chore, etc.)
2. Optional bullet points if more context helps:
   - Keep the second line blank
   - Keep them short and direct
   - Focus on what changed
   - Always be terse
   - Don't overly explain
   - Drop any fluffy or formal language

Return ONLY the commit message - no introduction, no explanation, no quotes around it.

Examples:
feat: add user auth system

- Add JWT tokens for API auth
- Handle token refresh for long sessions

fix: resolve memory leak in worker pool

- Clean up idle connections
- Add timeout for stale workers

Simple change example:
fix: typo in README.md

Very important: Do not respond with any of the examples. Your message must be based off the diff that is about to be provided, with a little bit of styling informed by the recent commits you're about to see.

Based on this format, generate appropriate commit messages. Respond with message only. DO NOT format the message in Markdown code blocks, DO NOT use backticks:

```diff
%s
```
]],
                vim.fn.system "git diff --no-ext-diff --staged"
              )
            end,

            opts = {
              enter_flexible_window = true,
              apply_visual_selection = false,
              win_opts = {
                relative = "editor",
                position = "50%",
              },
              accept = {
                mapping = {
                  mode = "n",
                  keys = "<cr>",
                },
                action = function()
                  local contents = vim.api.nvim_buf_get_lines(0, 0, -1, true)
                  vim.api.nvim_command(string.format('!git commit -m "%s"', table.concat(contents, '" -m "')))

                  -- just for lazygit
                  vim.schedule(function() require("snacks").lazygit() end)
                end,
              },
            },
          },
        },
      }
    end,
    keys = {
      { "<Leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
      { "<Leader>ts", mode = "x", "<cmd>LLMAppHandler WordTranslate<cr>" },
      { "<Leader>ae", mode = "v", "<cmd>LLMAppHandler CodeExplain<cr>" },
      { "<Leader>at", mode = "n", "<cmd>LLMAppHandler Translate<cr>" },
      { "<Leader>tc", mode = "x", "<cmd>LLMAppHandler TestCode<cr>" },
      { "<Leader>ao", mode = "x", "<cmd>LLMAppHandler OptimCompare<cr>" },
      { "<Leader>au", mode = "n", "<cmd>LLMAppHandler UserInfo<cr>" },
      { "<Leader>ag", mode = "n", "<cmd>LLMAppHandler CommitMsg<cr>" },
      -- { "<leader>ao", mode = "x", "<cmd>LLMAppHandler OptimizeCode<cr>" },
    },
  },

  --  ╭──────────────────────────────────────────────────────────╮
  --  │                      bars-and-lines                      │
  --  ╰──────────────────────────────────────────────────────────╯
  { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
  { import = "astrocommunity.bars-and-lines.vim-illuminate" },
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                       code-runner                        │
  --  ╰──────────────────────────────────────────────────────────╯
  --  ╭──────────────────────────────────────────────────────────╮
  --  │                          color                           │
  --  ╰──────────────────────────────────────────────────────────╯
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
  -- { import = "astrocommunity.editing-support.nvim-treesitter-context" },
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
  -- { import = "astrocommunity.lsp.garbage-day-nvim" },
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
  { import = "astrocommunity.programming-language-support.rest-nvim" },
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
