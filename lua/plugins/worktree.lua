return {
  "Juksuu/worktrees.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim",
  },
  opts = function()
    local snacks = require "snacks"

    return {
      -- Path where worktrees are created (e.g., ".." means parent of current project)
      worktree_path = "..",
      -- Command to run when switching worktrees if no buffer is available
      switch_file_command = false,
      -- Use tab-local directory
      hooks = {
        on_switch = function(_, to)
          -- 1. Ensure tab-local directory is updated
          vim.cmd("tcd " .. to)
          -- 2. Notify user
          local name = vim.fn.fnamemodify(to, ":t")
          snacks.notify("Switched to worktree: " .. name, { title = "Worktree" })
        end,
        on_add = function(name, path, _)
          local source = vim.fn.getcwd()
          local target = vim.fn.fnamemodify(path, ":p")
          local hidden_files = vim.fn.globpath(source, ".*", true, true)
          local copied = false
          for _, file in ipairs(hidden_files) do
            local base = vim.fn.fnamemodify(file, ":t")
            -- 排除 . 和 .. 以及所有以 .git 开头的文件/目录
            if base ~= "." and base ~= ".." and not base:match "^%.git" then
              vim.fn.jobstart({ "cp", "-r", file, target })
              copied = true
            end
          end
          local msg = "Worktree created: " .. name
          if copied then msg = msg .. "\nCopied hidden files/dirs from source" end
          snacks.notify(msg, { type = "success", title = "Worktree" })
        end,
      },
    }
  end,
  config = function(_, opts)
    local wt = require "worktrees"
    wt.setup(opts)

    local snacks = require "snacks"

    -- ================================
    -- 🎯 Keybindings (Optimized)
    -- ================================

    -- List and Switch worktrees using built-in Snacks picker integration
    vim.keymap.set("n", "<leader>gwl", function()
      -- The plugin registers 'worktrees' source in Snacks.picker.sources
      snacks.picker "worktrees"
    end, { desc = "List worktrees" })

    -- Create new worktree (with branch selection)
    vim.keymap.set("n", "<leader>gwc", function() snacks.picker "worktrees_new" end, { desc = "Create worktree" })

    -- Remove worktree
    vim.keymap.set("n", "<leader>gwd", function() snacks.picker "worktrees_remove" end, { desc = "Remove worktree" })
  end,
}
