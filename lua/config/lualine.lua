local M = {}

function M.setup()
    local navic = require('nvim-navic')

    local function cmake_title() 
        return "CMake:"
    end

    local function cmake_configure()

        if vim.g["cmake_configured"] then
            return "Configured"
        else
            return "Configure"
        end
    end

    local function cmake_running() 
        return vim.g["cmake_running"]
    end

    local function cmake_available()
        return vim.g["cmake_available"]
    end

    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {'filename'},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'fileformat', 'location'},
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {{navic.get_location, cond=navic.is_available}},
            lualine_x = {{cmake_title, cond=cmake_available}, {cmake_configure, cond=cmake_available}, {cmake_running, cond=cmake_available}},
            lualine_y = {},
            lualine_z = {}
        },
        inactive_winbar = {},
        extensions = {}
    }

end

return M
