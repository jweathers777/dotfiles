-- Ensure Lazy.nvim is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin management with Lazy.nvim
require("lazy").setup({
    -- File Navigation
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    {
        "nvim-tree/nvim-tree.lua",
        lazy = true,  -- Load only when needed
        cmd = { "NvimTreeToggle", "NvimTreeOpen" },  -- Auto-load when these commands are used
        config = function()
            require("nvim-tree").setup()
        end,
    },
    
    -- Search & Replace
    { "nvim-pack/nvim-spectre" },
    
    -- UI Enhancements
    { "folke/which-key.nvim" },
    { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
    { "gruvbox-community/gruvbox" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    {
        "numToStr/Comment.nvim",
        lazy = false,  -- Load immediately
        config = function()
            require("Comment").setup()
        end,
    },
    
    -- Language Support
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer" } },
    { "L3MON4D3/LuaSnip" },
    { "mrcjkb/haskell-tools.nvim", version = "^4", lazy = false },
    
    -- Debugging
    { "mfussenegger/nvim-dap" }, -- Debug Adapter Protocol (DAP)
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } }, -- UI for DAP
    { "theHamsta/nvim-dap-virtual-text" },  -- Inline debugging info
    { "nvim-telescope/telescope-dap.nvim" }, -- DAP integration with Telescope
    
    -- Miscellaneous
    { "tpope/vim-surround" },
    { "tpope/vim-repeat" },
    { "tpope/vim-fugitive" },
})

-- Load settings and keymaps
require("settings")
require("keymaps")
require("lsp")
require("dap")
require("dapui")
require("dap-virtual-text")
require("telescope").load_extension("dap")
require("completion")
