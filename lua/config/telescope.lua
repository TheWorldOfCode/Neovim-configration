local M = {}

local function keybinding()

    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'

    vim.keymap.set('n', '<Leader>ot', ":Telescope<CR>", {})
    vim.keymap.set('n', '<Leader>op', telescope.extensions.project.project, {})
    vim.keymap.set('n', '<Leader>og', telescope.extensions.repo.list, {})
    vim.keymap.set('n', '<Leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<Leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<Leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<Leader>fh', builtin.help_tags, {})


end


function M.setup()
    local telescope = require 'telescope'

    telescope.setup( {
        defaults = {
            color_devicons= true
        }, 
        pickers = {
            find_files = {
                hidden = true
            },
            buffers = {
                theme  = "dropdown"
            }
        },
        extensions = {
            repo = {
                list = {
                    fd_opts = {
                        "--no-ignore-vcs",
                    },
                    search_dirs = {
                        "~/Documents",
                        "~/.config"
                    },
                },
            },
        },
    }
    )

    telescope.load_extension('project')
    telescope.load_extension('repo')
end


return M


