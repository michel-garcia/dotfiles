-- General --
vim.opt.clipboard = "unnamedplus"
vim.opt.encoding = "utf-8"
vim.opt.mouse:append("a")
vim.opt.swapfile = false

-- Rendering --
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 5
vim.opt.termguicolors = true

-- Interface --
vim.opt.cmdheight = 2
vim.opt.colorcolumn = {}
vim.opt.cursorline = false
vim.opt.guicursor = "i:block"
vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.pumheight = 10
vim.opt.showcmd = false
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true
vim.opt.showmode = false

-- Indentation --
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = {
    space = "·",
    tab = "··"
}
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- Folding --
vim.opt.foldenable = false
vim.opt.foldmethod = "indent"

-- Panes --
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Search --
vim.opt.hlsearch = false
vim.opt.inccommand = "nosplit"
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Explorer --
vim.g.netrw_banner = 0

