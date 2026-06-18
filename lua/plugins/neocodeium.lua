return {
  "monkoose/neocodeium",
  event = "LspAttach",
  config = function()
    local neocodeium = require "neocodeium"

    -- neocodeium.setup {
    --   -- 核心：当 blink.cmp 的补全菜单可见时，不要显示 AI 提示
    --   filter = function()
    --     local blink = require "blink.cmp"
    --     return not blink.is_visible()
    --   end,
    -- }

    -- 绑定快捷键
    -- <Alt-f> 采纳 AI 补全 (在 macOS 上可能是 Option-f)
    vim.keymap.set("i", "<C-a>", function() neocodeium.accept() end)
    -- <Alt-[> 和 <Alt-]> 切换上一个/下一个 AI 建议
    vim.keymap.set("i", "<M-]>", function() neocodeium.cycle_or_complete() end)
    vim.keymap.set("i", "<M-[>", function() neocodeium.cycle_or_complete(-1) end)
    -- <Alt-x> 拒绝/清除当前 AI 提示
    vim.keymap.set("i", "<C-x>", function() neocodeium.clear() end)
  end,
}
