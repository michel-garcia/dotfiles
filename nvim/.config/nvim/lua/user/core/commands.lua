vim.api.nvim_create_user_command("ReloadConfig", function()
    for name, _ in pairs(package.loaded) do
        if string.sub(name, 0, string.len("user")) == "user" then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    vim.notify("Configuration reloaded!")
end, {})

vim.api.nvim_create_user_command("ResetDiagnostics", function()
    vim.diagnostic.reset()
    vim.notify("Diagnostics reset!")
end, {})
