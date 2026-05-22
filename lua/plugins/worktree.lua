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
          local source = vim.fn.system({ "git", "rev-parse", "--show-toplevel" }):gsub("%s+$", "")
          local target = vim.fn.fnamemodify(path, ":p")

          local untracked = vim.fn.system({ "git", "-C", source, "ls-files", "--others", "--exclude-standard" })
          if vim.v.shell_error ~= 0 then
            snacks.notify("Worktree created: " .. name, { type = "success", title = "Worktree" })
            return
          end

          local files = vim.split(untracked, "\n", { trimempty = true })

          local copied = false
          for _, file in ipairs(files) do
            local src = source .. "/" .. file
            local dst = target .. "/" .. file
            local dir = vim.fn.fnamemodify(dst, ":h")
            vim.fn.mkdir(dir, "p")
            vim.fn.system({ "cp", "-r", src, dst })
            copied = true
          end

          local msg = "Worktree created: " .. name
          if copied then msg = msg .. "\nCopied untracked files from source" end
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
    vim.keymap.set("n", "<leader>gwc", function()
      snacks.picker("worktrees_new", { show_empty = true })
    end, { desc = "Create worktree" })

    -- Remove worktree
    vim.keymap.set("n", "<leader>gwd", function() snacks.picker "worktrees_remove" end, { desc = "Remove worktree" })
  end,
}
