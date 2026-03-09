return {
  "akinsho/toggleterm.nvim",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        local Terminal = require("toggleterm.terminal").Terminal
        local Job = require "plenary.job"

        -------------------------------------------------
        -- utils
        -------------------------------------------------

        local function write_file(path, content)
          local f = io.open(path, "w")
          if not f then return end
          f:write(content)
          f:close()
        end

        -------------------------------------------------
        -- collect context
        -------------------------------------------------

        local function buffer_text() return table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n") end

        local function diagnostics_text()
          local diags = vim.diagnostic.get(0)
          if #diags == 0 then return "" end

          local out = {}

          for _, d in ipairs(diags) do
            table.insert(out, ("line %d: %s"):format(d.lnum + 1, d.message))
          end

          return table.concat(out, "\n")
        end

        local function git_diff()
          local handle = io.popen "git diff"
          if not handle then return "" end

          local diff = handle:read "*a"
          handle:close()

          return diff
        end

        local function build_context()
          local ctx = {}

          table.insert(ctx, "=== BUFFER ===")
          table.insert(ctx, buffer_text())

          table.insert(ctx, "\n=== DIAGNOSTICS ===")
          table.insert(ctx, diagnostics_text())

          table.insert(ctx, "\n=== GIT DIFF ===")
          table.insert(ctx, git_diff())

          return table.concat(ctx, "\n")
        end

        -------------------------------------------------
        -- apply unified diff patch
        -------------------------------------------------

        local function apply_patch(patch)
          local tmp_patch = "/tmp/claude_patch.diff"

          write_file(tmp_patch, patch)

          os.execute("git apply " .. tmp_patch)

          vim.cmd "edit"
        end

        -------------------------------------------------
        -- run Claude non-interactive
        -------------------------------------------------

        local function run_claude(prompt, on_done)
          Job:new({
            command = "wecode",
            args = { prompt },
            on_exit = function(j, _)
              local result = table.concat(j:result(), "\n")

              vim.schedule(function() on_done(result) end)
            end,
          }):start()
        end

        -------------------------------------------------
        -- Claude panel
        -------------------------------------------------

        local panel = Terminal:new {
          cmd = "wecode",
          direction = "float",
          hidden = true,
          close_on_exit = false,
          float_opts = {
            border = "rounded",
            width = math.floor(vim.o.columns * 0.9),
            height = math.floor(vim.o.lines * 0.9),
          },
        }

        -------------------------------------------------
        -- explain buffer
        -------------------------------------------------

        local function explain_buffer()
          local tmp = "/tmp/claude_buffer.txt"
          write_file(tmp, buffer_text())

          panel.cmd = 'wecode "explain ' .. tmp .. '"'
          panel:toggle()
        end

        -------------------------------------------------
        -- explain visual
        -------------------------------------------------

        local function explain_selection()
          local s = vim.fn.line "'<"
          local e = vim.fn.line "'>"

          local lines = vim.api.nvim_buf_get_lines(0, s - 1, e, false)

          local text = table.concat(lines, "\n")

          local tmp = "/tmp/claude_sel.txt"
          write_file(tmp, text)

          panel.cmd = 'wecode "explain ' .. tmp .. '"'
          panel:toggle()
        end

        -------------------------------------------------
        -- fix diagnostics with patch
        -------------------------------------------------

        local function fix_diagnostics()
          local ctx = build_context()

          run_claude("Fix the code. Output unified diff patch only:\n" .. ctx, function(result) apply_patch(result) end)
        end

        -------------------------------------------------
        -- review diff
        -------------------------------------------------

        local review = Terminal:new {
          cmd = 'git diff | wecode "review "',
          direction = "float",
          hidden = true,
        }

        -------------------------------------------------
        -- staged review
        -------------------------------------------------

        local staged_review = Terminal:new {
          cmd = 'git diff --staged | wecode "review "',
          direction = "float",
          hidden = true,
        }

        -------------------------------------------------
        -- commit message generator
        -------------------------------------------------

        local function commit_message()
          Job:new({
            command = "bash",
            args = {
              "-c",
              'git diff --staged | wecode "summarize commit "',
            },
            on_exit = function(j)
              local msg = table.concat(j:result(), "\n")

              vim.schedule(function()
                vim.cmd "new"

                vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(msg, "\n"))
              end)
            end,
          }):start()
        end

        -------------------------------------------------
        -- repo analysis
        -------------------------------------------------

        local repo_analysis = Terminal:new {
          cmd = 'wecode "analyze repo"',
          direction = "float",
          hidden = true,
        }

        -------------------------------------------------
        -- keymaps
        -------------------------------------------------

        maps.n["<leader>twc"] = { function() panel:toggle() end, desc = "Wecode Panel" }
        maps.n["<leader>twe"] = { explain_buffer, desc = "Wecode Explain Buffer" }
        maps.v["<leader>twa"] = { explain_selection, desc = "Wecode Explain Selection" }
        maps.n["<leader>twd"] = { fix_diagnostics, desc = "Wecode Fix Diagnostics" }
        maps.n["<leader>twr"] = { function() review:toggle() end, desc = "Wecode Review" }
        maps.n["<leader>tws"] = { function() staged_review:toggle() end, desc = "Wecode Staged Review" }
        maps.n["<leader>twm"] = { commit_message, desc = "Wecode Commit Message" }
        maps.n["<leader>twp"] = { function() repo_analysis:toggle() end, desc = "Wecode Repo Analysis" }
      end,
    },
  },
}
