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
    lsp = {
        hover = {
            enabled = false,
        },
        signature ={
            enabled = false,
        },
    },
  }
end

return M
