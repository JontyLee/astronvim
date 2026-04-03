return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>ae", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
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
      terminal_cmd = "wecode",
      focus_after_send = true,
      terminal = {
        split_side = "right",
        split_width_percentage = 0.45, -- 恢复并微调到 45% 宽度
        provider = "snacks",
        auto_close = true,
        -- 修正 snacks 窗口配置，删除错误的全局变量 laststatus
        snacks_win_opts = {
          wo = {
            winfixwidth = true,
            number = false,
            relativenumber = false,
            signcolumn = "no",
            statuscolumn = "",
            foldcolumn = "0",
            winbar = "",
          },
        },
        cwd_provider = function(ctx)
          -- Prefer repo root; fallback to file's directory
          local cwd = require("claudecode.cwd").git_root(ctx.file_dir or ctx.cwd) or ctx.file_dir or ctx.cwd
          return cwd
        end,
      },
    },
  },
  {
    "pittcat/claude-fzf-history.nvim",
    dependencies = { "ibhagwan/fzf-lua" },
    config = function() require("claude-fzf-history").setup() end,
    cmd = { "ClaudeHistory", "ClaudeHistoryDebug" },
    keys = {
      { "<leader>ah", "<cmd>ClaudeHistory<cr>", desc = "Claude History" },
    },
  },
  {
    "pittcat/claude-fzf.nvim",
    dependencies = {
      "ibhagwan/fzf-lua",
      "coder/claudecode.nvim",
    },
    opts = {
      auto_context = true,
      batch_size = 10,
    },
    cmd = {
      "ClaudeFzf",
      "ClaudeFzfFiles",
      "ClaudeFzfGrep",
      "ClaudeFzfBuffers",
      "ClaudeFzfGitFiles",
      "ClaudeFzfDirectory",
    },
    keys = {
      { "<leader>af", "<cmd>ClaudeFzfFiles<cr>", desc = "Claude: 添加文件" },
      { "<leader>aff", "<cmd>ClaudeFzfGrep<cr>", desc = "Claude: 搜索并添加" },
      { "<leader>afb", "<cmd>ClaudeFzfBuffers<cr>", desc = "Claude: 添加缓冲区" },
      { "<leader>afg", "<cmd>ClaudeFzfGitFiles<cr>", desc = "Claude: 添加 Git 文件" },
      { "<leader>afd", "<cmd>ClaudeFzfDirectory<cr>", desc = "Claude: 添加目录文件" },
    },
  },
}
