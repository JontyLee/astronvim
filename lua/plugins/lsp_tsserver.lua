return {
  "AstroNvim/astrolsp",
  optional = true,
  ---@param opts AstroLSPOpts
  opts = function(_, opts)
    require("astrocore").extend_tbl(opts.config, {
      volar = {
        init_options = {
          typescript = {
            tsdk = "/opt/homebrew/lib/node_modules/typescript/lib",
          },
        },
        filetypes = { "vue" },
        settings = {
          vue = {
            inlayHints = {
              inlineHandlerLeading = true,
              missingProps = true,
              optionsWrapper = true,
            },
          },
        },
      },
    })
  end,
}
