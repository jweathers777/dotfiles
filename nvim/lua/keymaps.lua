local map = vim.keymap.set
local comment_api = require("Comment.api")

-- Set Leader Key to ','
vim.g.mapleader = ","

-- File Navigation
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Search Buffers" })

-- Search Across Files
map("n", "<leader>t", "<cmd>Telescope live_grep<cr>", { desc = "Text Search in Files" })

-- Window Splitting
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split Vertically" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split Horizontally" })

-- Better Window Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move Left" })
map("n", "<C-l>", "<C-w>l", { desc = "Move Right" })
map("n", "<C-j>", "<C-w>j", { desc = "Move Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Move Up" })

-- Toggle File Explorer
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })

-- Toggle comment (like `,c<Space>`)
map("n", "<leader>c<Space>", function()
  comment_api.toggle.linewise.current()
end, { desc = "Toggle Comment Line" })

map("x", "<leader>c<Space>", function()
  comment_api.toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle Comment Block" })

-- Comment a line (like `,cc`)
map("n", "<leader>cc", function()
  comment_api.locked("comment.linewise")(vim.fn.visualmode())
end, { desc = "Comment Line" })

map("x", "<leader>cc", function()
  comment_api.locked("comment.linewise")(vim.fn.visualmode())
end, { desc = "Comment Block" })

-- Uncomment (like `,cu`)
map("n", "<leader>cu", function()
  comment_api.locked("uncomment.linewise")(vim.fn.visualmode())
end, { desc = "Uncomment Line" })

map("x", "<leader>cu", function()
  comment_api.locked("uncomment.linewise")(vim.fn.visualmode())
end, { desc = "Uncomment Block" })

-- Comment to end of line (like `,c$`)
map("n", "<leader>c$", function()
  comment_api.locked("comment.linewise.eol")(vim.fn.visualmode())
end, { desc = "Comment to End of Line" })

-- Align both sides (like `,cb`)
map("n", "<leader>cb", function()
  comment_api.locked("comment.blockwise")(vim.fn.visualmode())
end, { desc = "Align Comment Both Sides" })

map("x", "<leader>cb", function()
  comment_api.locked("comment.blockwise")(vim.fn.visualmode())
end, { desc = "Align Comment Both Sides" })

-- Align left (like `,cl`)
map("n", "<leader>cl", function()
  comment_api.locked("comment.linewise")(vim.fn.visualmode())
end, { desc = "Align Comment Left" })

map("x", "<leader>cl", function()
  comment_api.locked("comment.linewise")(vim.fn.visualmode())
end, { desc = "Align Comment Left" })

-- Minimal comment (like `,cm`)
map("n", "<leader>cm", function()
  comment_api.locked("comment.linewise")(vim.fn.visualmode())
end, { desc = "Minimal Comment" })

map("x", "<leader>cm", function()
  comment_api.locked("comment.linewise")(vim.fn.visualmode())
end, { desc = "Minimal Comment" })

-- Nested comment (like `,cn`)
map("n", "<leader>cn", function()
  comment_api.locked("comment.linewise.nested")(vim.fn.visualmode())
end, { desc = "Nested Comment" })

map("x", "<leader>cn", function()
  comment_api.locked("comment.linewise.nested")(vim.fn.visualmode())
end, { desc = "Nested Comment" })

-- Invert comment (like `,ci`)
map("n", "<leader>ci", function()
  comment_api.locked("comment.linewise.invert")(vim.fn.visualmode())
end, { desc = "Invert Comment" })

map("x", "<leader>ci", function()
  comment_api.locked("comment.linewise.invert")(vim.fn.visualmode())
end, { desc = "Invert Comment" })

-- Debugging
map("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", { desc = "Start/Continue Debugging" })
map("n", "<F10>", "<cmd>lua require'dap'.step_over()<cr>", { desc = "Step Over" })
map("n", "<F11>", "<cmd>lua require'dap'.step_into()<cr>", { desc = "Step Into" })
map("n", "<F12>", "<cmd>lua require'dap'.step_out()<cr>", { desc = "Step Out" })
map("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = "Toggle Breakpoint" })
map("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", { desc = "Toggle Debug UI" })
