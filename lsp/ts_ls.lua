local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf_request_sync(0, "workspace/executeCommand", params, 500)
end

return {
  init_options = { preferences = { disableSuggestions = false } },
  commands = { OrganizeImports = { organize_imports, description = "Organize Imports" } },
}
