local M = {}

local lualine = require 'lualine'
local icons = require "config.icons"

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

local function tab_stop()
    return icons.ui.Tab .. " " .. vim.bo.shiftwidth
end

local function show_macro_recording()
    local rec_reg = vim.fn.reg_recording()

    if rec_reg == "" then
        return ""
    else
        return "recording @" .. rec_reg
    end

end

local winbar = require "config.winbar"

local config = {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = {}, -- { left = '', right = ''},
        section_separators = {},-- { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {
                "help",
                "startify",
                "dashboard",
                "packer",
                "neogitstatus",
                "Trouble",
                "dap-repl",
                "dapui_console",
                "dapui_watches",
                "dapui_stacks",
                "dapui_breakpoints",
                "dapui_scopes",
            },
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {
            'branch',
            'diff',
            {
                'diagnostics',
                sources = {"nvim_diagnostic"},
                diagostics_color = {
                    error= "DiagnosticError",
                    warn = "DiagonistcWarn",
                    info = "DiagonistcInfo",
                    hint = "DiagonistcHint",
                },
                colored = true,
            }
        },
        lualine_c = {'filename'},
        lualine_x = {{show_macro_recording}},
        lualine_y = {{tab_stop},'encoding', 'fileformat', 'filetype', 'progress'},
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
        lualine_b = {winbar.get_winbar},
        lualine_c = {},
        lualine_x = {{cmake_title, cond=cmake_available}, {cmake_configure, cond=cmake_available}, {cmake_running, cond=cmake_available}},
        lualine_y = {},
        lualine_z = {}
    },
    inactive_winbar = {},
    extensions = {}
}

function M.setup()
    lualine.setup(config)
end

return M
