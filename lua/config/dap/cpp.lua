local dap = require('dap')
local Path = require('plenary').path

local cpp_adapter = "~/.local/share/nvim/dap/cpptools/extension/debugAdapters/bin/OpenDebugAD7"

if Path:new(cpp_adapter):exists() then
    dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = cpp_adapter,
    }

    dap.configurations.cpp = {
        {
            name = "Launch file",
            type = "cppdbg",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopAtEntry = true,
        },
        {
            name = 'Attach to gdbserver :1234',
            type = 'cppdbg',
            request = 'launch',
            MIMode = 'gdb',
            miDebuggerServerAddress = 'localhost:1234',
            miDebuggerPath = '/usr/bin/gdb',
            cwd = '${workspaceFolder}',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
        },
    }

end
