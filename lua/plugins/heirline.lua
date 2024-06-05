local mod_icon = function()
  local mod = vim.fn.mode()
  local _time = os.date "*t"

  local selector = math.floor(_time.hour / 8) + 1
  local normal_icons = {
    " 󰊠 ",
    "  ",
    "  ",
  }
  if mod == "n" or mod == "no" or mod == "nov" then
    return normal_icons[selector]
  elseif mod == "i" or mod == "ic" or mod == "ix" then
    local insert_icons = {
      "  ",
      "  ",
      "  ",
    }
    return insert_icons[selector]
  elseif mod == "V" or mod == "v" or mod == "vs" or mod == "Vs" or mod == "cv" then
    local verbose_icons = {
      "  ",
      "  ",
      "  ",
    }
    return verbose_icons[selector]
  elseif mod == "c" or mod == "ce" then
    local command_icons = {
      " 󰏒 ",
      "  ",
      "  ",
    }

    return command_icons[selector]
  elseif mod == "r" or mod == "rm" or mod == "r?" or mod == "R" or mod == "Rc" or mod == "Rv" or mod == "Rv" then
    local replace_icons = {
      "  ",
      "  ",
      "  ",
    }
    return replace_icons[selector]
  end
  return normal_icons[selector]
end

local utils = require "heirline.utils"
local colors = {
  bright_bg = utils.get_highlight("Folded").bg,
  bright_fg = utils.get_highlight("Folded").fg,
  red = utils.get_highlight("DiagnosticError").fg,
  dark_red = utils.get_highlight("DiffDelete").bg,
  green = utils.get_highlight("String").fg,
  blue = utils.get_highlight("Function").fg,
  gray = utils.get_highlight("NonText").fg,
  orange = utils.get_highlight("Constant").fg,
  purple = utils.get_highlight("Statement").fg,
  cyan = utils.get_highlight("Special").fg,
  diag_warn = utils.get_highlight("DiagnosticWarn").fg,
  diag_error = utils.get_highlight("DiagnosticError").fg,
  diag_hint = utils.get_highlight("DiagnosticHint").fg,
  diag_info = utils.get_highlight("DiagnosticInfo").fg,
  git_del = utils.get_highlight("diffDeleted").fg,
  git_add = utils.get_highlight("diffAdded").fg,
  git_change = utils.get_highlight("diffChanged").fg,
}
local mode_names = { -- change the strings if you like it vvvvverbose!
  n = "N",
  no = "N?",
  nov = "N?",
  noV = "N?",
  ["no\22"] = "N?",
  niI = "Ni",
  niR = "Nr",
  niV = "Nv",
  nt = "Nt",
  v = "V",
  vs = "Vs",
  V = "V_",
  Vs = "Vs",
  ["\22"] = "^V",
  ["\22s"] = "^V",
  s = "S",
  S = "S_",
  ["\19"] = "^S",
  i = "I",
  ic = "Ic",
  ix = "Ix",
  R = "R",
  Rc = "Rc",
  Rx = "Rx",
  Rv = "Rv",
  Rvc = "Rv",
  Rvx = "Rv",
  c = "C",
  cv = "Ex",
  r = "...",
  rm = "M",
  ["r?"] = "?",
  ["!"] = "!",
  t = "T",
}
-- Color table for highlights
local mode_color = {
  n = colors.diag_info,
  i = colors.diag_warn,
  v = colors.diag_error,
  [""] = colors.blue,
  V = colors.blue,
  c = colors.cyan,
  no = colors.green,
  s = colors.orange,
  S = colors.orange,
  [""] = colors.orange,
  ic = colors.diag_warn,
  R = colors.diag_hint,
  Rv = colors.diag_hint,
  cv = colors.cyan,
  ce = colors.cyan,
  r = colors.cyan,
  rm = colors.cyan,
  ["r?"] = colors.cyan,
  ["!"] = colors.red,
  t = colors.red,
}
--
local show_mode_color = function()
  local mod = vim.fn.mode()
  return mode_color[mod]
end

-- Displays Macros
local show_macro_recording = function()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return " "
  else
    return "󰕧 " .. recording_register .. " "
  end
end

-- Note that we add spaces separately, so that only the icon characters will be clickable
local DAPMessages = {
  condition = function()
    local session = require("dap").session()
    return session ~= nil
  end,
  provider = function() return "  " .. require("dap").status() .. " " end,
  hl = "Debug",
  {
    provider = " ",
    on_click = {
      callback = function() require("dap").continue() end,
      name = "heirline_dap_continue",
    },
  },
  {
    provider = "",
    on_click = {
      callback = function() require("dap").step_into() end,
      name = "heirline_dap_step_into",
    },
  },
  { provider = " " },
  {
    provider = " ",
    on_click = {
      callback = function() require("dap").step_over() end,
      name = "heirline_dap_step_over",
    },
  },
  { provider = " " },
  {
    provider = "",
    on_click = {
      callback = function() require("dap").step_out() end,
      name = "heirline_dap_step_out",
    },
  },
  { provider = " " },
  {
    provider = " ",
    on_click = {
      callback = function() require("dap").step_back() end,
      name = "heirline_dap_step_back",
    },
  },
  { provider = " " },
  {
    provider = " ",
    on_click = {
      callback = function() require("dap").restart() end,
      name = "heirline_dap_restart",
    },
  },
  { provider = " " },
  {
    provider = " ",
    on_click = {
      callback = function()
        require("dap").terminate()
        require("dapui").close {}
        vim.cmd.redrawstatus()
      end,
      name = "heirline_dap_close",
    },
  },
  { provider = " " },
}

