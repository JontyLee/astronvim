return {
  filetypes = { "html", "phtml" },
  settings = {
    html = {
      autoClosingTags = true,
      suggest = {
        html5 = true,
      },
      validate = {
        styles = true,
        scripts = true,
      },
      hover = {
        references = true,
        documentation = true,
      },
      format = {
        enable = true,
        indentHandlebars = true,
        indentInnerHtml = true,
        templating = true,
      },
    },
  },
}
