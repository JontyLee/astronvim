-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

-- function for calculating the current session name
local get_session_name = function()
  local name = vim.fn.getcwd()
  local branch = vim.fn.system "git branch --show-current"
  if vim.v.shell_error == 0 then
    return name .. vim.trim(branch --[[@as string]])
  else
    return name
  end
end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
      signature_help = true,
    },
    git_worktrees = {
      {
        toplevel = vim.env.HOME,
        gitdir = vim.env.HOME .. "/.dotfiles",
      },
    },
    sessions = {
      -- disable the auto-saving of directory sessions
      autosave = { cwd = false },
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
        http = "http",
        phtml = "phtml",
      },
      filename = {
        [".foorc"] = "fooscript",
        ["go.mod"] = "gomod",
        ["go.sum"] = "gosum",
        ["go.work"] = "gowork",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },

    autocmds = {
      insert_level_auto_save = {
        {
          event = { "InsertLeave", "TextChanged" },
          pattern = { "*" },
          command = "silent! wall",
          nested = true,
        },
      },
      sync_outer_change = {
        {
          event = { "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" },
          command = "if mode() != 'c' | checktime | endif",
          pattern = { "*" },
        },
      },
      git_branch_sessions = {
        -- auto save directory sessions on leaving
        {
          event = "VimLeavePre",
          desc = "Save git branch directory sessions on close",
          callback = vim.schedule_wrap(function()
            if require("astrocore.buffer").is_valid_session() then
              require("resession").save(get_session_name(), { dir = "dirsession", notify = false })
            end
          end),
        },
        -- auto restore previous previous directory session, remove if necessary
        -- {
        --   event = "VimEnter",
        --   desc = "Restore previous directory session if neovim opened with no arguments",
        --   nested = true, -- trigger other autocommands as buffers open
        --   callback = function()
        --     -- Only load the session if nvim was started with no args
        --     if vim.fn.argc(-1) == 0 then
        --       -- try to load a directory session using the current working directory
        --       require("resession").load(get_session_name(), { dir = "dirsession", silence_errors = true })
        --     end
        --   end,
        -- },
      },
      smoothcursor_mod_change = {
        {
          event = { "ModeChanged" },
          callback = function()
            local current_mode = vim.fn.mode()
            if current_mode == "n" then
              vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#FFD400" })
              vim.fn.sign_define("smoothcursor", { text = "󰒊 " })
            elseif current_mode == "v" then
              vim.api.nvim_set_hl(0, "SmoothCursorYellow", { fg = "#FFFF00" })
              vim.fn.sign_define("smoothcursor", { text = "󰒅 " })
            elseif current_mode == "V" then
              vim.api.nvim_set_hl(0, "SmoothCursorAqua", { fg = "#00FFFF" })
              vim.fn.sign_define("smoothcursor", { text = " " })
            elseif current_mode == "^V" then
              vim.api.nvim_set_hl(0, "SmoothCursorRed", { fg = "#FF0000" })
              vim.fn.sign_define("smoothcursor", { text = "󱊁 " })
            elseif current_mode == "i" then
              vim.api.nvim_set_hl(0, "SmoothCursorOrange", { fg = "#FFA500" })
              vim.fn.sign_define("smoothcursor", { text = "󱦹 " })
            end
          end,
        },
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        shiftwidth = 4,
        tabstop = 4,
        pumblend = 4,
        guifont = "Maple Mono NF CN:h20",
        autoread = true,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        ["<Leader>/"] = { desc = "󰆉 Toggle comment line" },

        ["<Leader>c"] = { desc = "󰶽 Close buffer" },
        ["<Leader>C"] = { desc = "󰅞 Force close buffer" },

        ["<Leader>e"] = { "<Cmd>Neotree reveal toggle<CR>", desc = " Toggle explore" },
        ["<Leader>h"] = { desc = "󱉑 Home screen" },

        ["<Leader>i"] = { desc = " Portal forward" },
        ["<Leader>o"] = { desc = " Portal backward" },
        ["<Leader>q"] = { desc = " Quit window" },
        ["<Leader>Q"] = { desc = "󰿅 Quit astro" },
        ["<Leader>w"] = { desc = "󰳻 Save" },
        ["<Leader>W"] = { desc = "󱑛 Suda save" },
        ["<Leader>l"] = { desc = " LSP" },
        ["<Leader>n"] = { desc = "󰈚 New file" },

        -- git
        ["<Leader>g"] = { desc = " Git" },
        ["<Leader>gd"] = { desc = "Diffview" },
        ["<Leader>gdc"] = { "<Cmd>DiffviewClose<CR>", desc = "DiffviewClose" },
        ["<Leader>gdf"] = { "<Cmd>DiffviewFocusFiles<CR>", desc = "DiffviewFocusFiles" },
        ["<Leader>gdh"] = { "<Cmd>DiffviewFileHistory<CR>", desc = "DiffviewFileHistory" },
        ["<Leader>gdL"] = { "<Cmd>DiffviewLog<CR>", desc = "DiffviewLog" },
        ["<Leader>gdo"] = { "<Cmd>DiffviewOpen<CR>", desc = "DiffviewOpen" },
        ["<Leader>gdt"] = { "<Cmd>DiffviewToggleFiles<CR>", desc = "DiffviewToggleFiles" },
        ["<Leader>gdr"] = { "<Cmd>DiffviewRefresh<CR>", desc = "DiffviewRefresh" },

        ["<Leader>sj"] = { function() require("snacks").picker.jumps() end, desc = "Jump files" },
        ["<Leader>sm"] = { function() require("snacks").picker.marks() end, desc = "Show marks" },
        ["<Leader>st"] = { function() require("snacks").picker.todo_comments() end, desc = "Todos" },
        ["<Leader>ud"] = {
          "<cmd>TransferDownload<cr>",
          desc = "Download from remote server (scp)",
        },
        ["<Leader>uf"] = {
          "<cmd>DiffRemote<cr>",
          desc = "Diff file with remote server (scp)",
        },
        ["<Leader>ui"] = {
          "<cmd>TransferInit<cr>",
          desc = "Init/Edit Deployment config",
        },
        ["<Leader>ur"] = {
          "<cmd>TransferRepeat<cr>",
          desc = "Repeat transfer command",
        },
        ["<Leader>uu"] = {
          "<cmd>TransferUpload<cr>",
          desc = "Upload to remote server (scp)",
        },
        -- better buffer navigation
        ["<Tab>"] = {
          function() require("snacks").picker.buffers() end,
          desc = "Switch Buffers",
        },

        ["<Leader>SS"] = {
          function() require("resession").save(get_session_name(), { dir = "dirsession" }) end,
          desc = "Save this dirsession",
        },
        -- update load dirsession mapping to get the correct session name
        ["<Leader>S."] = {
          function() require("resession").load(get_session_name(), { dir = "dirsession" }) end,
          desc = "Load current dirsession",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
      t = {
        ["<Esc>"] = { [[<C-\><C-n>]] },
      },
    },
  },
}
