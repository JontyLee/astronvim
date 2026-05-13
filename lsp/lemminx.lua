return {
  settings = {
    xml = {
      server = {
        workDir = "~/.cache/lemminx",
      },
      format = {
        splitAttributes = false,
        joinCDATALines = false,
        joinContentLines = false,
        joinCommentLines = false,
        formatComments = false,
        spaceBeforeEmptyCloseTag = false,
      },
      capabilities = {
        formatting = true,
      },
      completion = {
        autoCloseTags = true,
      },
      useCache = false,
      validation = {
        noGrammar = "info",
        schema = true,
      },
    },
  },
}
