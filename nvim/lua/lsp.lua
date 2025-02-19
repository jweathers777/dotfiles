local lspconfig = require("lspconfig")

-- Rust
lspconfig.rust_analyzer.setup{
    settings = {
        ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy" },
        }
    }
}

-- Python
lspconfig.pyright.setup{}

-- Ruby
lspconfig.solargraph.setup{}

-- Haskell
lspconfig.hls.setup{}

-- Keybindings for LSP
local map = vim.keymap.set
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to Definition" })
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Show Hover Info" })
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Go to Implementation" })
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Find References" })
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename Symbol" })
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code Actions" })
