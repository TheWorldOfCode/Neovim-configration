vim.g.mapleader = " " -- Set the leader to <SPACE>

local telescope = require("telescope")
local builtin = require('telescope.builtin')

--vim.keymap.set('n', '<Leader>ott', ":Telescope<CR>", {})
--vim.keymap.set('n', '<Leader>otp', telescope.extensions.project.project, {})
--vim.keymap.set('n', '<Leader>otr', telescope.extensions.repo.list, {})
--vim.keymap.set('n', '<Leader>ff', builtin.find_files, {})
--vim.keymap.set('n', '<Leader>fg', builtin.live_grep, {})
--vim.keymap.set('n', '<Leader>fb', builtin.buffers, {})
--vim.keymap.set('n', '<Leader>fh', builtin.help_tags, {})

local wrapper = require("vim_wrapper")
wrapper.keymap("n", "<Space>", "<NOP>") -- Map the space key to no operation. 
wrapper.keymap("n", "<Leader>tln", ":set number!<CR>", { silent = false }) -- Keybinding for toggling the line number 
wrapper.keymap("n", "<Leader>trn", ":set relative!<CR>", { silent = true }) -- Keybinding for toggling the relative line number
--vim.api.nvim_set_keymap("t", '<Esc>' '<C-\><C-n>', {})
