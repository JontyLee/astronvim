return {
  settings = {
    gopls = {
      env = {
        GOOS = "linux",
        GOARCH = "amd64",
      },
      buildFlags = {
        "-tags=unit",
      },
      directoryFilters = {
        "-**node_modules",
        "-.git",
      },
      templateExtensions = { "tmpl" },
      gofumpt = true,
      codelenses = {
        generate = false,
        regenerate_cgo = false,
        run_govulncheck = false,
        test = false,
        tidy = true,
        upgrade_dependency = false,
        vendor = false,
        vulncheck = false,
      },
      analyses = {
        lostcancel = false,
        shadow = true,
      },
      staticcheck = "unset",
      vulncheck = "Off",
      diagnosticsTrigger = "Save",
      hints = {
        assignVariableTypes = false,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      importShortcut = "Definition",
    },
  },
  before_init = function(_, config)
    if vim.fn.executable "go" ~= 1 then return end

    local module = vim.fn.trim(vim.fn.system "go list -m")
    if vim.v.shell_error ~= 0 then return end
    module = module:gsub("\n", ",")

    config.settings.gopls["local"] = module
  end,
}
