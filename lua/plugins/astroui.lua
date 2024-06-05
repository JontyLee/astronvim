-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local set_theme = function()
  local _time = os.date "*t"
  if _time.hour >= 1 and _time.hour < 9 then
    return "kanagawa"
  elseif _time.hour >= 17 and _time.hour < 21 then
    return "catppuccin-mocha"
  elseif (_time.hour >= 21 and _time.hour < 24) or (_time.hour >= 0 and _time.hour < 1) then
    return "nightfox"
  else
    return "tokyonight"
  end
end

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = set_theme(),
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Normal = { bg = "#000000" },
      },
      astrodark = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      -- LSPLoading1 = "⠋",
      -- LSPLoading2 = "⠙",
      -- LSPLoading3 = "⠹",
      -- LSPLoading4 = "⠸",
      -- LSPLoading5 = "⠼",
      -- LSPLoading6 = "⠴",
      -- LSPLoading7 = "⠦",
      -- LSPLoading8 = "⠧",
      -- LSPLoading9 = "⠇",
      -- LSPLoading10 = "⠏",
      ActiveLSP = " ",
      ActiveTS = " ",
      ArrowLeft = " ",
      ArrowRight = " ",
      BufferClose = "󰅖",
      DapBreakpoint = " ",
      DapBreakpointCondition = " ",
      DapBreakpointRejected = " ",
      DapLogPoint = ".>",
      DapStopped = "󰁕 ",
      DefaultFile = "󰈙 ",
      Diagnostic = "󰒡 ",
      DiagnosticError = " ",
      DiagnosticHint = " ",
      DiagnosticInfo = "",
      DiagnosticWarn = " ",
      Ellipsis = "…",
      FileModified = "",
      FileReadOnly = " ",
      FoldClosed = "",
      FoldOpened = "",
      FoldSeparator = " ",
      FolderClosed = " ",
      FolderEmpty = " ",
      FolderOpen = " ",
      Git = " ",
      GitAdd = " ",
      GitBranch = " ",
      GitChange = " ",
      GitConflict = "",
      GitDelete = " ",
      GitIgnored = "◌",
      GitRenamed = " ",
      GitStaged = " ",
      GitUnstaged = "󱍯 ",
      GitUntracked = "",
      LSPLoaded = " ",
      LSPLoading1 = " ",
      LSPLoading2 = "󰀚 ",
      LSPLoading3 = " ",
      MacroRecording = " ",
      Paste = "󰅌 ",
      Search = " ",
      Selected = "❯",
      Spellcheck = "󰓆 ",
      TabClose = "󰅙 ",
      VimIcon = " ",
    },
    text_icons = {
      ActiveLSP = "LSP:",
      ArrowLeft = "<",
      ArrowRight = ">",
      BufferClose = "x",
      DapBreakpoint = "B",
      DapBreakpointCondition = "C",
      DapBreakpointRejected = "R",
      DapLogPoint = "L",
      DapStopped = ">",
      DefaultFile = "[F]",
      DiagnosticError = "X",
      DiagnosticHint = "?",
      DiagnosticInfo = "i",
      DiagnosticWarn = "!",
      Ellipsis = "...",
      FileModified = "*",
      FileReadOnly = "[lock]",
      FoldClosed = "+",
      FoldOpened = "-",
      FoldSeparator = " ",
      FolderClosed = "[D]",
      FolderEmpty = "[E]",
      FolderOpen = "[O]",
      GitAdd = "[+]",
      GitChange = "[/]",
      GitConflict = "[!]",
      GitDelete = "[-]",
      GitIgnored = "[I]",
      GitRenamed = "[R]",
      GitStaged = "[S]",
      GitUnstaged = "[U]",
      GitUntracked = "[?]",
      MacroRecording = "Recording:",
      Paste = "[PASTE]",
      Search = "?",
      Selected = "*",
      Spellcheck = "[SPELL]",
      TabClose = "X",
    },
    status = {
      separators = { left = { "", "  " }, right = { " ", "" } },
      colors = function(hl)
        local get_hlgroup = require("astroui").get_hlgroup
        -- use helper function to get highlight group properties
        local comment_fg = get_hlgroup("Comment").fg
        hl.git_branch_fg = comment_fg
        hl.git_added = comment_fg
        hl.git_changed = comment_fg
        hl.git_removed = comment_fg
        hl.blank_bg = get_hlgroup("Folded").fg
        hl.file_info_bg = get_hlgroup("Visual").bg
        hl.nav_icon_bg = get_hlgroup("String").fg
        hl.nav_fg = hl.nav_icon_bg
        hl.folder_icon_bg = get_hlgroup("Error").fg
        return hl
      end,
      attributes = {
        mode = { bold = true },
      },
      icon_highlights = {
        file_icon = {
          statusline = false,
        },
      },
    },
  },
}
