return {
  "nvimdev/lspsaga.nvim",
  branch = "main",
  event = "LspAttach",
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
  opts = {
    preview = {
      lines_above = 1,
      lines_below = 17,
    },
    scroll_preview = {
      scroll_down = "<C-j>",
      scroll_up = "<C-k>",
    },
    request_timeout = 3000,
    callhierarchy = {
      edit = "e",
      vsplit = "s",
      split = "i",
      tabe = "t",
      quit = "q",
      shuttle = "[w",
      toggle_or_req = "u",
      close = "<C-c>k",
    },
    finder = {
      keys = {
        shuttle = "[w",
        toggle_or_open = { "<CR>", "o" },
        vsplit = "s",
        split = "i",
        tabe = "t",
        tabnew = "r",
        quit = "q",
        close = "<C-c>k",
      },
      default = "imp+ref",
    },
    definition = {
      edit = "<C-c>o",
      vsplit = "<C-c>v",
      split = "<C-c>s",
      tabe = "<C-c>t",
      quit = "q",
    },
    code_action = {
      num_shortcut = true,
      show_server_name = true,
      extend_gitsigns = true,
      keys = {
        quit = "q",
        exec = "<CR>",
      },
    },
    lightbulb = {
      enable = true,
      sign = true,
      enable_in_insert = true,
      sign_priority = 20,
      virtual_text = false,
    },
    diagnostic = {
      text_hl_follow = true,
      on_insert = true,
      on_insert_follow = false,
      show_code_action = true,
      show_source = true,
      border_follow = true,
      extend_relatedInformation = false,
      jump_num_shortcut = true,
      diagnostic_only_current = false,
      show_layout = "float",
      keys = {
        exec_action = "r",
        quit = "q",
        expand_or_jump = "<CR>",
        quit_in_show = { "q", "<ESC>" },
      },
    },
    rename = {
      quit = { "q", "<ESC>" },
      exec = "<CR>",
      select = "x",
      in_select = false,
    },
    outline = {
      win_position = "right",
      win_with = "_sagaoutline",
      win_width = 30,
      auto_preview = false,
      auto_refresh = true,
      auto_close = true,
      close_after_jump = true,
      keys = {
        toggle_or_jump = { "<CR>", "o" },
        quit = "q",
      },
    },
    symbol_in_winbar = {
      enable = true,
      hide_keyword = true,
      show_file = false,
      color_mode = true,
    },
    implement = {
      enable = true,
      sign = true,
      virtual_text = true,
      priority = 100,
    },
    beacon = {
      enable = true,
      frequency = 12,
    },
    ui = {
      code_action = " ",
      actionfix = "󰁨 ",
      devicon = true,
      title = true,
    },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
}
