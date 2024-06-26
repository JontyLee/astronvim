return {
  "gen740/SmoothCursor.nvim",
  event = "VeryLazy",
  config = function()
    require("smoothcursor").setup {
      autostart = true,
      cursor = "󰒊 ",
      texthl = "SmoothCursor", -- highlight group, default is { bg = nil, fg = "#FFD400" }
      linehl = "CursorLine", -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
      type = "exp", -- define cursor movement calculate function, "default" or "exp" (exponential).
      fancy = {
        enable = true, -- enable fancy mode
        -- head = { cursor = "󰒊 ", texthl = "SmoothCursor", linehl = "CursorLine" },
        body = {
          { cursor = " ", texthl = "SmoothCursorRed" },
          { cursor = " ", texthl = "SmoothCursorOrange" },
          { cursor = "●", texthl = "SmoothCursorYellow" },
          { cursor = "●", texthl = "SmoothCursorGreen" },
          { cursor = "•", texthl = "SmoothCursorAqua" },
          { cursor = ".", texthl = "SmoothCursorBlue" },
          { cursor = ".", texthl = "SmoothCursorPurple" },
        },
        -- tail = { cursor = nil, texthl = "SmoothCursor" },
      },
      flyin_effect = "bottom", -- "bottom" or "top"
      speed = 25, -- max is 100 to stick to your current position
      intervals = 35, -- tick interval
      priority = 10, -- set marker priority
      timeout = 3000, -- timout for animation
      threshold = 1, -- animate if threshold lines jump
      disable_float_win = true, -- disable on float window
      enabled_filetypes = nil, -- example: { "lua", "vim" }
      -- disabled_filetypes = {
      --   "TelescopePrompt",
      --   "NvimTree",
      --   "neo-tree",
      --   "help",
      --   "startify",
      --   "aerial",
      --   "alpha",
      --   "dashboard",
      --   "lazy",
      --   "neogitstatus",
      --   "Trouble",
      --   "nofile",
      --   "terminal",
      -- }, -- this option will be skipped if enabled_filetypes is set. example: { "TelescopePrompt", "NvimTree" }
      disabled_filetypes = { "fzf", "neo-tree", "lazy", "", "DiffviewFiles" },
    }
  end,
}
