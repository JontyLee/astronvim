return {
  "AstroNvim/astrolsp",
  optional = true,
  ---@param opts AstroLSPOpts
  opts = function(_, opts)
    require("astrocore").extend_tbl(opts.config, {
      lemminx = {
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
              enabled = true,
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
              enabled = true,
              schema = true,
            },
          },
        },
      },
    })
  end,
}
