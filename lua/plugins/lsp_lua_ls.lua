return {
  "AstroNvim/astrolsp",
  optional = true,
  ---@param opts AstroLSPOpts
  opts = function(_, opts)
    require("astrocore").extend_tbl(opts.config, {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Both",
              enable = true,
              autoRequire = true,
              displayContext = 5,
              keywordSnippet = "Both",
              postfix = "@",
              showParams = true,
              showWord = "Fallback",
              workspaceWord = true,
            },
            diagnostics = {
              enable = false,
            },
            hint = {
              enable = true,
              arrayIndex = "Auto",
              await = true,
              paramName = "All",
              paramType = true,
              semicolon = "SameLine",
              setType = false,
            },
          },
        },
      },
    })
  end,
}
