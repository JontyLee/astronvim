return {
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      codeLens = {
        enable = true,
      },
      completion = {
        enable = true,
        autoRequire = true,
        callSnippet = "Both",
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
        await = true,
        arrayIndex = "Auto",
        paramName = "All",
        paramType = true,
        semicolon = "SameLine",
        setType = false,
      },
      workspace = {
        ignoreDir = {
          ".vscode",
          ".git",
        },
        ignoreSubmodules = true,
        useGitIgnore = true,
      },
    },
  },
}
