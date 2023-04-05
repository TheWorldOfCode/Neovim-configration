local M = {}

function M.setup() 
    require("refatoring").setup {
        prompt_func_return_type = {
            cpp = true,
            c = true,
        },
        prompt_funct_param_type = {
            cpp = true,
            c = true
        },
    }
    require("telescope").load_extension "refactoring"
end
