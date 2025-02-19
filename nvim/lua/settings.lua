local opt = vim.opt

-- Line Numbers
opt.number = true
opt.relativenumber = true

vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function()
        vim.opt.relativenumber = false
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
        vim.opt.relativenumber = true
    end,
})


-- Tabs & Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.cursorline = true

vim.cmd("colorscheme tokyonight-night")

-- Wrapping
opt.wrap = true
opt.linebreak = true
opt.showbreak = "↵ "

-- Swap & Backup
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Performance
opt.updatetime = 300
opt.timeoutlen = 500

-- Clipboard
opt.clipboard = "unnamedplus"

-- Split Windows
opt.splitbelow = true
opt.splitright = true

-- Misc
opt.mouse = "a"
opt.scrolloff = 8
