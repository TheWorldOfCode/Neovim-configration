local M = {}

local whichkey = require 'which-key'
local next = next

local conf = {
    border="single",
    position="bottom"
}

whichkey.setup(conf)

local opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}

local v_opts = {
    mode = "v", -- Visual mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}

local function normal_keymap()

    keymap_file = {

        f = {
            name = "Find",
            f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Search for file" },
            g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Search for pattern in files"},
            b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Select buffer"},
            h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help tags"},
        },
        o = {
            name = "Open",
            t = { "<cmd>Telescope<cr>", "Open Telescope" },
            p = { "<cmd>lua require('telescope').extensions.project.project()<cr>",  "Open project view" },
            g = { "<cmd>lua require('telescope').extensions.repo.list()<cr>", "Open repository list" }

        }
    }

    whichkey.register(keymap_file, opts)
end

function M.setup()

    normal_keymap()
end


return M
