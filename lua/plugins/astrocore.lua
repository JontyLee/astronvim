-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

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
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = false,
      underline = true,
      virtual_lines = {
        only_current_line = true,
      },
      update_in_insert = false,
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
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
        autopairs_enabled = true, -- enable autopairs at start
        icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
        ui_notifications_enabled = true, -- disable notifications when toggling UI elements
        resession_enabled = true, -- enable experimental resession.nvim session management (will be default in AstroNvim v4)
        guifont = "JetBrainsMono_Nerd_Font:h13.5:#h-normal",
        inlayhints = true,
        header_max_size = 100,
        header_alignment = 1,
        header_field_filename = 1,
        header_field_filename_path = 1,
        header_field_author = "jianlin6",
        header_field_modified_timestamp = 0,
        header_field_modified_by = 0,
        header_field_timestamp_format = "%Y-%m-%d %T",
        ruby_host_prog = "~/.rbenv/shims/neovim-ruby-host",
      },
      o = { autoread = true },
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

        -- comment
        ["<Leader>/"] = { "<Cmd>lua require('Comment.api').toggle.linewise.current()<CR>", desc = "󰆉 Comment" },
        -- neogen
        ["<Leader>a"] = { desc = "󰏫 Annotate" },
        ["<Leader>a<cr>"] = { function() require("neogen").generate {} end, desc = "Current" },
        ["<Leader>ac"] = { function() require("neogen").generate { type = "class" } end, desc = "Class" },
        ["<Leader>af"] = { function() require("neogen").generate { type = "func" } end, desc = "Function" },
        ["<Leader>at"] = { function() require("neogen").generate { type = "type" } end, desc = "Type" },
        ["<Leader>aF"] = { function() require("neogen").generate { type = "file" } end, desc = "File" },

        ["<Leader>c"] = { desc = "󰶽 Close buffer" },
        ["<Leader>C"] = { desc = "󰅞 Force close buffer" },

        -- second key is the lefthand side of the map

        -- tables with the `name` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>e"] = { "<Cmd>Neotree reveal toggle<CR>", desc = " Explore" },
        -- find
        ["<Leader>f"] = { desc = " Find" },

        -- git
        ["<Leader>g"] = { desc = " Git" },

        ["<Leader>h"] = { desc = "󱉑 Home screen" },

        ["<Leader>i"] = { desc = " Portal forward" },
        ["<Leader>o"] = { desc = " Portal backward" },
        ["<Leader>q"] = { desc = " Quit window" },
        ["<Leader>Q"] = { desc = "󰿅 Quit astro" },
        ["<Leader>w"] = { desc = "󰳻 Save" },
        ["<Leader>W"] = { desc = "󱑛 Suda save" },

        -- lsp
        ["<Leader>l"] = { desc = " LSP" },

        ["<Leader>n"] = { desc = "󰈚 New file" },

        -- run
        ["<Leader>r"] = { desc = " Run" },
        ["<Leader>rm"] = { "<Cmd>MarkdownPreviewToggle<CR>", desc = "Run markdown_preview" },
        -- upload file
        ["<Leader>uf"] = { "<Cmd>:call SyncUploadFile()<CR>", desc = "Upload file" },

        -- better buffer navigation
        ["<Tab>"] = {
          function()
            if #vim.t.bufs > 1 then
              require("telescope.builtin").buffers { sort_mru = true, ignore_current_buffer = true }
            else
              require("astrocore").notify "No other buffers open"
            end
          end,
          desc = "Switch Buffers",
        },
      },
    },
  },
}
