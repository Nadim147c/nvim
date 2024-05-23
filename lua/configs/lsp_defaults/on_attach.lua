return function(_, bufnr)
    local function opts(desc)
        return { buffer = bufnr, desc = "LSP " .. desc }
    end

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
    vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
    vim.keymap.set("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

    vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts "List workspace folders")

    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")

    vim.keymap.set("n", "<leader>ra", function()
        return ":IncRename " .. vim.fn.expand "<cword>"
    end, { expr = true })

    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts "Show references")

    -- setup signature popup
    -- if conf.signature and client.server_capabilities.signatureHelpProvider then
    --   require("nvchad.lsp.signature").setup(client, bufnr)
    -- end
end
