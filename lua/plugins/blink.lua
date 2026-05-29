return {
  "saghen/blink.cmp",
  opts = {
    -- 核心：配置补全菜单的绘制
    completion = {
      menu = {
        draw = {
          -- 定义每一行有哪些列（可以组合或单独成列）
          columns = {
            { "kind_icon", "label", gap = 1 },
            { "source_name" },
          },
          components = {
            source_name = {
              text = function(ctx) return "[" .. ctx.source_name .. "]" end,
            },
          },
        },
      },
    },
  },
}
