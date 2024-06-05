return {
  "AstroNvim/astrolsp",
  ---@param opts AstroLSPOpts
  opts = function(_, opts)
    require("astrocore").extend_tbl(opts.config, {
      eslint = {
        settings = {
          ---@diagnostic disable-next-line: missing-fields
          eslint = {
            enable = true,
            autoFixOnSave = true,
            format = { enable = true },
          },
        },
        condition = function(utils) return utils.root_has_file ".eslintrc.json" or utils.root_has_file ".eslintrc.js" end,
      },
    })
  end,
}