return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"
    status.component.grapple = {
      provider = function()
        local available, grapple = pcall(require, "grapple")
        if available then
          local key = grapple.statusline { buffer = 0 }
          if key ~= nil then return "   " .. key .. " " end
        end
      end,
    }
    opts.statusline = {
      -- default highlight for the entire statusline
      hl = { fg = "fg", bg = "bg" },
      -- each element following is a component in astronvim.utils.status module

      status.component.builder {
        { provider = function() return mod_icon() .. " " .. mode_names[vim.fn.mode()] end },
        -- { provider = function() return mod_icon() .. " " .. vim.fn.mode() end },
        -- enable mode text with padding as well as an icon before it
        -- mode_text = { icon = { kind = custom_mod_icon(), padding = { right = 1, left = 1 } } },
        -- surround the component with a separators
        hl = { fg = "bg" },
        surround = {
          -- it's a left element, so use the left separator
          separator = "left",
          -- set the color of the surrounding based on the current mode using astronvim.utils.status module
          color = function() return { main = show_mode_color(), right = show_mode_color() } end,
        },
        update = {
          "ModeChanged",
          callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end),
        },
      },
      status.component.builder {
        { provider = "" },
        hl = function() return { fg = show_mode_color() } end,
        surround = {
          separator = "left",
          color = function()
            return {
              main = show_mode_color(),
              right = "blank_bg",
            }
          end,
        },
      },

      -- we want an empty space here so we can use the component builder to make a new section with just an empty string
      status.component.builder {
        { provider = show_macro_recording },
        hl = function() return { fg = show_mode_color(), bold = true } end,
        -- define the surrounding separator and colors to be used inside of the component
        -- and the color to the right of the separated out section
        surround = { separator = "left", color = { main = "blank_bg", right = "file_info_bg" } },
        update = {
          "RecordingEnter",
          "RecordingLeave",
          callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end),
        },
      },

      -- add a section for the currently opened file information
      status.component.file_info {
        -- enable the file_icon and disable the highlighting based on filetype
        file_icon = false,
        filename = { fallback = "Empty", modify = ":p:." },
        filetype = false,
        -- add padding
        padding = { right = 1 },
        -- define the section separator
        surround = { separator = "left", condition = false },
      },
      -- add a component for the current git branch if it exists and use no separator for the sections
      status.component.git_branch { surround = { separator = "none" } },
      status.component.grapple,
      -- add a component for the current git diff if it exists and use no separator for the sections
      status.component.git_diff { padding = { left = 1 }, surround = { separator = "none" } },
      -- dap
      DAPMessages,
      -- fill the rest of the statusline
      -- the elements after this will appear in the middle of the statusline
      status.component.fill(),
      status.component.builder {
        { provider = "󱧷" },
        padding = { right = 1 },
      },
      status.component.file_info {
        filename = {
          fname = function(nr) return vim.fn.getcwd(nr) end,
          padding = { right = 1, left = 1 },
        },
        file_icon = false,
        filetype = false,
        file_modified = false,
        file_read_only = false,
        surround = { separator = "none", color = "bg", condition = false },
      },

      status.component.fill(),
      status.component.diagnostics { surround = { separator = "right" } },
      status.component.lsp {
        lsp_progress = false,
        lsp_client_names = {
          icon = { padding = { right = 1 } },
        },
        surround = { separator = "right" },
      },
      status.component.builder {
        { provider = "" },
        padding = { right = 1 },
        hl = { fg = "bg" },
        surround = { separator = "right", color = { main = "nav_icon_bg" } },
      },
      status.component.file_info {
        filetype = { padding = { left = 1 } },
        surround = { separator = "none", color = "file_info_bg", condition = false },
      },
      status.component.nav {
        ruler = { padding = { left = 1 } },
        percentage = { padding = { right = 1 } },
        surround = { separator = "none", color = "file_info_bg" },
      },
    }

    opts.winbar = nil

    opts.tabline[2] = status.heirline.make_buflist {
      {
        provider = function(self) return not self.is_visible and "" or " " end,
        hl = { fg = "nav_fg", bg = "buffer_visible_bg" },
      },
      status.component.tabline_file_info {
        hl = function(self)
          if self.is_visible then
            return { bg = "buffer_bg", italic = true, bold = true }
          else
            return { fg = "#494D56", bg = "buffer_visible_bg", italic = false, bold = false }
          end
        end,
        close_button = false,
      },
      {
        provider = function(self) return not self.is_visible and "" or " " end,
        hl = { fg = "nav_fg", bg = "buffer_visible_bg" },
      },
    }

    opts.tabline[3] = status.component.fill { hl = { bg = "buffer_visible_bg" } }

    return opts
  end,
}
