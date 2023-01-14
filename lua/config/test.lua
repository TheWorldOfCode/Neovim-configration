local M = {}

function M.setup()
    -- Test config
    vim.g["test#strategy"] = "neovim"
    vim.g["test#neovim#term_position"] = "belowright"
    vim.g["test#neovim#preserve_screen"] = 1

    -- Python
    vim.g["test#python#runner"] = pyunit

    -- C && CPP 
    vim.g["test#cpp#runner"] = ctest
end

return M
