
vim.g.mapleader = " " -- Set the leader to <SPACE>



vim.o.number = true -- Enable line number
vim.o.relativenumber = true -- Enable relative number

vim.o.backspace = [[indent,eol,start]] -- Allow backspacing over everything in insert mode
vim.o.ruler = true -- show the cursor position all the time
vim.o.showcmd = true -- Display incomplete commands

vim.o.ttimeout = true -- time out for key codes
vim.o.ttimeoutlen= 50 -- Wait up to 50ms after Esc for special key

vim.o.tabstop = 4 -- 
vim.o.softtabstop = 4 --
vim.o.shiftwidth = 4 --
vim.o.expandtab = true -- Expand tabs to space
vim.o.autoindent = true -- Auto indent lines
vim.o.smartindent = true 

vim.o.list = true -- Show charector for tabs and spaces
if vim.fn.has('multi_byte') == 1 and vim.o.encoding == 'utf-8' then
  vim.o.listchars = [[tab:▸ ,extends:❯,precedes:❮,nbsp:±,trail:.]]
else
  vim.o.listchars = [[tab:> ,extends:>,precedes:<,nbsp:.,trail:_]]
end

require("plugins").setup()
require("cmake")
