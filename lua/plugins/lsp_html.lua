return {
  "AstroNvim/astrolsp",
  optional = true,
  ---@param opts AstroLSPOpts
  opts = function(_, opts)
    require("astrocore").extend_tbl(opts.config, {
      html = {
        settings = {
          ---@diagnostic disable-next-line: missing-fields
          html = {
            format = {
              indentHandlebars = true,
              indentInnerHtml = true,
              mirrorCursorOnMatchingTag = true,
              templating = true,
            },
          },
        },
      },
    })
  end,
}
