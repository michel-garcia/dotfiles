local files = vim.api.nvim_get_runtime_file("lua/user/plugins/**/*.lua", true)
local specs = vim.iter(files):fold({}, function(specs, path)
    local basename = vim.fn.fnamemodify(path, ":s?.*lua/user/plugins/??:r")
    local modname = string.format("user.plugins.%s", basename)
    local ok, res = pcall(require, modname)
    if not ok or type(res) ~= "table" then
        local msg = table.concat({
            string.format("Failed to load: %s", basename),
            res,
        }, "\n")
        vim.notify(msg, vim.log.levels.ERROR)
        return specs
    end
    local items = vim.islist(res) and res or { res }
    for _, item in ipairs(items) do
        local name = item[1] or nil
        if name and type(name) == "string" then
            local spec = {
                src = table.concat({ "https://github.com/", name }, "/"),
                data = {
                    config = item.config,
                },
            }
            table.insert(specs, spec)
        end
    end
    return specs
end)
vim.pack.add(specs, {
    confirm = false,
})
for _, spec in ipairs(specs) do
    if spec.data.config and vim.is_callable(spec.data.config) then
        spec.data.config()
    end
end
