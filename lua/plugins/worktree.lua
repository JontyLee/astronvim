return {
  {
    "Juksuu/worktrees.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
    },
    config = function()
      local wt = require "worktrees"
      local snacks = require "snacks"

      -- ================================
      -- 基础配置
      -- ================================
      wt.setup {
        default_branch = "develop",
        change_directory_command = "tcd",
        update_cwd = true,
        auto_push = false,
        prompt_for_branch = false,
      }

      -- snacks.setup {
      --   input = { enabled = true },
      --   notifier = { enabled = true },
      --   picker = { enabled = true }, -- ✅ 用 snacks 自己的 picker
      -- }

      -- ================================
      -- 🐱 kitty 智能控制（核心）
      -- ================================
      local function kitty_exec(args) vim.fn.jobstart(vim.list_extend({ "kitty", "@" }, args), { detach = true }) end

      local function get_kitty_tabs()
        local handle = io.popen "kitty @ ls"
        if not handle then return "" end
        local result = handle:read "*a"
        handle:close()
        return result or ""
      end

      local function open_or_focus(path)
        local name = vim.fn.fnamemodify(path, ":t")
        local tabs = get_kitty_tabs()

        if tabs:find(name, 1, true) then
          kitty_exec { "focus-tab", "--match", "title:" .. name }
        else
          kitty_exec {
            "launch",
            "--type=tab",
            "--tab-title",
            name,
            "--cwd",
            path,
            "nvim",
          }
        end
      end

      -- ================================
      -- 📦 获取 worktrees（关键：替代 telescope）
      -- ================================
      local function list_worktrees()
        local result = {}
        local handle = io.popen "git worktree list --porcelain"
        if not handle then return result end

        local current = {}
        for line in handle:lines() do
          if line:match "^worktree " then
            current.path = line:gsub("^worktree ", "")
          elseif line:match "^branch " then
            current.branch = line:gsub("^branch refs/heads/", "")
          elseif line == "" then
            table.insert(result, current)
            current = {}
          end
        end
        handle:close()

        return result
      end

      -- ================================
      -- 🎯 创建 worktree
      -- ================================
      vim.keymap.set("n", "<leader>gwc", function()
        snacks.input({ prompt = "Branch name" }, function(branch)
          if not branch or branch == "" then return end

          wt.create_worktree(branch)

          local root = vim.fn.getcwd()
          local path = root .. "-worktrees/" .. branch

          vim.defer_fn(function() open_or_focus(path) end, 200)
        end)
      end, { desc = "Create worktree" })

      -- ================================
      -- 🎯 snacks picker 选择 worktree
      -- ================================
      vim.keymap.set("n", "<leader>gwl", function()
        local items = list_worktrees()

        snacks.picker {
          title = "Worktrees",
          items = vim.tbl_map(
            function(wtree)
              return {
                text = wtree.branch .. " → " .. wtree.path,
                value = wtree,
              }
            end,
            items
          ),

          confirm = function(item)
            if not item then return end

            wt.switch_worktree(item.value.path)
            open_or_focus(item.value.path)
          end,
        }
      end, { desc = "List worktrees" })

      -- ================================
      -- 🎯 当前 worktree 打开
      -- ================================
      vim.keymap.set(
        "n",
        "<leader>gwo",
        function() open_or_focus(vim.fn.getcwd()) end,
        { desc = "Open current worktree" }
      )

      -- ================================
      -- 🧩 session 恢复
      -- ================================
      vim.api.nvim_create_autocmd("User", {
        pattern = "WorktreeSwitch",
        callback = function() vim.cmd "silent! SessionRestore" end,
      })

      -- ================================
      -- 🔔 通知
      -- ================================
      local notify = snacks.notify

      vim.api.nvim_create_autocmd("User", {
        pattern = "WorktreeSwitch",
        callback = function() notify("Switched → " .. vim.fn.getcwd()) end,
      })
    end,
  },
}
