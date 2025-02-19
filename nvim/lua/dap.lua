local dap = require("dap")
local dapui = require("dapui")

dapui.setup()  -- Enables UI

-- Open DAP UI automatically
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- 🔥 Rust Debugging (Using lldb)
dap.adapters.lldb = {
  type = "executable",
  command = "/usr/bin/lldb-vscode",  -- Change this path if needed
  name = "lldb"
}
dap.configurations.rust = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}

-- 🔥 Python Debugging
dap.adapters.python = {
  type = "executable",
  command = vim.fn.exepath("python3"),
  args = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch File",
    program = "${file}",
    pythonPath = function()
      return vim.fn.exepath("python3")
    end,
  },
}

-- 🛠 Keybindings for Debugging
vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Start/Continue Debugging" })
vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "Step Out" })
vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "Toggle Debug UI" })
