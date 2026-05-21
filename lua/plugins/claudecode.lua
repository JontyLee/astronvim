return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    { "<leader>a", nil, desc = "󱙺 AI/Claude Code" },
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    },
    -- Diff management
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
  opts = {
    focus_after_send = true,
    diff_opts = {
      open_in_new_tab = true,
      keep_terminal_focus = true, -- If true, moves focus back to terminal after diff opens
      hide_terminal_in_new_tab = false,
      on_new_file_reject = "close_window", -- "keep_empty" or "close_window"
    },
    terminal = {
      split_side = "right",
      split_width_percentage = 0.45,
      provider = "snacks",
      auto_close = true,
      -- -- 修正 snacks 窗口配置，删除错误的全局变量 laststatus
      -- ---@module "snacks"
      -- ---@type snacks.win.Config|{}
      -- snacks_win_opts = {
      --   wo = {
      --     winfixwidth = true,
      --     number = false,
      --     relativenumber = false,
      --     signcolumn = "no",
      --     statuscolumn = "",
      --     foldcolumn = "0",
      --     winbar = "",
      --   },
      -- },
      --   cwd_provider = function(ctx)
      --     -- Prefer repo root; fallback to file's directory
      --     local cwd = require("claudecode.cwd").git_root(ctx.file_dir or ctx.cwd) or ctx.file_dir or ctx.cwd
      --     return cwd
      --   end,
    },
  },
}
