return {
  settings = {
    vetur = {
      experimental = {
        templateInterpolationService = true,
      },
      format = {
        options = {
          tabSize = 4,
        },
        defaultFormatter = {
          html = "prettier",
          js = "none",
          ts = "none",
        },
        defaultFormatterOptions = {
          prettier = {
            singleAttributePerLine = false,
            tabWidth = 4,
            printWidth = 10000,
          },
        },
      },
      validation = {
        interpolation = true,
        script = false,
        style = true,
        template = true,
        templateProps = true,
      },
    },
  },
}
