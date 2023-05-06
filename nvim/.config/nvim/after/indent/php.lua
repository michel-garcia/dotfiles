_G.php_indent = function ()
    return -1
end

vim.opt.autoindent = true
vim.opt.indentexpr = "lua php_indent()"

