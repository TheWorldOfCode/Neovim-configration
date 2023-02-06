local M = {}


function M.setup()
    require('neogen').setup {
        snippet_engine = "luasnip",
        enabled = true,
    }
   --    local opts = { noremap = true, silent = true }
-- vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts)
end

return M
