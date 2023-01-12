local M = {}

function M.setup()
  require("noice").setup {
    cmdline = {
      enabled = true,
    },
    messages = {
      enabled = false,
    },
    popupmenu = {
      enabled = false,
    },
    notify = {
      enabled = false,
    },
  }
end

return M
