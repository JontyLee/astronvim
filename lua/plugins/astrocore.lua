local get_session_name = function()
  local name = vim.fn.getcwd()
  local branch = vim.fn.system "git branch --show-current"
  if vim.v.shell_error == 0 then
    return name .. vim.trim(branch --[[@as string]])
  else
    return name
  end
end

-- local og_virt_text
-- local og_virt_line

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
      diagnostics = true,
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

    treesitter = {
      indent = true, -- enable/disable treesitter based indentation
      auto_install = true, -- enable/disable automatic installation of detected languages
      ensure_installed = {
        "lua",
        "vim",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "gotmpl",
        "json",
        "jsonc",
        "php",
        "javascript",
        "vue",
        "typescript",
        "css",
        "html",
        "http",
        "yaml",
        "xml",
        "dockerfile",
        "bash",
        "markdown",
        "markdown_inline",
        "toml",
      },
    },

    diagnostics = {
      virtual_text = true,
      virtual_lines = { current_line = true },
      underline = true,
      update_in_insert = false,
    },

    autocmds = {
      -- first key is the augroup name
      heirline_colors = {
        {
          event = "User",
          pattern = "AstroColorScheme",
          desc = "Refresh heirline colors",
          callback = function()
            if package.loaded["heirline"] then require("astroui.status.heirline").refresh_colors() end
          end,
        },
      },
      terminal_settings = {
        -- the value is a list of autocommands to create
        {
          -- event is added here as a string or a list-like table of events
          event = "TermOpen",
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Disable line number/fold column/sign column for terminals",
          callback = function()
            vim.opt_local.number = false
            vim.opt_local.relativenumber = false
            vim.opt_local.foldcolumn = "0"
            vim.opt_local.signcolumn = "no"
          end,
        },
      },
      -- diagnostic_only_virtlines = {
      --   {
      --     event = { "CursorMoved", "DiagnosticChanged" },
      --     callback = function()
      --       local bufnr = vim.api.nvim_get_current_buf()
      --       if not require("astrocore.buffer").is_valid(bufnr) or vim.bo[bufnr].buftype == "terminal" then return end
      --
      --       -- 1. 捕捉原始配置            if og_virt_line == nil then og_virt_line = vim.diagnostic.config().virtual_lines end
      --       if og_virt_text == nil then og_virt_text = vim.diagnostic.config().virtual_text end
      --
      --       -- 2. 检查功能是否启用
      --       if not (og_virt_line and og_virt_line.current_line) then return end
      --
      --       -- 3. 计算当前行是否有诊断
      --       local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
      --       local has_diagnostics = not vim.tbl_isempty(vim.diagnostic.get(bufnr, { lnum = lnum }))
      --       local new_virt_text_state = not has_diagnostics and og_virt_text or false
      --
      --       -- 4. 性能优化：只有在配置确实需要变化时才调用 config
      --       -- config() 是全局刷新，非常昂贵，且容易触发无效 buffer 的 Bug
      --       -- 修复：通过传入 bufnr 参数，仅针对当前 buffer 修改配置，避免全局刷新
      --       local current_state = vim.diagnostic.config(nil, bufnr).virtual_text
      --       if vim.inspect(current_state) ~= vim.inspect(new_virt_text_state) then
      --         -- 使用 pcall 屏蔽 Neovim 内部刷新无效缓冲区时的错误 (Invalid buffer id)
      --         pcall(vim.diagnostic.config, { virtual_text = new_virt_text_state }, bufnr)
      --       end
      --     end,
      --   },
      --   -- {
      --   --   event = "ModeChanged",
      --   --   callback = function()
      --   --     local bufnr = vim.api.nvim_get_current_buf()
      --   --     if require("astrocore.buffer").is_valid(bufnr) then
      --   --       -- 同样使用 pcall 保证稳定性
      --   --       pcall(vim.diagnostic.show, nil, bufnr)
      --   --     end
      --   --   end,
      --   -- },
      -- },
      -- insert_level_auto_save = {
      --   {
      --     event = { "InsertLeave", "TextChanged" },
      --     pattern = { "*" },
      --     command = "silent! wall",
      --     nested = true,
      --   },
      -- },
      -- sync_outer_change = {
      --   {
      --     event = { "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" },
      --     callback = function()
      --       if vim.fn.mode() ~= "c" then
      --         vim.schedule(function()
      --           -- 增加对无效 buffer 和特殊窗口的过滤，进一步防止 E565
      --           local bufnr = vim.api.nvim_get_current_buf()
      --           if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype == "terminal" then return end
      --           pcall(vim.cmd, "checktime")
      --         end)
      --       end
      --     end,
      --     pattern = { "*" },
      --   },
      -- },
      lsp_reload_on_change = {
        --   {
        --     event = "FileChangedShellPost",
        --     callback = function(args)
        --       if not vim.api.nvim_buf_is_valid(args.buf) then return end
        --       -- 如果缓冲区已经有本地修改，不做任何事，让用户处理冲突
        --       if vim.bo[args.buf].modified then return end
        --
        --       -- 关键优化：不再手动触发 BufReadPost 或任何重型的 LSP 刷新
        --       -- 当 checktime 加载新内容后，Neovim 的内置 LSP 监听器会自动、异步地同步变更。
        --       -- 我们只做一个轻量级的通知，告知用户文件已同步。
        --       vim.schedule(function()
        --         if vim.api.nvim_buf_is_valid(args.buf) then
        --           vim.notify(
        --             "File updated by external tool.",
        --             vim.log.levels.INFO,
        --             { title = "AstroCore", render = "minimal" }
        --           )
        --         end
        --       end)
        --     end,
        --   },
        {
          event = "User",
          pattern = "GitSignsUpdate",
          callback = function()
            if vim.fn.mode() ~= "c" then
              -- 使用 schedule 避免在 textlock 期间执行 checktime 导致 E565 错误
              vim.schedule(function()
                local bufnr = vim.api.nvim_get_current_buf()
                if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype == "terminal" then return end
                pcall(vim.cmd, "checktime")
              end)
            end
          end,
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
      -- smoothcursor_mod_change = {
      --   {
      --     event = { "ModeChanged" },
      --     callback = function()
      --       local current_mode = vim.fn.mode()
      --       if current_mode == "n" then
      --         vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#FFD400" })
      --         vim.fn.sign_define("smoothcursor", { text = "󰒊 " })
      --       elseif current_mode == "v" then
      --         vim.api.nvim_set_hl(0, "SmoothCursorYellow", { fg = "#FFFF00" })
      --         vim.fn.sign_define("smoothcursor", { text = "󰒅 " })
      --       elseif current_mode == "V" then
      --         vim.api.nvim_set_hl(0, "SmoothCursorAqua", { fg = "#00FFFF" })
      --         vim.fn.sign_define("smoothcursor", { text = " " })
      --       elseif current_mode == "^V" then
      --         vim.api.nvim_set_hl(0, "SmoothCursorRed", { fg = "#FF0000" })
      --         vim.fn.sign_define("smoothcursor", { text = "󱊁 " })
      --       elseif current_mode == "i" then
      --         vim.api.nvim_set_hl(0, "SmoothCursorOrange", { fg = "#FFA500" })
      --         vim.fn.sign_define("smoothcursor", { text = "󱦹 " })
      --       end
      --     end,
      --   },
      -- },
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
        expandtab = true,
        pumblend = 4,
        guifont = "Maple Mono NF CN:h20",
        autoread = true,
        updatetime = 250,
        winborder = "none",
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
          function()
            vim.schedule(function() require("snacks").picker.buffers() end)
          end,
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
        ["<M-,>"] = { [[<C-\><C-n>]] },
      },
    },
  },
}
