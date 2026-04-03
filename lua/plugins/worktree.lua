return {
  "Juksuu/worktrees.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim",
  },
  opts = function()
    local snacks = require "snacks"

    -- ================================
    -- 🐱 Kitty Terminal Integration
    -- ================================
    -- Helper to execute kitty commands
    local function kitty_exec(args) vim.fn.jobstart(vim.list_extend({ "kitty", "@" }, args), { detach = true }) end

    -- Get raw JSON of kitty tabs for precise matching
    local function get_kitty_tabs()
      local handle = io.popen "kitty @ ls 2>/dev/null"
      if not handle then return "" end
      local result = handle:read "*a"
      handle:close()
      return result or ""
    end

    -- Open a path in a new tab or focus it if already open
    local function open_or_focus(path)
      local name = vim.fn.fnamemodify(path, ":t")
      local tabs = get_kitty_tabs()

      -- Check if a tab with this title exists (simple check, could be improved with JSON parsing)
      if tabs ~= "" and tabs:find('"title": "' .. name .. '"', 1, true) then
        kitty_exec { "focus-tab", "--match", "title:" .. name }
      else
        -- Launch a new tab with nvim in that directory
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

    return {
      -- Path where worktrees are created (e.g., ".." means parent of current project)
      worktree_path = "..",
      -- Command to run when switching worktrees if no buffer is available
      switch_file_command = "Ex",
      -- Use tab-local directory
      hooks = {
        on_switch = function(_, to)
          -- 1. Ensure tab-local directory is updated
          vim.cmd("tcd " .. to)
          -- 2. Sync Kitty tab title
          local name = vim.fn.fnamemodify(to, ":t")
          kitty_exec { "set-tab-title", name }
          -- 3. Restore session (Safe check for common session commands)
          if vim.fn.exists ":SessionRestore" == 2 then
            vim.cmd "silent! SessionRestore"
          elseif pcall(require, "resession") then
            -- Fallback for AstroNvim/resession users
            require("resession").load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
          end
          -- 4. Notify user
          snacks.notify("Switched to worktree: " .. name, { title = "Worktree" })
        end,
        on_add = function(name, path)
          snacks.notify("Worktree created: " .. name, { type = "success", title = "Worktree" })
          -- Automatically open/focus in Kitty after creation
          open_or_focus(path)
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

    -- Sync current Kitty tab title to match worktree
    vim.keymap.set("n", "<leader>gwo", function()
      local name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      vim.fn.jobstart({ "kitty", "@", "set-tab-title", name }, { detach = true })
      snacks.notify("Kitty tab title updated to: " .. name, { title = "Kitty" })
    end, { desc = "Sync Kitty tab title" })
  end,
}
