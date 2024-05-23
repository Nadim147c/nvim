return function(client, _)
    if client.supports_method "textDocument/semanticTokens" then
        client.server_capabilities.semanticTokensProvider = nil
    end
end
