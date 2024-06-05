-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
local autocmd = vim.api.nvim_create_autocmd
autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = { "*" },
  command = "silent! wall",
  nested = true,
})
-- autocmd("BufReadPost", {
--   pattern = "*",
--   callback = function()
--     if vim.fn.line "'\"" > 0 and vim.fn.line "'\"" <= vim.fn.line "$" then
--       vim.fn.setpos(".", vim.fn.getpos "'\"")
--       vim.cmd "silent! foldopen"
--     end
--   end,
-- })
autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
    -- require("lazygit.utils").project_root_dir()
  end,
})

autocmd({ "ModeChanged" }, {
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
})

autocmd("TermClose", {
  pattern = "*lazygit*",
  callback = function()
    vim.cmd "silent! :checktime"
    local status_ok, _ = pcall(require, "lspconfig")
    if not status_ok then return end
    vim.cmd "silent! LspRestart"
  end,
})

vim.filetype.add {
  extension = {
    http = "http",
    phtml = "html",
  },
  filename = {
    ["go.mod"] = "gomod",
    ["go.sum"] = "gosum",
    ["go.work"] = "gowork",
  },
}

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
require("astroui").color_scheme = set_theme()
