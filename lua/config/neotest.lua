local M = {}

function M.setup()
    require("neotest").setup {
        adapters = {
            require "neotest-python" {
                dap = { justMyCode = false },
                runner = "unittest"
            },
            require "neotest-vim-test" {
                ignore_file_types = { "python" }
            },
            require("neotest-gtest").setup({})
        },
        consumers = {
            overseer = require "neotest.consumers.overseer"
        },
        overseer = {
            enabled = true, 
            force_default = true
        }
    }
end

return M
