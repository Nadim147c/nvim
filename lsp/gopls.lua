return {
  settings = {
    gopls = {
      analyses = {
        -- fieldalignment = true,
        -- nilness = true,
        unusedparams = true,
        unusedwrite = true,
        -- useany = true,
      },
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      completeUnimported = true,
      gofumpt = true,
      hints = { constantValues = true },
      semanticTokens = true,
      staticcheck = true,
      usePlaceholders = true,
    },
  },
}
